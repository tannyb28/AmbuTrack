// import 'package:ambutrack/authentication/login_screen.dart';
import 'package:ambutracker/authentication/login_screen.dart';
import 'package:ambutracker/global/global.dart';
import 'package:ambutracker/mainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:ambutrack/mainScreen/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      // send user to home screen
      if(await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser!;
        Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else
        // send user to login screen
        // Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen())
        Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.authStateChanges(), 
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return const LoginScreen();
    //     }
    //     return const MainScreen();
    //   }
    // );
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/ambulance.png"),
        
              const Text(
                "AmbuTrack",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}