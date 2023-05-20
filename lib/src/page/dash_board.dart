import 'package:book_town_admin/src/page/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('books').snapshots(),
        builder: (context, snapshot) {
           if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final items = snapshot.data!.docs;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Get.to(HomePage());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Center(child: Text('Add Product',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
              ),
              
            ),
            SizedBox(height: 20,),
            Center(child: Text("Total book: ${snapshot.data!.size}")),
             Expanded(
               child: Padding(
                 padding:  EdgeInsets.only(left: 35),
                 child: GridView.builder(
                   gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                   scrollDirection: Axis.vertical,
                   itemCount: items.length,
                   itemBuilder: (context, index) {
                    final item= items[index];
                   return Container(
                     width: 160,
                     decoration: BoxDecoration(
                     
                     ),
                   child: Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 5),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: 5,),
                         Container(
                           height: 100,
                           width: 100,
                           child: Image.network('${item['img']}')),
                         Text('${item['book_name']}',style: TextStyle(fontWeight: FontWeight.bold),),
                         Text('Edition: ${item['edition']}'),
                         Text('৳: ${item['price']}'),
                       ],
                     ),
                   ),
                   );
                   }, 
                   ),
               ),
             ),
          ],
        );
        },
      ),
    );
  }
}