import 'package:baab_practice/config/router.dart';
import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BaabPracticeApp extends ConsumerWidget {
  const BaabPracticeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationController = ref.watch(appController);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: applicationController.isDarkmode ? ThemeMode.dark : ThemeMode
            .light,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          //brightness: Brightness.light, // Light theme settings
        ),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}