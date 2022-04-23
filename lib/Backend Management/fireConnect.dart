import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../Utilities/player.dart';
import '../Utilities/question_template.dart';

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

  static Future<Map<String, AssetImage>> getSubjectIcons() async {
    //TODO  implement
    throw UnimplementedError();
  }

  static Future<List<QuestionTemplate>> readQuestions(
      String subject, int questionNumber) async {
    List<T> pickRandomItemsAsList<T>(List<T> items, int count) =>
        (items.toList()..shuffle()).take(count).toList();
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Questions')
        .doc(subject)
        .collection('questions')
        .get();
    print(querySnapshot.docs.length);
    var allquestions = querySnapshot.docs
        .map((e) => QuestionTemplate.fromJson(e.data()))
        .toList();
    var questions = pickRandomItemsAsList(allquestions, questionNumber);
    return questions;
  }

  static Future<List<String>> getSubjects() async {
    var subjectsCollection =
        await FirebaseFirestore.instance.collection('Questions').get();
    List<String> subjectnames =
        subjectsCollection.docs.map((e) => e.reference.id).toList();
    return subjectnames;
  }

  static Future<Player> getPlayer(String username) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Player')
        .where('Username', isEqualTo: username)
        .get();
    return Player.fromJson(querySnapshot.docs.first.data());
  }

  static Future<bool> addPlayer(String username, String password) async {
    var playerAuthDoc = FirebaseFirestore.instance
        .collection('PlayerAuthentication')
        .doc(username);
    if ((await playerAuthDoc.get()).exists) {
      return false;
    }
    FirebaseFirestore.instance
        .collection('PlayerAuthentication')
        .doc(username)
        .set({"password": password});
    return true;
  }
}
