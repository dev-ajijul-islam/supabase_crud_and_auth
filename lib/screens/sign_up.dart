import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
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
                SizedBox(
                  height: 40,
                  width: .infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Sign Up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
