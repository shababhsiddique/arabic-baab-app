
import 'package:baab_practice/helper/arabic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class VerbAppPreferences {
  static SharedPreferences? prefs;

  static const appThemeColorMode = 'appThemeColorMode';
  static const themeLight = 'light';
  static const themeDark = 'dark';
  static const themeSystemDefault = 'system';
  static const baabEnabledKey_ = 'baabEnable_';
  static const practiceMistakesOnlyMode = 'mistakesOnly';
  static const practiceModeKey = 'practiceMode';
  static const selectedQuestionByKey = 'questionByKey';

  static Future<SharedPreferences?> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  //helpers
  static containsKey(String key) {
    if (prefs != null) {
      return prefs!.containsKey(key);
    } else {
      SharedPreferences.getInstance().then((value) {
        prefs = value;
      });
      return false;
    }
  }

  static String? getString(String key) {
    return prefs!.getString(key);
  }

  static setBool(String key, bool value) {
    return prefs!.setBool(key, value);
  }

  static getBool(String key) {
    if(prefs!.containsKey(key)){
      return prefs!.getBool(key);
    }
    return false;
  }

  static setInt(String key, int value) {
    return prefs!.setInt(key, value);
  }

  static setString(String key, String value) {
    return prefs!.setString(key, value);
  }

  static bool isDarkMode() {
    String? theme;
    //check if user picked a preference
    if (containsKey(appThemeColorMode)) {
      theme = getString(appThemeColorMode);
    }
    if (theme == themeDark) {
      return true;
    } else if (theme == themeLight) {
      return false;
    } else {
      var brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        return true;
      }
      return false;
    }
  }

  static List<String> getBaabSelection() {
    List<String> selectedBaab = [];

    for(String baab in ArabicTerms.listOfBaabs){
      if(prefs!.getBool("$baabEnabledKey_$baab")??true){
        selectedBaab.add(baab);
      }
    }

    return selectedBaab;
  }

  static updateBaabSelection({required String baab,required bool enable}) {
    prefs!.setBool("$baabEnabledKey_$baab", enable);
  }

}
