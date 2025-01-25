import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/widgets/baabPracticeAppDrawer.dart';
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
                (applicationController.currentSessionVerbs.isEmpty ? Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                          "Congratulations you have finished your session",
                        style: MyTextStyles.cardTitle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 200,
                        color: Color(0xFF00D1D1),
                        child: TextButton(
                          onPressed: () {
                            applicationController.loadSession();
                            applicationController.setShowAnswer(false);
                            applicationController.generateNewRandomQuestionVerb();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Restart",
                                style: MyTextStyles.cardButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ):Container()),
                (applicationController.currentQuestionVerb != null
                    ? VerbCard(
                  question: applicationController.currentQuestionText,
                  arabicVerb: applicationController.currentQuestionVerb!,
                )
                    : Text("No Question Found")),
                Text("Currently showing ${applicationController.includeBaabs.toString()}"),
                Text("Verbs left ${applicationController.getCurrentSessionWordsLeft()}"),
                Text("Incorrect count ${applicationController.geCurrentIncorrectCount()}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
