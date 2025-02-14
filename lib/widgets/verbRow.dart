
import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';

class VerbRow extends StatelessWidget {
  final ArabicVerb verb;

  const VerbRow({super.key, required this.verb});

  @override
  Widget build(BuildContext context) {

    Widget buildRow(title, data){
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title :", style: MyTextStyles.cardColumnHeading,),
            Text(data,
              style: MyTextStyles.cardColumnValue.copyWith(
                fontSize: (title == ArabicTerms.meaning ? 19 :null),
              ),
              overflow: TextOverflow.fade,
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text(
                  verb.maadi,
                  textAlign: TextAlign.center,
                  style: MyTextStyles.cardTitle,
                ),
                content: Container(
                  height: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: 290
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRow(ArabicTerms.mudari,verb.mudari),
                        buildRow(ArabicTerms.meaning,verb.bengaliMeaning),
                        buildRow(ArabicTerms.amr,verb.amr??""),
                        buildRow(ArabicTerms.nahi,verb.nahi??""),
                        buildRow(ArabicTerms.masdar,verb.masdar),
                        buildRow(ArabicTerms.baab,verb.baab),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            }
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.grey.withAlpha(30),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(verb.maadi, style: MyTextStyles.cardListRowTextArabic, overflow: TextOverflow.fade,),
                Text("  -  "),
                Text(verb.mudari, style: MyTextStyles.cardListRowTextArabic, overflow: TextOverflow.fade,),
              ],
            ),
            Text(verb.bengaliMeaning, style: MyTextStyles.cardListRowText, overflow: TextOverflow.fade,),
          ],
        ),
      ),
    );
  }
}
