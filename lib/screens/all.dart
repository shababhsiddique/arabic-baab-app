import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/widgets/verbRow.dart';
import 'package:flutter/material.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/helper/hive.dart';

class AllVerbsPage extends StatefulWidget {
  const AllVerbsPage({super.key});

  @override
  _AllVerbsPageState createState() => _AllVerbsPageState();
}

class _AllVerbsPageState extends State<AllVerbsPage> {
  late final List<ArabicVerb> verbs;

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  Future<void> _loadVerbs() async {
    List<ArabicVerb> fetchedVerbs = VerbAppDatabase.fetchVerbs();
    setState(() {
      verbs = fetchedVerbs;
      print("fetched verbs state set");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Verbs Table')),
      body: verbs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Builder(builder: (context) {
              List<Widget> wordGroup = [];

              for (String baab in ArabicTerms.listOfBaabs) {
                wordGroup.add(Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    baab,
                    style: MyTextStyles.cardTitle,
                  ),
                ));
                for (ArabicVerb verb in verbs) {
                  if (verb.baab == baab) {
                    wordGroup.add(VerbRow(verb: verb));
                  }
                }
              }

              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: wordGroup, // Number of rows per page
                ),
              );
            }),
    );
  }
}
