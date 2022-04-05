import 'package:flutter/material.dart';

class Player {
  final String username;
  AssetImage avatar;
  final String email;
  int gamesWon;
  int rankByCountry;
  int rankGlobal;
  int avgSecondsToAnswer;
  int gamesPlayed;

  Player(
      {Key? key,
      required this.email,
      required this.username,
      required this.avatar,
      required this.gamesWon,
      required this.avgSecondsToAnswer,
      required this.rankByCountry,
      required this.rankGlobal,
      required this.gamesPlayed});
}
