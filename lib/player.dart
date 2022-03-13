import 'package:flutter/material.dart';

class Player {
  final String username;
  final String id;
  int questionsAnswered;
  int score;
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': username,
        'quans': questionsAnswered,
        'score': score,
      };
  static Player fromJson(Map<String, dynamic> json) => Player(
        id: json['id'],
        username: json['name'],
        questionsAnswered: json['quans'],
        score: json['score'],
      );

  Player(
      {Key? key,
      required this.username,
      required this.id,
      this.questionsAnswered = 0,
      this.score = 0});
}
