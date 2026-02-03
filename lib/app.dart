import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/todo_provider.dart';
import 'package:supabase_crud_and_auth/screens/home_screen.dart';
import 'package:supabase_crud_and_auth/screens/sign_up.dart';

class SupabaseCrudAndAuth extends StatelessWidget {
  const SupabaseCrudAndAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoController()),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SignUp()),
    );
  }
}
