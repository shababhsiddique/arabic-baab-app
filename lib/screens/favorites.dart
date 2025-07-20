import 'package:baab_practice/widgets/verbRow.dart';
import 'package:flutter/material.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/helper/hive.dart';

class AllFavoritesPage extends StatefulWidget {
  const AllFavoritesPage({super.key});

  @override
  _AllFavoritesPageState createState() => _AllFavoritesPageState();
}

class _AllFavoritesPageState extends State<AllFavoritesPage> {
  List<ArabicVerb> verbs = [];

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  Future<void> _loadVerbs() async {
    List<ArabicVerb> fetchedVerbs = VerbAppDatabase.fetchVerbsWithFavorite();
    setState(() {
      verbs = fetchedVerbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Verbs')),
      body: verbs.isEmpty
          ? Center(
              child: Text("No favorite verbs found. Mark verbs as favorite to see them here."),
            )
          : Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: verbs
                    .map((item) => VerbRow(verb: item))
                    .toList(),
              ),
            ),
    );
  }
}