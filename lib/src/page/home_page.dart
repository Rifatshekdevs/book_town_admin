// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   final name = TextEditingController();
  final price = TextEditingController();
  final edition = TextEditingController();
  final author = TextEditingController();
  File? productImage;
  Future<void> addProduct() async {
    final firestore = FirebaseFirestore.instance;
 
    final productRef = await firestore.collection('books').add({
      'book_name': name.text,
      'price': price.text,
      'edition':edition.text,
      'author':author.text,
    });
    final productId = productRef.id;
    if (productImage != null) {
      final storageRef =
          FirebaseStorage.instance.ref().child('product_images/$productId.jpg');
      final uploadTask = storageRef.putFile(productImage!);
      await uploadTask.whenComplete(() => null);
      final imageUrl = await storageRef.getDownloadURL();
      await firestore.collection('books').doc(productId).update({
        'img': imageUrl,
      });

      Get.back();
    }
    name.clear();
    price.clear();
    edition.clear();
    author.clear();
    setState(() {
      productImage = null;
    });
  }


   Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        productImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                ),
                child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text('Book name*'),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: name,
                          // key: ValueKey('name'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter a name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10,),
                        Text('author name*'),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: author,
                          // key: ValueKey('author'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 1.0)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter a author name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('price in ৳'),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  child: TextFormField(
                                    controller: price,
                                    // key: ValueKey('price'),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter a name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('book edition'),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  child: TextFormField(
                                    controller:edition,
                                    // key: ValueKey('edition'),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1.0)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'please enter a edition';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 15,),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child:productImage!=null?  ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(productImage!),
                              ):InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: Column(
                                 children: [
                                  SizedBox(height: 15,),
                                  Icon(Icons.image),
                                  SizedBox(height: 5,),
                                  Text('choose a image',style: TextStyle(fontSize: 12),),
                                 ],
                                ),
                              )
                            ), 
                            SizedBox(width: 15,),
                          Column(
                            children: [
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: Text('Update image',style: TextStyle(color: Colors.blueAccent,fontSize: 13),)),
                            ],
                          )
                          ],
                        ),
                      SizedBox(height: 25,),
                        Padding(
                          padding:  EdgeInsets.only(left: 135),
                          child: ElevatedButton(onPressed: () {
                            addProduct();
                            
                          }, child: Text('Upload')),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
