import 'dart:convert';

import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:hive/hive.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

abstract class VerbAppDatabase {
  static Box? box;

  static const String mainVerbBox = "mainVerbBox";
  static const String verbListIndex = "verbs";
  static const String incorrectListIndex = "incorrect";
  static const String sourceCSVURL =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSJoUk2VttAgxByuYVMPDNPc1I8YdpgEYOqql3xqFeJ7RxI1pLkaNrkc2pAi721c1a7bnNIxyfl56g2/pub?gid=728929932&single=true&output=csv';
  static const String localCSVPath = 'assets/verbs_all.csv';

  static Future<Box?> initHive() async {
    box = await Hive.openBox(mainVerbBox);
    return box;
  }

  static Future<void> addVerb(ArabicVerb verb) async {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    await box!.put(verb.maadi, verb);
  }

  static List<ArabicVerb> fetchVerbs() {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);

    List<ArabicVerb> verbList = [];

    for (ArabicVerb verb in box!.values) {
      verbList.add(verb);
    }
    return verbList;
  }

  static List<ArabicVerb> fetchVerbsByBaab(List<String> selectedBaabs,
      {bool mistakeOnly = false, bool favoritesOnly = false, String selectMode = 'All'}) {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    // Filter verbs based on selected criteria
    List<ArabicVerb> selectedVerbs = [];

    for (var baab in selectedBaabs) {
      for (ArabicVerb verb in box!.values.where((verb) =>verb.baab == baab) ){

        if(selectMode == 'All'){
          selectedVerbs.add(verb);
        }else if(selectMode == 'Mistakes' && (verb.failHistory ?? 0) > 0 ){
          selectedVerbs.add(verb);
        } else if(selectMode == 'Favorites' && verb.isFavorite) {
          selectedVerbs.add(verb);
        }

        /*if((!mistakeOnly || (verb.failHistory ?? 0) > 0)){

        }
        selectedVerbs.add(verb);*/
      }
    }

    return selectedVerbs;
  }

  static Future<bool> fillVerbsFromSource() async {
    bool success = await _fetchAndStoreFromNetwork();
    if (!success) {
      print('Network failed, loading from local asset...');
      success = await _fetchAndStoreFromAssets();
    }
    return success;
  }

  // Fetch from Network
  static Future<bool> _fetchAndStoreFromNetwork() async {
    try {
      final response = await http.get(Uri.parse(sourceCSVURL));
      if (response.statusCode == 200) {
        return _processCSVData(utf8.decode(response.bodyBytes));
      } else {
        print(
            'Failed to load CSV from network. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching CSV from network: $e');
    }
    return false;
  }

  // Fallback: Read CSV from assets
  static Future<bool> _fetchAndStoreFromAssets() async {
    try {
      final csvData = await rootBundle.loadString(localCSVPath);
      return _processCSVData(csvData);
    } catch (e) {
      print('Error loading CSV from assets: $e');
    }
    return false;
  }

  // Common function to process CSV data and store in Hive
  static Future<bool> _processCSVData(String csvData) async {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);

    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];

      ArabicVerb verb = ArabicVerb(
        maadi: row[0].toString(),
        mudari: row[1].toString(),
        masdar: row[2].toString(),
        bengaliMeaning: row[3].toString(),
        baab: row[4].toString(),
        amr: row[5].toString(),
        nahi: row[6].toString(),
      );

      var existingVerb = box!.get(verb.maadi);

      //only insert verb if not exist when reading local source, no need to update.
      //update database if amr was empty (new column since version 1.1.0)
      if (existingVerb == null || existingVerb.amr==null) {
        await box!.put(verb.maadi, verb);
      }
    }

    return true;
  }

  static List<ArabicVerb> searchVerb(String searchString) {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);

    // Normalize search input by removing harakat
    String normalizedInput = ArabicTerms.removeHarakat(searchString.trim());
    List<ArabicVerb> result = [];

    for (var verb in box!.values) {
      ArabicVerb arabicVerb = verb as ArabicVerb;

      //search by maadi
      if (ArabicTerms.removeHarakat(arabicVerb.maadi).contains(normalizedInput)) {
        if(ArabicTerms.removeHarakat(arabicVerb.maadi) == normalizedInput){
          result.insert(0, arabicVerb);
        }else{
          result.add(arabicVerb);
        }
      }

      //search by bengali
      if (arabicVerb.bengaliMeaning.contains(normalizedInput)) {
        if (arabicVerb.bengaliMeaning == normalizedInput){
          result.insert(0, arabicVerb);
        }else{
          result.add(arabicVerb);
        }
      }
    }

    return result; // Return null if not found
  }

  static Future<void> clearData() async {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    await box!.clear();
  }

  static List<ArabicVerb> getPreviousFailWords() {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    // Filter verbs where failCounter is greater than 0 (indicating incorrect attempts)
    List<ArabicVerb> failWords = [];

    for (ArabicVerb verb in box!.values.where((verb) => verb.failCounter > 0)) {
      failWords.add(verb);
    }

    return failWords;
  }

  static Future<void> clearFailHistory() async {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);

    // Iterate through all stored items and update failHistory
    for (var key in box!.keys) {
      ArabicVerb? verb = box!.get(key);

      if (verb != null) {
        verb.failHistory =0;
        verb.failCounter = 0;
        await verb.save();
      }
    }

    print("All fail history cleared");
  }

  static List<ArabicVerb> fetchVerbsWithMistake() {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    // Filter verbs where failCounter is greater than 0 (indicating incorrect attempts)
    List<ArabicVerb> selectedVerbs = box!.values
        .where((item) => (item as ArabicVerb).failHistory != null && (item).failHistory! > 0)
        .cast<ArabicVerb>()
        .toList();

    // Sort list in descending order based on failHistory
    selectedVerbs.sort((a, b) => b.failHistory!.compareTo(a.failHistory as num));

    return selectedVerbs;
  }

  static List<ArabicVerb> fetchVerbsWithFavorite() {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    // Filter verbs where isFavorite is true
    List<ArabicVerb> selectedVerbs = box!.values
        .where((item) => (item as ArabicVerb).isFavorite)
        .cast<ArabicVerb>()
        .toList();

    return selectedVerbs;
  }

}
