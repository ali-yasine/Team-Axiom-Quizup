import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizup_prototype_1/player.dart';
import 'package:quizup_prototype_1/question_template.dart';

class fireConnect {
  static Future createPlayer({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('player').doc();
    final json = {'name': name, 'quans': 21, 'score': 100};
    await docUser.set(json);
  }

  static Future<List<Iterable<question_template>>> readQuestions() async {
    return FirebaseFirestore.instance
        .collection('Question')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => question_template.fromJson(doc.data())))
        .toList();
  }

  static Future<List<Iterable<Player>>> readPlayers() async {
    return FirebaseFirestore.instance
        .collection('players')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Player.fromJson(doc.data())))
        .toList();
  }
}
