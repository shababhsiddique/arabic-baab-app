import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/controller/searchController.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/widgets/baabPracticeAppDrawer.dart';
import 'package:baab_practice/widgets/verbCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {

    final searchControl = ref.watch(searchController);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Sibawaya Verbs Search',
            style: appbarTextStyle,
          ),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
               Text("Verb not found"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
