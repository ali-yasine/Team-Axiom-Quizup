import 'package:flutter/material.dart';

class Player {
  final String username;
  Image avatar;
  final String email;
  int gamesWon;
  int avgSecondsToAnswer;
  int gamesPlayed;
  final String country;
  Player(
      {Key? key,
      required this.email,
      required this.country,
      required this.username,
      required this.avatar,
      required this.gamesWon,
      required this.avgSecondsToAnswer,
      required this.gamesPlayed});
  static Player fromJson(Map<String, dynamic> json, Image avatar) => Player(
      avatar: avatar,
      country: json['Country'],
      username: json["Username"],
      gamesPlayed: json["GamesPlayed"],
      email: json["Email"],
      gamesWon: json["GamesWon"],
      avgSecondsToAnswer: json["AvgSecondsToAnswer"]);
  static Map<String, dynamic> toJson(Player player) => {
        'Username': player.username,
        'Email': player.email,
        'GamesPlayed': player.gamesPlayed,
        'GamesWon': player.gamesWon,
        'AvgSecondsToAnswer': player.avgSecondsToAnswer,
        'Country': player.country
      };
}
