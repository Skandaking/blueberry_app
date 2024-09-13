import 'package:blueberry_app/Methods/google_auth.dart';
import 'package:blueberry_app/componets/my_button.dart';
import 'package:blueberry_app/componets/my_textfield.dart';
import 'package:blueberry_app/componets/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

//sign user in
  void signUserIn() async {
    // show loading
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      //show error message
      showErrorMessage(e.code);
    }
  }

  //show error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          title: Center(
              child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 50),

                //logo
                Container(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 10.0),
                  child: Image.asset(
                    'lib/images/logo.png', // Adjust the path based on your project structure
                    width: 300,
                    height: 150, // Set the width as per your requirement
                  ),
                ),

                //Welcome text
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Welcome to Bueberry Travel App!',
                    style: TextStyle(
                      color: Colors.grey[1200],
                      fontSize: 20,
                    ),
                  ),
                ),

                //username textfield
                MyTextFilled(
                  controller: emailController,
                  hinttext: 'Email',
                  obsecureText: false,
                ),

                //password textfield
                MyTextFilled(
                  controller: passwordController,
                  hinttext: 'Password',
                  obsecureText: true,
                ),

                //forgot password?
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 25.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ],
                  ),
                ),

                //my sign in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),

                //or continue with
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //google + facebook sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                        onTap: () => GoogleAuth().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'),

                    const SizedBox(width: 25),

                    //facebook button
                    SquareTile(onTap: () {}, imagePath: 'lib/images/fb.png'),
                  ],
                ),

                const SizedBox(height: 50),

                // ...

                //don't have an account? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(color: Colors.grey[800], fontSize: 15),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigate to RegisterPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(onTap: widget.onTap),
                          ),
                        );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),

// ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
