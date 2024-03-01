import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/screens/login.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that Flutter bindings are initialized before running the app
  // Assurez-vous que les liens Flutter sont initialisés avant de lancer l'application
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  // Initialisez Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  // Lancez l'application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login UI', // App title displayed on the device's task switcher
      // Titre de l'application affiché dans le sélecteur de tâches du périphérique
      theme: ThemeData(
        // App theme settings
        // Paramètres de thème de l'application
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green), // Color scheme for the app
        // Schéma de couleurs de l'application
        useMaterial3: true, // Indicates that Material Design 3 is used
        // Indique que le Material Design 3 est utilisé
      ),
      home: const Login(), // Set the login screen as the home screen
      // Définir l'écran de connexion comme écran d'accueil
    );
  }
}
