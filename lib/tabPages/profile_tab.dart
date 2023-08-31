import 'package:ambutracker/authScreens/splash_screen.dart';
import 'package:ambutracker/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  User? user = FirebaseAuth.instance.currentUser;

  
  @override
  Widget build(BuildContext context) {
    String? displayName = user?.displayName;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/ambulance.png'), // Replace with your profile image
              ),

              const SizedBox(height: 20),

               Text(
                displayName ?? '', // Replace with user's name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Software Developer', // Replace with user's role or description
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  fAuth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => const MySplashScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), 
      )
      
      
    );
  
  }
}