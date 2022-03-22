import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizup_prototype_1/question_template.dart';

class fireConnect {
  static Future createPlayer({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('player').doc();
    final json = {'name': name, 'quans': 21, 'score': 100};
    await docUser.set(json);
  }

  static Future<List<question_template>> readQuestions(String subject) async {
    var queuerySnapshot = await FirebaseFirestore.instance
        .collection('Question')
        .where('category', isEqualTo: subject)
        .get();
    return queuerySnapshot.docs
        .map((e) => question_template.fromJson(e.data()))
        .toList();
  }
}
