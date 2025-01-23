import 'package:baab_practice/config/styles.dart';
import 'package:baab_practice/model/word.dart';
import 'package:baab_practice/widgets/baab_practice_app_drawer.dart';
import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/widgets/verbCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppHome extends StatelessWidget {
  const AppHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sibawaya Verbs Practice',
            style: appbarTextStyle,
          ),
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
    );
  }
}
