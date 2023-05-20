import 'package:book_town_admin/src/page/dash_board.dart';
import 'package:book_town_admin/src/page/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardMain extends StatefulWidget {
  const DashBoardMain({super.key});

  @override
  State<DashBoardMain> createState() => _DashBoardMainState();
}

class _DashBoardMainState extends State<DashBoardMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Semister wise bokk'),
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('Category wise bokk'),
            ),
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('All book'),
            ),
            ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure?',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancle',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Get.to(SignIn());
                              },
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      );
                    });
              },
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard options',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(DashBoard());
                        },
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor),
                          child: Column(
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                size: 100,
                              ),
                              Text('Semister wise bokk'),
                              // Text("${getTotal()}"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor),
                        child: Column(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 100,
                            ),
                            Text('Category wise bokk'),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor),
                        child: Column(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 100,
                            ),
                            Text('All bokk'),
                          ],
                        ),
                      ),
                      Container(
                        height: 160,
                        width: 160,
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor),
                        child: Column(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              size: 100,
                            ),
                            Text('Author'),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
