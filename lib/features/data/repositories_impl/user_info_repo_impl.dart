import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taskmanagenet/features/domain/entities/user_info_entity.dart';
import 'package:taskmanagenet/features/domain/usecases/user_ifon_use_case/user_info_use_case.dart' show ICreateUserUseCase;

class UserRepositoryImpl implements ICreateUserUseCase {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  UserRepositoryImpl({required this.firestore, required this.storage});

  @override
  Future<void> call(UserEntity user, String? imagePath) async {
    String? imageUrl;

    if (imagePath != null) {
      // Upload image to Firebase Storage
      final ref = storage.ref().child('users/${user.id}.jpg');
      await ref.putFile(File(imagePath));
      imageUrl = await ref.getDownloadURL();
    }

    await firestore.collection('users').doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'imageUrl': imageUrl,
      'createdAt': DateTime.now(),
    });
  }
}
