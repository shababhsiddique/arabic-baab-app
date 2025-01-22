import 'package:baab_practice/widgets/baab_practice_app_drawer.dart';
import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/widgets/verbCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/styles.dart';
import 'model/word.dart';

class BaabPracticeApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final appControllerW = watch(appController);

    //List<String> todos = ref.watch(appController).testWords;

    final applicationController = ref.watch(appController);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: applicationController.isDarkmode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        //brightness: Brightness.light, // Light theme settings
      ),
      darkTheme: ThemeData.dark().copyWith(
        /*primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black87,*/
        /*textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),*/
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: Colors.blueAccent,
            title: Text('Sibawaya Verbs Practice', style: appbarTextStyle,)
          ),
          drawer: BaabPracticeAppDrawer(),
          body: SingleChildScrollView(
            child: VerbCard(
              question: "AskingThis",
              arabicVerb: Verb(
                maadi: 'test',
                mudari: 'ba',
                masdar: 'b',
                bengali: 'c',
                baab: 'd',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
