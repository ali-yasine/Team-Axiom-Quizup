import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class Authenicator {
  static String encrpytPassword(String password) {
    var bytes = utf8.encode(password);
    var hash = sha256.convert(bytes);
    return hash.toString();
  }

  static Future<bool> authenticate(String username, String password) async {
    var doc = await FirebaseFirestore.instance
        .collection('PlayerAuthentication')
        .doc('username')
        .get();
    if (!doc.exists) {
      return false;
    }
    return doc.data()!["password"] == encrpytPassword(password);
  }
}
