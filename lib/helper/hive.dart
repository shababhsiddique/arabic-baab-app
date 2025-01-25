import 'dart:convert';

import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:hive/hive.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

abstract class VerbAppDatabase {
  static Box? box;

  static const String mainVerbBox = "mainVerbBox";
  static const String verbListIndex = "verbs";
  static const String incorrectListIndex = "incorrect";
  static const String sourceCSVURL =
      'https://docs.google.com/spreadsheets/d/e/2PACX-1vSJoUk2VttAgxByuYVMPDNPc1I8YdpgEYOqql3xqFeJ7RxI1pLkaNrkc2pAi721c1a7bnNIxyfl56g2/pub?gid=728929932&single=true&output=csv';

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
      print("Maadi: ${verb.maadi}, Bengali: ${verb.bengaliMeaning}");
      verbList.add(verb);
    }
    return verbList;
  }


  static List<ArabicVerb> fetchVerbsByBaab(List<String> selectedBaabs) {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    // Filter verbs where failCounter is greater than 0 (indicating incorrect attempts)
    List<ArabicVerb> selectedVerbs = [];

    for( var baab in selectedBaabs){
      for (ArabicVerb verb in box!.values.where((verb) => verb.baab == baab)) {
        print("Maadi: ${verb.maadi}, Bengali: ${verb.bengaliMeaning}");
        selectedVerbs.add(verb);
      }
    }

    return selectedVerbs;
  }

  static Future<bool> fillVerbsFromSource() async {
    // Fetch CSV file from the link
    try {
      // Fetch CSV file from the link
      final response = await http.get(Uri.parse(sourceCSVURL));

      if (response.statusCode == 200) {
        box ??= Hive.box<ArabicVerb>(mainVerbBox);
        final csvData = utf8.decode(response.bodyBytes);

        // Parse CSV data
        List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

        // Skip header row and process the data
        for (int i = 1; i < rows.length; i++) {
          final row = rows[i];

          ArabicVerb verb = ArabicVerb(
            maadi: row[0].toString(),
            mudari: row[1].toString(),
            masdar: row[2].toString(),
            bengaliMeaning: row[3].toString(),
            baab: row[4].toString(),
          );
          var existingVerb = box!.get(verb.maadi);

          if (existingVerb != null) {
            // Compare properties to check if they are the same
            bool isIdentical = existingVerb.mudari == verb.mudari &&
                existingVerb.masdar == verb.masdar &&
                existingVerb.bengaliMeaning == verb.bengaliMeaning &&
                existingVerb.baab == verb.baab;

            if (!isIdentical) {
              // Remove existing and update with new one
              await box!.delete(verb.maadi);
              await box!.put(verb.maadi, verb);
              print('Updated existing verb: ${verb.maadi}');
            } else {
              print('Verb already exists with identical data: ${verb.maadi}');
            }
          } else {
            // Add new verb if it doesn't exist
            await box!.put(verb.maadi, verb);
            print('Added new verb: ${verb.maadi}');
          }
        }

        print('CSV processing completed.');
        return true;
      } else {
        print('Failed to load CSV: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching or processing CSV: $e');
    }
    return false;
  }


  static ArabicVerb? searchVerb(String searchString) {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);

    // Normalize search input by removing harakat
    String normalizedInput = ArabicTerms.removeHarakat(searchString);

    for (var verb in box!.values) {
      ArabicVerb arabicVerb = verb as ArabicVerb;

      // Normalize stored value for comparison
      if (ArabicTerms.removeHarakat(arabicVerb.maadi) == normalizedInput) {
        return arabicVerb;
      }
      if (arabicVerb.bengaliMeaning == normalizedInput) {
        return arabicVerb;
      }
    }

    return null; // Return null if not found
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
      print("Maadi: ${verb.maadi}, Bengali: ${verb.bengaliMeaning}");
      failWords.add(verb);
    }

    return failWords;
  }

/*static Future<void> addToIncorrect(ArabicVerb verb) async {
    box ??= Hive.box<ArabicVerb>(mainVerbBox);
    await iBox!.put(verb.maadi, verb);
  }

  static Future<void> removeFromIncorrect(ArabicVerb verb) async {
    iBox ??= Hive.box<ArabicVerb>(incorrectBox);
    await iBox!.delete(verb.maadi);
  }

  static List<ArabicVerb> fetchIncorrect() {
    iBox ??= Hive.box<ArabicVerb>(incorrectBox);

    List<ArabicVerb> verbList = [];

    for (ArabicVerb verb in iBox!.values) {
      verbList.add(verb);
    }
    return verbList;
  }*/
}
