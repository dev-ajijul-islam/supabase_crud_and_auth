import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/sign_up_provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpProvider signUpProvider = context.read<SignUpProvider>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: signUpProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  "Sign Up",
                  textAlign: .center,
                  style: TextStyle(fontSize: 20, fontWeight: .w400),
                ),
                Text(
                  "You have to sign up to continue the todo App",
                  textAlign: .center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: signUpProvider.emailTEController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Email";
                    }
                    if (!value.contains(".com") || !value.contains("@")) {
                      return "Please Enter a valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  obscuringCharacter: "*",
                  obscureText: true,
                  controller: signUpProvider.passwordTEController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    }
                    if (value.length < 6) {
                      return "Please Enter at lest 6 character";
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 10),
                Consumer<SignUpProvider>(
                  builder: (context, provider, child) => SizedBox(
                    height: 40,
                    width: .infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(10),
                        ),
                      ),
                      onPressed: () => provider.isSigningUp
                          ? null
                          : handleSignUp(provider, context),
                      child: provider.isSigningUp
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Sign Up"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleSignUp(SignUpProvider provider, BuildContext context) async {
    final isSuccess = await provider.signUp();
    if (isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "SignUp success",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("SignUp Failed", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
