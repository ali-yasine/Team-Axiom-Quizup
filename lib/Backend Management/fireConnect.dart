// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../Utilities/Rank.dart';
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

  static Future<void> submitReport(
      String report, String? subject, String? email) async {
    final report =
        FirebaseFirestore.instance.collection('questionReports').doc();
    final reportdoc = {'email': email, 'subject': subject, 'report': report};
    await report.set(reportdoc);
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

  static Future<Set<String>> getCountries() async {
    var players = await FirebaseFirestore.instance.collection('Player').get();
    return players.docs.map((e) => e.data()['Country'].toString()).toSet();
  }

  static Future<Player> getPlayer(String username) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Player')
        .where('Username', isEqualTo: username)
        .get();
    var ref = FirebaseStorage.instance.ref();
    String url;
    try {
      url = await ref.child('Players/$username').getDownloadURL();
    } catch (err) {
      url = "";
    }
    return Player.fromJson(
        querySnapshot.docs.first.data(),
        url == ""
            ? const Image(image: AssetImage("assets/images/avatar.png"))
            : Image.network(url));
  }

  static Future<Player> getPlayerByEmail(String email) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('Player')
        .where('Email', isEqualTo: email)
        .get();
    var ref = FirebaseStorage.instance.ref();
    String url;
    String username = querySnapshot.docs.first.data()['Username'];
    try {
      url = await ref.child('Players/$username').getDownloadURL();
    } catch (err) {
      url = "";
    }
    return Player.fromJson(
        querySnapshot.docs.first.data(),
        url == ""
            ? const Image(image: AssetImage("assets/images/avatar.png"))
            : Image.network(url));
  }

  static Future<Map<String, dynamic>> getLeaderBoard(String subject) async {
    var doc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(subject)
        .get();
    if (doc.exists) {
      if (doc.data() != null) {
        if (doc.data()!["players"] != null) {
          return doc.data()!["players"];
        }
      }
    }
    return {};
  }

  static Future<Map<String, dynamic>> getCountryLeaderBoard(
      String country) async {
    var doc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc('Global')
        .get();
    return Map.from(doc.data()!['players'])
      ..removeWhere((key, value) => value[0] != country);
  }

  static Future<Map<String, dynamic>> getGlobalLeaderBoard() async {
    return getLeaderBoard('Global');
  }

  static Future<String> addPlayer(
      String username, String email, String country) async {
    var emailQuery = await FirebaseFirestore.instance
        .collection('Player')
        .where('email', isEqualTo: email)
        .get();

    if (emailQuery.docs.isNotEmpty) {
      return "Email already in Use";
    }
    var userQuery = await FirebaseFirestore.instance
        .collection('Player')
        .where('Username', isEqualTo: username)
        .get();
    if (userQuery.docs.isNotEmpty) {
      return "Username already in Use ";
    }
    Map<String, dynamic> playerData = {
      'Username': username,
      'Email': email,
      'Country': country,
      'GamesPlayed': 0,
      'GamesWon': 0,
      'AvgSecondsToAnswer': 0
    };
    bool errorOccured = false;
    await FirebaseFirestore.instance
        .collection('Player')
        .add(playerData)
        .catchError((error) {
      errorOccured = true;
    });
    if (errorOccured) return "An Error Occured";
    return "Player added";
  }

  static Future<int> getRank(String username, String subject) async {
    var leaderboard = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(subject)
        .get();
    var playerdata = leaderboard.data()!['players']!;
    var players = playerdata.entries
        .map((entry) => Rank(
              username: entry.key,
              rankNumber: 0,
              country: entry.value[0],
              score: entry.value[1].toString(),
            ))
        .toList();
    players.sort((b, a) => int.parse(a.score).compareTo(int.parse(b.score)));
    int rank = 0;
    for (int i = 0; i < players.length; i++) {
      if (players[i].username == username) {
        rank = i;
      }
    }
    return rank + 1;
  }

  static Future<int> getCountryRank(Player player) async {
    var leaderboard = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc('Global')
        .get();
    Map<String, dynamic> playerdata = leaderboard.data()!['players']!;
    Map<String, dynamic> countryPlayers = Map.from(playerdata)
      ..removeWhere((key, value) => value[0] != player.country);
    var players = countryPlayers.entries
        .map((entry) => Rank(
              username: entry.key,
              rankNumber: 0,
              country: entry.value[0],
              score: entry.value[1].toString(),
            ))
        .toList();
    players.sort((b, a) => int.parse(a.score).compareTo(int.parse(b.score)));
    int rank = 0;
    for (int i = 0; i < players.length; i++) {
      if (players[i].username == player.username) {
        rank = i;
      }
    }
    return rank + 1;
  }
}
