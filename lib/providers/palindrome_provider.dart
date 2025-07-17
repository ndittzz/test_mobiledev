import 'package:flutter/material.dart';

class PalindromeProvider with ChangeNotifier {
  String _name = '';
  String _sentence = '';

  String get name => _name;
  String get sentence => _sentence;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setSentence(String value) {
    _sentence = value;
    notifyListeners();
  }

  bool isPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();
    return cleanText == cleanText.split('').reversed.join('');
  }
}
