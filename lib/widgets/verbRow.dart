
import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerbRow extends ConsumerWidget {
  final ArabicVerb verb;
  final bool showFail;

  const VerbRow({super.key, required this.verb, this.showFail = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationControl = ref.watch(appController);

    Widget buildRow(title, data, {direction= TextDirection.rtl,}){
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title :", style: MyTextStyles.cardColumnHeading),
            SelectableText(data,
              textDirection: direction,
              style: MyTextStyles.cardColumnValue.copyWith(
                fontSize: (title == ArabicTerms.meaning ? 19 :null),
                overflow: TextOverflow.fade,
              ),
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        verb.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: verb.isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        applicationControl.toggleFavorite(verb);
                      },
                    ),
                    Expanded(
                      child: SelectableText(
                        verb.maadi,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: MyTextStyles.cardTitle,
                      ),
                    ),
                  ],
                ),
                content: Container(
                  height: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: showFail ? 310 : 290
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        buildRow(ArabicTerms.mudari,verb.mudari),
                        buildRow(ArabicTerms.meaning,verb.bengaliMeaning, direction: TextDirection.ltr),
                        buildRow(ArabicTerms.amr,verb.amr??""),
                        buildRow(ArabicTerms.nahi,verb.nahi??""),
                        buildRow(ArabicTerms.masdar,verb.masdar),
                        buildRow(ArabicTerms.baab,verb.baab),
                        showFail ? buildRow("Mistakes","${verb.failHistory??0} (${verb.failCounter})", direction: TextDirection.ltr) : Container(),
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
                SelectableText(verb.maadi, style: MyTextStyles.cardListRowTextArabic.copyWith(
                  overflow: TextOverflow.fade
                ),),
                showFail ? SelectableText(" (${verb.failHistory})"): Container(),
                SelectableText("  -  "),
                SelectableText(verb.mudari, style: MyTextStyles.cardListRowTextArabic.copyWith(
                    overflow: TextOverflow.fade
                ), ),
              ],
            ),
            Row(
              children: [
                SelectableText(verb.bengaliMeaning, style: MyTextStyles.cardListRowText.copyWith(
                    overflow: TextOverflow.fade
                ),),
                IconButton(
                  icon: Icon(
                    verb.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: verb.isFavorite ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    applicationControl.toggleFavorite(verb);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
