// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:uuid/uuid.dart';

// class ProductAddController extends GetxController {
//   final fromKey= GlobalKey<FormState>();
//   final TextEditingController name= TextEditingController();
//   final TextEditingController edition= TextEditingController();
//   final TextEditingController price= TextEditingController();

//   final FirebaseStorage firebaseStorage= FirebaseStorage.instance;

//   File? pickedImage;
//   Uint8List img= Uint8List(8);


//   void addProduct(BuildContext context)async{
//     final isValid= fromKey.currentState!.validate();
//     FocusScope.of(context).unfocus();

//     if (isValid) {
//       fromKey.currentState!.save();
//       if (pickedImage==null) {
//         Get.snackbar('title', 'Please pick up an image');
//         return;
//       }

//       final uuid= Uuid().v4();
//       try {
//       final storageRef=  firebaseStorage.ref().child('bookImage').child(uuid + 'jpg');
//       final TaskSnapshot taskSnapshot= await storageRef.putFile(pickedImage!);
//       final imageUri = taskSnapshot.ref.getDownloadURL();
//       await FirebaseFirestore.instance.collection('books').doc(uuid).set({
//       'id':uuid,
//       'book_name':name.text.trim(),
//       'edition':edition.text.trim(),
//       'price':price.text.trim(),
//       'img':imageUri,

//       });

//     clearFrom();
//       Fluttertoast.showToast(
//         msg: 'Product uploaded succesfully',
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.CENTER,
//         );
      
//       }on FirebaseException catch (e) {
//       Get.snackbar('title', e.message.toString());
//       update();
//       } catch (e){
//         Get.snackbar('title', '$e');
//         update();
//       } finally{
//         update();
//       }
//     }
//   }

//   clearFrom(){
//     name.clear();
//     edition.clear();
//     price.clear();
//     update();
//     pickedImage=null;
//   }
  
// }