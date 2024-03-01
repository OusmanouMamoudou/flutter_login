import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/login.dart';

class Logged extends StatefulWidget {
  const Logged({super.key});

  @override
  State<Logged> createState() => _LoggedState();
}

class _LoggedState extends State<Logged> {
  final auth = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = auth.currentUser;
      if (user != null) {
        loggedUser = user; //Have logged Credentials
        ///Récupère les informations d'utilisateur connecté
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${loggedUser?.email}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w900)),
            TextButton(
              onPressed: () {
                auth.signOut(); //Signing Out the user
                //Déconnecte l'utilisateur
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const Login()),
                  ),
                );
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
