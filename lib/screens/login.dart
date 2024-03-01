import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_snack.dart';
import 'package:login/const.dart';
import 'package:login/screens/logged.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Booleans for loading screen and Hide/Show password
  //Booléens pour le chargement d'écran et Caché/affiché le mot de passe
  bool isLoading = false;
  bool isHide = true;

//Controllers for inputs Text
//Controlleurs pour récuperer les textes saisies
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Key to check Validation Form
  //Clé pour vérifier la validation du formulaire
  final formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    var labelTextStyle = TextStyle(
      color: Colors.black,
      fontSize: height * 0.02,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height * 0.04,
              horizontal: width * 0.05,
            ),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.13),
                    Text("Welcome Back!",
                        style: TextStyle(
                            fontSize: height * 0.05,
                            fontWeight: FontWeight.w900)),
                    Text("Please enter your details.",
                        style: TextStyle(
                            fontSize: height * 0.02,
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: height * 0.05),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              validator: (value) =>
                                  value == " " || value!.isEmpty
                                      ? 'Please provide your email'
                                      : null,
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: kInputDecoration.copyWith(
                                labelText: 'Email',
                                labelStyle: labelTextStyle,
                              )),
                          SizedBox(height: height * 0.025),
                          TextFormField(
                              validator: (value) =>
                                  value == " " || value!.isEmpty
                                      ? 'Please enter a password'
                                      : null,
                              controller: passwordController,
                              keyboardType: TextInputType.emailAddress,
                              obscureText: isHide ? true : false,
                              decoration: kInputDecoration.copyWith(
                                //kInputDecoration is in the lib/const
                                labelText: 'Password',
                                labelStyle: labelTextStyle,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isHide = !isHide;
                                      });
                                    },
                                    icon: Icon(
                                      isHide //Swap Icons depends on isHide Boolean
                                          //Changer les icônes selon la valeur du Booléen isHide
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                    )),
                              )),
                          MyButton(
                            //MyButton is in the lib/components/MyButton
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                }); //Start Loading
                                try {
                                  await auth.signInWithEmailAndPassword(
                                    email: emailController.text.toString(),
                                    password: passwordController.text,
                                  );

                                  //Sing in User with Email and Password using Firebase Auth
                                  //Connexion d'utilisateur en utilisant l'email et le mot de passe de Firebase Auth

                                  if (!context.mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => const Logged()),
                                    ),
                                  ); //Navigate to the Logged Screen
                                  //Aller à l'écran Logged
                                } catch (e) {
                                  MySnackBar.mySnackBar(
                                    //MySnackBar is in lib/components/MySnackBar
                                    context,
                                    e.toString(),
                                  ); //Display To error
                                  //Affiche l"érreur
                                }
                                setState(() {
                                  isLoading = false;
                                }); //End  Loading
                                emailController.clear();
                                passwordController.clear();
                              }
                            },
                            text: 'Login',
                          ),
                          Row(children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                MySnackBar.mySnackBar(
                                    context, "I'm Doing Nothing right Now ^_^");
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ])
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
