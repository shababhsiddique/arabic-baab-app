import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'myApp.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();  // Works automatically for mobile & web

  runApp(
      ProviderScope(
          child: BaabPracticeApp()
      )
  );
}
