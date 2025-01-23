import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/widgets/baab_practice_app_drawer.dart';
import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/widgets/verbCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppHome extends ConsumerWidget {
  const AppHome({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {

    final applicationController = ref.watch(appController);


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
          child: Center(
            child: Column(
              children: [
                (applicationController.currentQuestionVerb != null
                    ? VerbCard(
                  question: applicationController.currentQuestionText,
                  arabicVerb: applicationController.currentQuestionVerb!,
                )
                    : Text("No Question Found")),
                Text("Currently showing ALL"),
                Text("Verbs left ${applicationController.getCurrentSessionWordsLeft()}"),
                Text("Incorrect count ${applicationController.geCurrenttIncorrectCount()}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
