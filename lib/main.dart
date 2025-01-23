import 'package:baab_practice/helper/hive.dart';
import 'package:baab_practice/helper/preferences.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'myApp.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await VerbAppPreferences.initializePreferences();

  await Hive.initFlutter();  // Works automatically for mobile & web

  Hive.registerAdapter(ArabicVerbAdapter());  // Register the adapter
  await VerbAppDatabase.initHive();

  runApp(
      ProviderScope(
          child: BaabPracticeApp()
      )
  );
}
