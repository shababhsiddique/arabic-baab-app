import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/helper/arabic.dart';
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
                ? 50
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
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 50,
                  child: SelectableText(
                    question,
                    style: MyTextStyles.cardTitle,
                    textDirection: TextDirection.rtl, // Right-to-left for Arabic
                  ),
                ),
                SizedBox(height: 8),
                createDataRow(ArabicTerms.maadi,  arabicVerb.maadi , showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.mudari, arabicVerb.mudari, showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.meaning, arabicVerb.bengaliMeaning, showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.masdar, arabicVerb.masdar, showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.amr, arabicVerb.amr??"", showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.nahi, arabicVerb.nahi??"", showingAnswer),
                SizedBox(height: 3),
                createDataRow(ArabicTerms.baab, arabicVerb.baab, showingAnswer),
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

                      if(applicationControl.checkUpdate != true){
                        applicationControl.checkAppUpdateAvailable(
                            showUpdateAlert: (){
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Update Available!"),
                                  content: Text("There is a new version available. Please update app from store to enjoy more words and features."),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            }
                        );
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
      Container(
        constraints: BoxConstraints(
          minWidth: 85
        ),
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
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: SelectableText(
            showAnswer ? value : "guess...",
            style: MyTextStyles.cardColumnValue.copyWith(
              fontSize: (title == ArabicTerms.meaning ? 19 :null),
              color: !showAnswer ? Colors.grey : null,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      )
    ],
  );
}
