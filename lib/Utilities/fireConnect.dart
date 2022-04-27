import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../Utilities/player.dart';
import '../../../Utilities/question_template.dart';

class FireConnect {
  static Future createPlayer({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('player').doc();
    final json = {'name': name, 'quans': 21, 'score': 100};
    await docUser.set(json);
  }

  static Future<void> uploadAvatar(String filepath, String username) async {
    final storage = FirebaseStorage.instance;
    var file = File(filepath);
    try {
      await storage.ref("Players/$username").putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

// static Future<List<Asset
  static Future<List<QuestionTemplate>> readQuestions(String subject) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Question')
        .where('category', isEqualTo: subject)
        .get();
    return querySnapshot.docs
        .map((e) => QuestionTemplate.fromJson(e.data()))
        .toList();
  }

  static Future<List<String>> getSubjects() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Subject').get();
    return List.from(querySnapshot.docs.first["subjects"]);
  }

  static Future<Player> getPlayer(String username) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Player')
        .where('Username', isEqualTo: username)
        .get();
    return Player.fromJson(querySnapshot.docs.first.data());
  }

  static Future<Player> getPlayerByEmail(String email) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Player')
        .where('Email', isEqualTo: email)
        .get();
    return Player.fromJson(querySnapshot.docs.first.data());
  }
}
