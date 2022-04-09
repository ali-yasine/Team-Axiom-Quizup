import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utilities/player.dart';
import '../Utilities/question_template.dart';

class FireConnect {
  static Future createPlayer({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('player').doc();
    final json = {'name': name, 'quans': 21, 'score': 100};
    await docUser.set(json);
  }

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
}
