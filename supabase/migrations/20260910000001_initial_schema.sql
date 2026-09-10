-- ============================================================================
-- GYM PLATFORM — MASTER SUPABASE POSTGRESQL SCHEMA & RLS POLICIES
-- ============================================================================

-- 1. ENUMS
CREATE TYPE user_role AS ENUM ('member', 'trainer', 'gym_admin', 'platform_admin');
CREATE TYPE daily_category AS ENUM ('workout_of_day', 'meal_of_day', 'trainer_tip', 'challenge_of_day');
CREATE TYPE content_source AS ENUM ('platform', 'gym', 'trainer');
CREATE TYPE booking_status AS ENUM ('confirmed', 'waitlisted', 'cancelled', 'attended', 'no_show');
CREATE TYPE post_type AS ENUM ('standard', 'achievement', 'announcement', 'trainer_tip');
CREATE TYPE moderation_status AS ENUM ('published', 'pending', 'reported', 'hidden', 'rejected', 'archived');
CREATE TYPE seller_type AS ENUM ('gym_official', 'member');
CREATE TYPE product_status AS ENUM ('pending_review', 'published', 'reserved', 'sold', 'rejected', 'archived');
CREATE TYPE plan_source AS ENUM ('professional_assigned', 'ai_suggested');

-- 2. PROFILES (Extends auth.users)
CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    gym_id UUID,
    full_name TEXT NOT NULL,
    avatar_url TEXT,
    role user_role NOT NULL DEFAULT 'member',
    level_tier TEXT DEFAULT 'LIVELLO BLACK',
    phone TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 3. GYMS
