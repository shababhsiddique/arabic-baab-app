import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';

showVerbDetails(BuildContext context, ArabicVerb verb){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(verb.maadi),
      content: Column(
        children: [
          Text("${ArabicTerms.mudari} ${verb.mudari}"),
          Text("${ArabicTerms.meaning} ${verb.bengaliMeaning}"),
          Text("${ArabicTerms.masdar} ${verb.masdar}"),
          Text("${ArabicTerms.baab} ${verb.baab}"),
        ],
      ),
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