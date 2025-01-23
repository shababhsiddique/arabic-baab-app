// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
import 'dart:math';

import 'package:baab_practice/helper/hive.dart';
import 'package:baab_practice/helper/preferences.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appController = ChangeNotifierProvider<AppControllerState>((ref) => AppControllerState());


class AppControllerState extends ChangeNotifier {

  bool isDarkmode = true;

  List<ArabicVerb> currentSessionVerbs = [];

  ArabicVerb? currentQuestionVerb;
  String currentQuestionText = "";
  int currentQuestionVerbIndex = -1;

  bool showAnswer = false;

  List<ArabicVerb> currentSessionIncorrectVerbs = [];

  //final ref;
  AppControllerState() {
    isDarkmode = VerbAppPreferences.isDarkMode();
    currentSessionVerbs = VerbAppDatabase.fetchVerbs();
    if(currentSessionVerbs.isEmpty){
      VerbAppDatabase.fillVerbsFromSource().then((v){
        currentSessionVerbs = VerbAppDatabase.fetchVerbs();
      });
    }
    //currentSessionIncorrectVerbs = VerbAppDatabase.fetchIncorrect();
    print("app state initiated");
    if(currentQuestionVerb == null){
      generateNewRandomQuestionVerb();
    }
  }

  void toggleDarkMode(){
    isDarkmode = !isDarkmode;
    if(isDarkmode){
      VerbAppPreferences.setString(VerbAppPreferences.appThemeColorMode, VerbAppPreferences.themeDark);
    }else{
      VerbAppPreferences.setString(VerbAppPreferences.appThemeColorMode, VerbAppPreferences.themeLight);
    }
    notifyListeners();
  }

  getCurrentSessionWordsLeft(){
    return currentSessionVerbs.length;
  }

  removeCurrentQuestionFromPool(){
    if(currentQuestionVerbIndex != -1){
      //remove last question from session
      currentSessionVerbs.removeAt(currentQuestionVerbIndex);
    }
  }

  generateNewRandomQuestionVerb() async {

    if(currentSessionVerbs.isNotEmpty){
      // Generate a random index within the box length
      currentQuestionVerbIndex = Random().nextInt(currentSessionVerbs.length);
      //set this as current verb
      currentQuestionVerb = currentSessionVerbs.elementAt(currentQuestionVerbIndex);
      currentQuestionText = currentQuestionVerb?.pickRandomQuestion() ?? "";
    }


    notifyListeners();
  }

  setShowAnswer(bool v){
    if(showAnswer != v){
      showAnswer = v;
      notifyListeners();
    }
  }

  addToIncorrect(verb){
    currentSessionIncorrectVerbs.add(verb);
    //VerbAppDatabase.addToIncorrect(verb);
  }

  int geCurrenttIncorrectCount(){
    return currentSessionIncorrectVerbs.length;
  }

}
