import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/hive.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaabPracticeAppDrawer extends ConsumerWidget {
  const BaabPracticeAppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationController = ref.watch(appController);

    List<ListTile> baabOptions = [];

    for (var baab in ArabicTerms.listOfBaabs) {
      baabOptions.add(ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              baab,
              style: MyTextStyles.radioArabicBaab,
            ),
            Switch(
              value: applicationController.includeBaabs
                  .contains(baab),
              onChanged: (value) {},
            )
          ],
        ),
      ));
    }

    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Arabic Verbs Practice Helper App',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            title: const Text('Update Verb Source'),
            onTap: () async {
              await VerbAppDatabase.fillVerbsFromSource();
              applicationController.loadSession();
              applicationController.generateNewRandomQuestionVerb();
            },
          ),
          SizedBox(height: 7),

          /*ListTile(
            title: const Text('Empty DB'),
            onTap: () {
              VerbAppDatabase.clearData();
            },
          ),
          SizedBox(height: 7),*/

          ListTile(
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/search');
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Included baabs:'),
          ),
          ...baabOptions,
          Divider(),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                Switch(
                  value: applicationController.isDarkmode,
                  onChanged: (value) {
                    applicationController.toggleDarkMode();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
