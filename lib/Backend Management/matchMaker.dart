import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizup_prototype_1/Backend%20Management/fireConnect.dart';
import 'package:quizup_prototype_1/Utilities/question_template.dart';
import '../Utilities/player.dart';

class MatchMaker {
  static Future<bool> findOpponent(Player player, String subject) async {
    String opponentUsername;
    var doc = FirebaseFirestore.instance.collection("Matchmaking").doc(subject);
    doc.update({
      "Players": FieldValue.arrayUnion([player.username])
    });
    int playerNum = (await doc.get())["Players"].length;
    if (playerNum <= 2) {
      doc.snapshots().listen((event) async {
        var data = event.data();
        if (data!["Players"].length >= 2) {
          opponentUsername = data["Players"].elementAt(1);
          doc.update({
            "Players":
                FieldValue.arrayRemove([opponentUsername, player.username])
          });
          var questions = await FireConnect.readQuestions(subject);
          createContest(player.username, opponentUsername, questions);
        }
      });
    }
    return false;
  }

  static Future<int> getGameId() async {
    var doc = await FirebaseFirestore.instance
        .collection('contest')
        .doc('CurrentID')
        .get();
    return doc['currID'];
  }

  static Future<void> incGameId() async {
    var id = await getGameId();
    FirebaseFirestore.instance
        .collection("contest")
        .doc('CurrentID')
        .set({'currID': id + 1});
  }

  static Future<void> createContest(
      String player, String opponent, List<QuestionTemplate> questions) async {
    var db = FirebaseFirestore.instance;
    var gameid = await getGameId();
    db.collection("contest").doc(gameid.toString()).set(({
          "Player1": player,
          "Player2": opponent,
          "Questions":
              questions.map((e) => QuestionTemplate.toJson(e)).toList(),
          "Player1 Score": 0,
          "Player2 Score": 0
        }));
    incGameId();
  }
}
