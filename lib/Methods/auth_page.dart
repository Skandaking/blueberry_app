import 'package:blueberry_app/componets/bottom_navbar.dart';
//import 'package:blueberry_app/pages/home_page.dart';
import 'package:blueberry_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return const NavbarBottom();
          }

          // Check if the user is not logged in
          else {
            return LoginPage(
              onTap: () {},
            );
          }
        },
      ),
    );
  }
}
