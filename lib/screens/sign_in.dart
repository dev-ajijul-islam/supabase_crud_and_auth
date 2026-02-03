import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_crud_and_auth/controllers/sign_in_provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInProvider signInProvider = context.read<SignInProvider>();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: signInProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text(
                  "Sign In",
                  textAlign: .center,
                  style: TextStyle(fontSize: 20, fontWeight: .w400),
                ),
                Text(
                  "You have to sign in to continue the todo App",
                  textAlign: .center,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: signInProvider.emailTEController,
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
                  controller: signInProvider.passwordTEController,
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
                Consumer<SignInProvider>(
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
                      onPressed: () => provider.isSigningIn
                          ? null
                          : handleSignUp(provider, context),
                      child: provider.isSigningIn
                          ? SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text("Sign In"),
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

  void handleSignUp(SignInProvider provider, BuildContext context) async {
    final isSuccess = await provider.signIn();
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
