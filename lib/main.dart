import 'package:flutter/material.dart';
import 'package:supabase_crud_and_auth/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: "https://yprmevdbpxszsqugdmka.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inlwcm1ldmRicHhzenNxdWdkbWthIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk5NjY0NTUsImV4cCI6MjA4NTU0MjQ1NX0.p4oKIxuboOV-n5CQVfZGleaEmuiUg0yuZae6lCgTvXg",
  );
  runApp(SupabaseCrudAndAuth());
}
