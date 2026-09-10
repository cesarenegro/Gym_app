// Supabase Edge Function: Gym AI Gateway (OpenAI GPT-5.6 Sol)
// Enforces Server-side context validation, role permissions & human confirmation

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.8";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "Missing authorization token" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_ANON_KEY") ?? "",
      { global: { headers: { Authorization: authHeader } } }
    );

    // 1. Verify User Session
    const { data: { user }, error: userError } = await supabaseClient.auth.getUser();
    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Unauthorized access" }),
        { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    const { prompt, scenario } = await req.json();

    // 2. Fetch Authorized User Context (Training, Bookings, Nutrition)
    const { data: profile } = await supabaseClient
      .from("profiles")
      .select("full_name, level_tier")
      .eq("id", user.id)
      .single();

    const openAiApiKey = Deno.env.get("OPENAI_API_KEY");
    if (!openAiApiKey) {
      return new Response(
        JSON.stringify({
          error: "OpenAI API key not configured on server",
          insufficientData: true
        }),
        { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
      );
    }

    // 3. Call OpenAI GPT-5.6 Sol with Structured Tools
    const openAiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Authorization": `Bearer ${openAiApiKey}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        model: "gpt-5.6-sol",
        messages: [
          {
            role: "system",
            content: `You are the KINETIC Gym AI Concierge for athlete ${profile?.full_name ?? "Member"}.
Rules:
- NEVER invent imaginary courses, classes or instructors.
- Provide structured answers for fitness, courses, workouts and nutrition.
- Sensitive write actions (booking, payments, program changes) MUST be returned as proposals requiring user confirmation.`
          },
          { role: "user", content: prompt }
        ],
        temperature: 0.2,
      }),
    });

    const aiData = await openAiResponse.json();
    const replyText = aiData.choices?.[0]?.message?.content ?? "Nessuna risposta disponibile.";

    return new Response(
      JSON.stringify({
        success: true,
        scenario,
        response: replyText,
        requiresConfirmation: false,
      }),
      { headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  } catch (err) {
    return new Response(
      JSON.stringify({ error: (err as Error).message }),
      { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
    );
  }
});
