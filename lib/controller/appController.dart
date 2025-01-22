// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
import 'package:baab_practice/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appController = ChangeNotifierProvider<AppControllerState>((ref) => AppControllerState());


class AppControllerState extends ChangeNotifier {

  bool isDarkmode = true;

  List<String> testWords = [
    "word1",
    "word2"
  ];

  List<Verb> verbs = [];

  void toggleDarkmode(){
    isDarkmode = !isDarkmode;
    print("Toggling brightess $isDarkmode");
    notifyListeners();
  }

  int getWordSize(){
    return testWords.length;
  }



}
