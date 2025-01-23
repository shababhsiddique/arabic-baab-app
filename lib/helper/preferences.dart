import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class VerbAppPreferences {
  static SharedPreferences? prefs;

  static const appThemeColorMode = 'appThemeColorMode';
  static const themeLight = 'light';
  static const themeDark = 'dark';
  static const themeSystemDefault = 'system';

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
}
