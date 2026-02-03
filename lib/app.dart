import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/sign_in_provider.dart';
import 'package:supabase_crud_and_auth/controllers/sign_up_provider.dart';
import 'package:supabase_crud_and_auth/controllers/todo_provider.dart';
import 'package:supabase_crud_and_auth/screens/home_screen.dart';
import 'package:supabase_crud_and_auth/screens/sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCrudAndAuth extends StatelessWidget {
  const SupabaseCrudAndAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoController()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: Supabase.instance.client.auth.onAuthStateChange,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            if (!snapshot.hasData || snapshot.data?.session == null) {
              return SignIn();
            }
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
