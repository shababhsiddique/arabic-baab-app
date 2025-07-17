// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
import 'dart:math';

import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/hive.dart';
import 'package:baab_practice/helper/preferences.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:update_available/update_available.dart';

final appController = ChangeNotifierProvider<AppControllerState>((ref) => AppControllerState());


class AppControllerState extends ChangeNotifier {

  bool isDarkmode = true;
  bool? checkUpdate;

  List<ArabicVerb> currentSessionVerbs = [];

  ArabicVerb? currentQuestionVerb;
  String currentQuestionText = "";
  int currentQuestionVerbIndex = -1;

  bool showAnswer = false;

  String appVersion ="";
  bool practiceMistakesOnly = VerbAppPreferences.getBool(VerbAppPreferences.practiceMistakesOnlyMode);

  // New property for the selector
  String questionBy = VerbAppPreferences.getString(VerbAppPreferences.selectedQuestionByKey) ?? "random";

  List<String> includeBaabs = List.from(VerbAppPreferences.getBaabSelection().toList());

  //final ref;
  AppControllerState() {
    isDarkmode = VerbAppPreferences.isDarkMode();
    loadSession();
  }

  loadSession(){
    print("current $includeBaabs");
    currentSessionVerbs = VerbAppDatabase.fetchVerbsByBaab(includeBaabs, mistakeOnly: practiceMistakesOnly);

    if(currentQuestionVerb == null && currentSessionVerbs.isNotEmpty){
      generateNewRandomQuestionVerb();
    }

    //this if data was empty
    if(currentSessionVerbs.isEmpty || currentSessionVerbs.firstOrNull?.amr == null ){
      print("load");
      if(currentSessionVerbs.firstOrNull?.amr  == null){
        print("data was present but amr was null");
      }
      VerbAppDatabase.fillVerbsFromSource().then((v){
        currentSessionVerbs = VerbAppDatabase.fetchVerbsByBaab(includeBaabs, mistakeOnly: practiceMistakesOnly);
        generateNewRandomQuestionVerb();
        notifyListeners();
      });
    }

    print("app state initiated");

  }


  checkAppUpdateAvailable({required showUpdateAlert}) async {
    print("called check");
    checkUpdate = true;

    var availability = await getUpdateAvailability();
    String text = switch (availability) {
      UpdateAvailable() => "There's an update available!",
      NoUpdateAvailable() => "There's no update available!",
      UnknownAvailability() => "Sorry, couldn't determine if there is or not an available update!",
    };

    if (text == "There's an update available!") {
      showUpdateAlert();
    }
  }

  getAppVersion(){
    PackageInfo.fromPlatform().then((val){
      appVersion = "${val.version}(${val.buildNumber})";
      notifyListeners();
    });
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

  void toggleMistakeOnlyMode(){
    practiceMistakesOnly = !practiceMistakesOnly;
    VerbAppPreferences.setBool(VerbAppPreferences.practiceMistakesOnlyMode, practiceMistakesOnly);
    loadSession();
    generateNewRandomQuestionVerb();
    notifyListeners();
  }


  getCurrentSessionWordsLeft(){
    return currentSessionVerbs.length;
  }

  removeCurrentQuestionFromPool(){
    if(currentQuestionVerbIndex != -1 && currentSessionVerbs.isNotEmpty){
      //remove last question from session
      currentQuestionVerb!.decreaseFailCount();
      currentQuestionVerb!.save();
      if(currentQuestionVerb!.failCounter == 0){
        currentSessionVerbs.removeAt(currentQuestionVerbIndex);
      }
    }
    notifyListeners();
  }

  dynamic generateNewRandomQuestionVerb() {

    if(currentSessionVerbs.isNotEmpty){
      // Generate a random index within the box length
      currentQuestionVerbIndex = Random().nextInt(currentSessionVerbs.length);
      //set this as current verb
      currentQuestionVerb = currentSessionVerbs.elementAt(currentQuestionVerbIndex);

      currentQuestionText = currentQuestionVerb?.getQuestion(questionBy) ?? "";

    } else {
      currentQuestionVerb = null;
    }

    notifyListeners();
  }

  setShowAnswer(bool v){
    if(showAnswer != v){
      showAnswer = v;
      notifyListeners();
    }
  }

  addToIncorrect(ArabicVerb verb) async {

    //VerbAppDatabase.increaseVerbFail(verb);
    verb.failCounter += 1;
    verb.failHistory = (verb.failHistory ?? 0) + 1;
    await verb.save();
    notifyListeners();
  }

  int geCurrentIncorrectCount(){
    return VerbAppDatabase.getPreviousFailWords().length;
  }

  updateBaabSelection({required String baab,required bool enable}){

    VerbAppPreferences.updateBaabSelection(baab: baab, enable: enable);

    if(includeBaabs.contains(baab) && enable == false){
      if(includeBaabs.length == 1){
        return false;
      }
      includeBaabs.remove(baab);
    }
    if(includeBaabs.contains(baab)==false && enable == true){
      includeBaabs.add(baab);
    }
    currentSessionVerbs = VerbAppDatabase.fetchVerbsByBaab(includeBaabs, mistakeOnly: practiceMistakesOnly);

    if(currentSessionVerbs.isNotEmpty){
      generateNewRandomQuestionVerb();
    }
    //notifyListeners();
  }

  updateSelectedQuestionBy(String option) {
    questionBy = option;
    VerbAppPreferences.setString(VerbAppPreferences.selectedQuestionByKey, option);
    notifyListeners();
  }



}