CREATE TABLE public.gyms (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    slug TEXT UNIQUE NOT NULL,
    logo_url TEXT,
    address TEXT,
    city TEXT,
    country TEXT DEFAULT 'IT',
    contact_email TEXT,
    settings JSONB DEFAULT '{}'::jsonb,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 4. DAILIES (Editorial Micro-content, >= 90 preloaded items)
CREATE TABLE public.dailies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID REFERENCES public.gyms(id) ON DELETE SET NULL,
    author_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    category daily_category NOT NULL,
    title TEXT NOT NULL,
    subtitle TEXT,
    duration_metric TEXT,
    image_url TEXT NOT NULL,
    video_url TEXT,
    short_text TEXT NOT NULL,
    bullet_points JSONB DEFAULT '[]'::jsonb,
    expanded_content TEXT,
    cta_label TEXT NOT NULL,
    cta_action TEXT NOT NULL,
    source content_source NOT NULL DEFAULT 'platform',
    moderation_status moderation_status NOT NULL DEFAULT 'published',
    published_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 5. COURSES & SESSIONS
CREATE TABLE public.courses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID NOT NULL REFERENCES public.gyms(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    description TEXT,
    image_url TEXT,
    default_duration_min INT NOT NULL DEFAULT 45,
    default_capacity INT NOT NULL DEFAULT 15,
    intensity_level TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.course_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    course_id UUID NOT NULL REFERENCES public.courses(id) ON DELETE CASCADE,
    trainer_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    room TEXT NOT NULL,
    start_time TIMESTAMPTZ NOT NULL,
    duration_min INT NOT NULL,
    capacity INT NOT NULL,
    booked_count INT NOT NULL DEFAULT 0,
    is_cancelled BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 6. BOOKINGS (With server-side capacity check protection)
CREATE TABLE public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL REFERENCES public.course_sessions(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    status booking_status NOT NULL DEFAULT 'confirmed',
    waitlist_position INT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(session_id, user_id)
);

-- 7. TRAINING & WORKOUT LOGS
CREATE TABLE public.workout_plans (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    trainer_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    title TEXT NOT NULL,
    phase TEXT NOT NULL,
    split_name TEXT NOT NULL,
    duration_minutes INT NOT NULL,
    exercises JSONB NOT NULL DEFAULT '[]'::jsonb,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.workout_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    workout_plan_id UUID REFERENCES public.workout_plans(id) ON DELETE SET NULL,
    duration_seconds INT NOT NULL,
    logged_exercises JSONB NOT NULL DEFAULT '[]'::jsonb,
    rpe_rating INT,
    notes TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 8. NUTRITION
CREATE TABLE public.nutrition_targets (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE UNIQUE,
    target_calories INT NOT NULL,
    target_protein_g INT NOT NULL,
    target_carbs_g INT NOT NULL,
    target_fat_g INT NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.nutrition_meals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    date DATE NOT NULL DEFAULT CURRENT_DATE,
    meal_type TEXT NOT NULL,
    title TEXT NOT NULL,
    calories INT NOT NULL,
    protein_g INT NOT NULL,
    carbs_g INT NOT NULL,
    fat_g INT NOT NULL,
    foods JSONB DEFAULT '[]'::jsonb,
    source plan_source NOT NULL DEFAULT 'professional_assigned',
    is_completed BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 9. COMMUNITY & MODERATION
CREATE TABLE public.community_posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID NOT NULL REFERENCES public.gyms(id) ON DELETE CASCADE,
    author_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    type post_type NOT NULL DEFAULT 'standard',
    content TEXT NOT NULL,
    media_urls JSONB DEFAULT '[]'::jsonb,
    likes_count INT NOT NULL DEFAULT 0,
    comments_count INT NOT NULL DEFAULT 0,
    moderation_status moderation_status NOT NULL DEFAULT 'published',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.moderation_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reporter_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    target_type TEXT NOT NULL, -- 'post', 'comment', 'product', 'user'
    target_id UUID NOT NULL,
    reason TEXT NOT NULL,
    status moderation_status NOT NULL DEFAULT 'pending',
    notes TEXT,
    resolved_by UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE public.blocked_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    blocker_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    blocked_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(blocker_id, blocked_id)
);

-- 10. MARKETPLACE
CREATE TABLE public.marketplace_products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gym_id UUID NOT NULL REFERENCES public.gyms(id) ON DELETE CASCADE,
    seller_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    seller_type seller_type NOT NULL,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    price_cents INT NOT NULL,
    description TEXT NOT NULL,
    condition TEXT NOT NULL,
    size_or_variant TEXT,
    images JSONB NOT NULL DEFAULT '[]'::jsonb,
    status product_status NOT NULL DEFAULT 'published',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS) POLICIES — DENY BY DEFAULT
-- ============================================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.gyms ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.dailies ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.course_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workout_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.workout_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nutrition_targets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.nutrition_meals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.community_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.moderation_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.blocked_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.marketplace_products ENABLE ROW LEVEL SECURITY;

-- Profiles
CREATE POLICY "Users can view active gym profiles" ON public.profiles FOR SELECT TO authenticated USING (true);
CREATE POLICY "Users can edit own profile" ON public.profiles FOR UPDATE TO authenticated USING (auth.uid() = id);

-- Dailies (Published items readable by all authenticated members)
CREATE POLICY "Members can view published dailies" ON public.dailies FOR SELECT TO authenticated USING (moderation_status = 'published');

-- Courses & Sessions
CREATE POLICY "Members can view courses" ON public.courses FOR SELECT TO authenticated USING (true);
CREATE POLICY "Members can view course sessions" ON public.course_sessions FOR SELECT TO authenticated USING (true);

-- Bookings (Private to user)
CREATE POLICY "Users view own bookings" ON public.bookings FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users insert own booking" ON public.bookings FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users update own booking" ON public.bookings FOR UPDATE TO authenticated USING (auth.uid() = user_id);

-- Workout Plans & Logs (Strict Privacy)
CREATE POLICY "Users view own workout plans" ON public.workout_plans FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users view own workout logs" ON public.workout_logs FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users insert own workout logs" ON public.workout_logs FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);

-- Nutrition (Strict Privacy)
CREATE POLICY "Users view own nutrition targets" ON public.nutrition_targets FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users view own meals" ON public.nutrition_meals FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "Users update own meals" ON public.nutrition_meals FOR ALL TO authenticated USING (auth.uid() = user_id);

-- Community (Published posts viewable, excluded blocked users)
CREATE POLICY "Members view published community posts" ON public.community_posts FOR SELECT TO authenticated USING (
    moderation_status = 'published' AND author_id NOT IN (
        SELECT blocked_id FROM public.blocked_users WHERE blocker_id = auth.uid()
    )
);
CREATE POLICY "Users insert own posts" ON public.community_posts FOR INSERT TO authenticated WITH CHECK (auth.uid() = author_id);

-- Moderation
CREATE POLICY "Users create reports" ON public.moderation_reports FOR INSERT TO authenticated WITH CHECK (auth.uid() = reporter_id);
CREATE POLICY "Users manage own blocks" ON public.blocked_users FOR ALL TO authenticated USING (auth.uid() = blocker_id);

-- Marketplace
CREATE POLICY "Members view published marketplace listings" ON public.marketplace_products FOR SELECT TO authenticated USING (
    status = 'published' AND seller_id NOT IN (
        SELECT blocked_id FROM public.blocked_users WHERE blocker_id = auth.uid()
    )
);
CREATE POLICY "Users insert own product listing" ON public.marketplace_products FOR INSERT TO authenticated WITH CHECK (auth.uid() = seller_id);
