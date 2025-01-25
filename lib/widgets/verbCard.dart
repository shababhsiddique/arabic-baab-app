import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VerbCard extends ConsumerWidget {
  final ArabicVerb arabicVerb;
  final String question;


  const VerbCard({
    Key? key,
    required this.arabicVerb,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {

    final applicationControl = ref.watch(appController);
    final bool showingAnswer = applicationControl.showAnswer;

    return Column(
      children: [
        Card(
          elevation: 2, // Adds shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).orientation == Orientation.portrait
                ? 80
                : 0,
            bottom: 5,
            right: 15,
            left: 15,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 500,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Arabic Word with Tashkeel
                SizedBox(height: 5),
                Center(
                  child: Text(
                    question,
                    style: MyTextStyles.cardTitle,
                    textDirection: TextDirection.rtl, // Right-to-left for Arabic
                  ),
                ),
                SizedBox(height: 10),
                createDataRow("Maadi",  arabicVerb.maadi , showingAnswer),
                SizedBox(height: 3),
                createDataRow("Mudari", arabicVerb.mudari, showingAnswer),
                SizedBox(height: 3),
                createDataRow("Masdar", arabicVerb.masdar, showingAnswer),
                SizedBox(height: 3),
                createDataRow("Bengali", arabicVerb.bengaliMeaning, showingAnswer),
                SizedBox(height: 3),
                createDataRow("Baab", arabicVerb.baab, showingAnswer),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
        // Action Buttons (e.g., Favorite, Share)
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          padding: const EdgeInsets.symmetric(
            //horizontal: 15,
            vertical: 5,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFFFCAE1E),
                  child: TextButton(
                    onPressed: () {
                      //just generate new question, keep current question in pool
                      applicationControl.setShowAnswer(false);
                      applicationControl.addToIncorrect(arabicVerb);
                      applicationControl.generateNewRandomQuestionVerb();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          showingAnswer ? "Incorrect" : "Ask Later",
                          style: MyTextStyles.cardButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width:10,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Color(0xFF00D1D1),
                  child: TextButton(
                    onPressed: () {
                      if(!showingAnswer){
                        applicationControl.setShowAnswer(true);
                      } else {
                        //You picked correct, remove current question
                        applicationControl.removeCurrentQuestionFromPool();
                        //generate new
                        applicationControl.setShowAnswer(false);
                        applicationControl.generateNewRandomQuestionVerb();
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          showingAnswer ? "Correct" : "Show Answer",
                          style: MyTextStyles.cardButton,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget createDataRow(String title, String value, bool showAnswer) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: MyTextStyles.cardColumnHeading,
            ),
            Text(
              ":",
              style: MyTextStyles.cardColumnHeading,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: Text(
          showAnswer ? value : "guess...",
          style: MyTextStyles.cardColumnValue.copyWith(
            fontSize: (title == 'Bengali' ? 20 :null),
            color: !showAnswer ? Colors.grey : null,
          ),
        ),
      )
    ],
  );
}
