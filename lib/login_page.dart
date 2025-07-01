import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'location_page.dart';

class CarThemeLoginPage extends StatefulWidget {
  const CarThemeLoginPage({super.key});

  @override
  _CarThemeLoginPageState createState() => _CarThemeLoginPageState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController nameController = TextEditingController();

class _CarThemeLoginPageState extends State<CarThemeLoginPage> {
  bool isCreatingAccount = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Image.asset(
                "assets/Images/img.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.7)),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 50),
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: isCreatingAccount ? buildSignUpForm() : buildLoginForm(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return Column(
      key: ValueKey(1),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.speed, size: 100, color: Colors.redAccent),
        SizedBox(height: 20),
        Text(
          "DriveIn Access",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        TextField(
          controller: emailController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Driver ID",
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.person, color: Colors.redAccent),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Access Code",
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final driverId = emailController.text.trim();
            final password = passwordController.text.trim();

            if (driverId.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please enter Driver ID and Password")),
              );
              return;
            }

            try {
              final firestore = FirebaseFirestore.instance;

              final result = await firestore
                  .collection("drivers")
                  .where("driverId", isEqualTo: driverId)
                  .get();

              if (result.docs.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Invalid Driver ID")),
                );
                return;
              }

              final userEmail = result.docs.first['email'];

              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: userEmail, password: password);

              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', true);

              final selectedCity = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LocationSelectionPage()),
              );

              if (selectedCity != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen(selectedCity: selectedCity)),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Login Error: ${e.toString()}")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text("Ignite Engine"),
        ),
        SizedBox(height: 15),
        TextButton(
          onPressed: () {
            setState(() {
              isCreatingAccount = true;
            });
          },
          child: Text("Create Driver ID", style: TextStyle(color: Colors.redAccent, fontSize: 16)),
        ),
      ],
    );
  }

  Widget buildSignUpForm() {
    return Column(
      key: ValueKey(2),
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.person_add, size: 100, color: Colors.redAccent),
        SizedBox(height: 20),
        Text("Create Your Driver ID",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 20),
        TextField(
          controller: nameController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Full Name",
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.person, color: Colors.redAccent),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: emailController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.email, color: Colors.redAccent),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passwordController,
          obscureText: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Create Password",
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.lock, color: Colors.redAccent),
            filled: true,
            fillColor: Colors.white10,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final name = nameController.text.trim();
            final email = emailController.text.trim();
            final password = passwordController.text.trim();

            if (name.isEmpty || email.isEmpty || password.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill in all fields")),
              );
              return;
            }

            try {
              final auth = FirebaseAuth.instance;
              final firestore = FirebaseFirestore.instance;

              await auth.createUserWithEmailAndPassword(email: email, password: password);

              final driverId = "DRIVE${DateTime.now().millisecondsSinceEpoch % 1000000}";

              await firestore.collection("drivers").doc(driverId).set({
                'name': name,
                'email': email,
                'driverId': driverId,
              });

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Driver ID Created"),
                  content: Text("Your Driver ID is: $driverId\nUse it to log in."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
              );

              setState(() {
                isCreatingAccount = false;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Signup Error: ${e.toString()}")),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          child: Text("Create Account"),
        ),
        SizedBox(height: 15),
        TextButton(
          onPressed: () {
            setState(() {
              isCreatingAccount = false;
            });
          },
          child: Text("Already have an account? Login", style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}
