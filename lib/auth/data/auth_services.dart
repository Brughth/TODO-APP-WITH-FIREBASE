import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app_with_firebase/auth/data/user_model.dart';

class AuthServices {
  final firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    var credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return await getUserInfo(credential.user!.uid);
  }

  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String image,
  }) async {
    var credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(credential);
    await updateUse(
      id: credential.user!.uid,
      data: {
        'id': credential.user!.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'image': image,
      },
    );

    return loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  updateUse({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    return await userCollection.doc(id).set(
          data,
          SetOptions(
            merge: true,
          ),
        );
  }

  Future<UserModel> getUserInfo(String id) async {
    var doc = await userCollection.doc(id).get();
    var data = doc.data();
    return UserModel.fromJson(data!);
  }

  Future<String> uploadFileToFirestore(File file) async {
    final ref = FirebaseStorage.instance.ref();
    var uploadTask = await ref.child('users').putFile(file);
    return uploadTask.ref.getDownloadURL();
  }
}
