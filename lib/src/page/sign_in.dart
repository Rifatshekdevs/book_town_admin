// ignore_for_file: unused_local_variable

import 'package:book_town_admin/src/page/dash_board_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void signIntoFirebase() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );
      Get.to(DashBoardMain());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign in Success")));
      setState(() {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CurveNeviBar(
        //               page_index: 0,
        //             )));
      });
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
        body: Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                'Log in',
                style: TextStyle(
                    color: Color(0xffEA091F),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "write email",
                    labelText: "Email",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _passController,
                decoration: InputDecoration(
                    hintText: "write password",
                    labelText: "Password",
                    border: OutlineInputBorder()),
              ),
              if (user == null)
                TextButton(
                    onPressed: () {
                      signIntoFirebase();
                     
                    },
                    child: Text("Sign In")),
              if (user != null)
                TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {});
                    },
                    child: Text("Sign Out")),
              if (user != null) Text("Signed in " + user.email.toString()),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 40,
              //     ),
              //     Text("You don't have any account"),
              //     TextButton(
              //         onPressed: () {
              //           Navigator.push(context,
              //               MaterialPageRoute(builder: (context) => SignUp()));
              //         },
              //         child: Text("Sign UP")),
              //   ],
              // )
            ],
          )),
    ));
  }
}
