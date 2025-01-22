import 'package:baab_practice/config/styles.dart';
import 'package:baab_practice/model/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
verbCard({required Verb verb}){
  return Card(
    child: Column(
      children: [
        cardDataRow(heading: "Maadi", value: verb.maadi),
        cardDataRow(heading: "Mudari", value: verb.mudari),
        cardDataRow(heading: "Meaning", value: verb.bengali),
        cardDataRow(heading: "Masdar", value: verb.masdar),
        cardDataRow(heading: "Baab", value: verb.baab),
      ],
    ),
  );
}
cardDataRow({required String heading, required String value}) {
  return Row(
    children: <Widget>[Text(heading), Text(value)],
  );
}
*/

import 'package:flutter/material.dart';

class VerbCard extends StatelessWidget {
  final Verb arabicVerb;
  final String question;

  const VerbCard({
    Key? key,
    required this.arabicVerb,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 20,
        left: 20,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Arabic Word with Tashkeel
            Center(
              child: Text(
                question,
                style: myTextStyles.cardTitle,
                textDirection: TextDirection.rtl, // Right-to-left for Arabic
              ),
            ),
            SizedBox(height: 10),
            createDataRow("Maadi", arabicVerb.maadi),
            SizedBox(height: 8),
            createDataRow("Mudari", arabicVerb.mudari),
            SizedBox(height: 8),
            createDataRow("Masdar", arabicVerb.masdar),
            SizedBox(height: 8),
            createDataRow("Bengali", arabicVerb.bengali),
            SizedBox(height: 8),
            createDataRow("Baab", arabicVerb.baab),
            SizedBox(height: 8),

            // Action Buttons (e.g., Favorite, Share)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text("Correct",
                          style: myTextStyles.cardButton),
                    ],
                  ),
                  onPressed: () {
                    // Handle favorite action
                  },
                ),
                IconButton(
                  icon: Row(
                    children: [
                      Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 25,
                      ),
                      SizedBox(width: 5),
                      Text("Incorrect",
                          style: myTextStyles.cardButton.copyWith(
                            color: Colors.redAccent,
                          )),
                    ],
                  ),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createDataRow(String title, String value) {
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
                style: myTextStyles.cardColumnHeading,
              ),
              Text(
                ":",
                style: myTextStyles.cardColumnHeading,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Text(
            value,
            style: myTextStyles.cardColumnValue,
          ),
        )
      ],
    );
  }
}
