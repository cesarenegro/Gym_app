class SupabaseConfig {
  static const String url = 'https://tkrfvpxjbdqgmwztkkyd.supabase.co';
  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'YOUR_SUPABASE_ANON_KEY',
  );
}
