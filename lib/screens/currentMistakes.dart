import 'package:baab_practice/widgets/verbRow.dart';
import 'package:flutter/material.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/helper/hive.dart';

class AllMistakesPage extends StatefulWidget {
  const AllMistakesPage({super.key});

  @override
  _AllMistakesPageState createState() => _AllMistakesPageState();
}

class _AllMistakesPageState extends State<AllMistakesPage> {
  List<ArabicVerb> verbs = [];

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  Future<void> _loadVerbs() async {
    List<ArabicVerb> fetchedVerbs = VerbAppDatabase.fetchVerbsWithMistake();
    setState(() {
      verbs = fetchedVerbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mistake History')),
      body: verbs.isEmpty
          ? Text("No mistake history found, mistake history auto populate when you make a mistake")
          : Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: verbs
              .map((item) => VerbRow(verb: item, showFail: true))
              .toList(), // Number of rows per page
        ),
      ),
    );
  }
}