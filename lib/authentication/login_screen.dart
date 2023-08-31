import 'package:ambutracker/authScreens/splash_screen.dart';
import 'package:ambutracker/authentication/signup_screen.dart';
import 'package:ambutracker/global/global.dart';
import 'package:ambutracker/mainScreen/main_screen.dart';
import 'package:ambutracker/utils/fire_auth.dart';
import 'package:ambutracker/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if(!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid", textColor: Colors.red, fontSize: 14);
    }
    else if(passwordTextEditingController.text.length < 6) {
      if(passwordTextEditingController.text.isEmpty) {
        Fluttertoast.showToast(msg: "Password is required", textColor: Colors.red, fontSize: 14);
      } else {
        Fluttertoast.showToast(msg: "Password must be at least 6 characters", textColor: Colors.red, fontSize: 14);
      }
    }
    else {
      loginDriverNow();
    }
  }
  loginDriverNow() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c){
        return ProgressDialog(message: "Authenticating, please wait...");
      }
    );

    try {
      final UserCredential userCredential = await fAuth.signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      );

      // Successfully signed in
      final User? firebaseUser = userCredential.user;
        if(firebaseUser != null) {
        currentFirebaseUser = firebaseUser;
        Fluttertoast.showToast(msg: "Login Successful.", textColor: Colors.red, fontSize: 14);
        Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Login failed", textColor: Colors.red, fontSize: 14);
      }
      // Continue with further actions or UI updates
    } catch (e) {
      // An error occurred during sign-in
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: "Error: $e",
        textColor: Colors.red,
        fontSize: 14,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/ambulance.png"),
              ),
              const SizedBox(height: 16,),

              const Text(
                "Login as a Driver",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16,),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                )
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                )
              ),
              const SizedBox(height: 10,),

              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) => const SignUpScreen()));
                },
              )
            ]
        
          ),
        )
      )
    );
  }
}