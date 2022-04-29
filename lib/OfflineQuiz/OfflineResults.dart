import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizup_prototype_1/Screens/subject_screen.dart';

import '../Utilities/player.dart';

class OfflineResults extends StatelessWidget {
  final Player player;
  final int score;
  final String subject;
  final int correct;
  final int incorrect;
  final int playerNum;
  final int opponentScore;
  const OfflineResults(
      {Key? key,
      required this.player,
      required this.score,
      required this.subject,
      this.opponentScore = 0,
      required this.correct,
      required this.incorrect,
      required this.playerNum})
      : super(key: key);

  Future<void> updateSubjectLeaderboard() async {
    var subjectdoc = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc(subject)
        .get();
    if (subjectdoc.data()!['players'] != null) {
      var info = subjectdoc.data()!['players'][player.username];
      if (info != null) {
        if (score > opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [info[0], info[1] + 10]
          });
        } else if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [info[0], info[1] - 10]
          });
        }
      } else {
        if (score > opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [player.country, 110]
          });
        } else if (score < opponentScore) {
          FirebaseFirestore.instance
              .collection('Leaderboard')
              .doc(subject)
              .update({
            'players.${player.username}': [player.country, 90]
          });
        }
      }
    }
  }

  Future<void> updateGlobalLeaderboard() async {
    var global = await FirebaseFirestore.instance
        .collection('Leaderboard')
        .doc('Global')
        .get();
    var info = global.data()!['players'][player.username];
    if (score > opponentScore) {
      if (info != null) {
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc('Global')
            .update({
          'players.${player.username}': [info[0], info[1] + 10]
        });
      } else {
        FirebaseFirestore.instance
            .collection('Leaderboard')
            .doc('Global')
            .update({
          'players.${player.username}': [player.country, 110]
        });
      }
    } else if (score < opponentScore) {
      FirebaseFirestore.instance
          .collection('Leaderboard')
          .doc('Global')
          .update({
        'players.${player.username}': [player.username, 90]
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (playerNum == 2) {
      updateGlobalLeaderboard();
      updateSubjectLeaderboard();
      return SubjectScreen(subject: subject, player: player);
    }
    return Container();
  }
}
