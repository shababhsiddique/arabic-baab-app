import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/helper/hive.dart';
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
            title: const Text('Refill Verbs'),
            onTap: () {
              VerbAppDatabase.fillVerbsFromSource();
            },
          ),
          SizedBox(height: 7),

          ListTile(
            title: const Text('Get'),
            onTap: () {
              ArabicVerb? v = VerbAppDatabase.getVerbByMaadi('كَتَبَ');
              if(v != null){
                print("vrb found - ${v.mudari} ${v.masdar}");
              }
            },
          ),
          SizedBox(height: 7),

          ListTile(
            title: const Text('Check list'),
            onTap: () {
              VerbAppDatabase.fetchVerbs();
            },
          ),
          SizedBox(height: 7),

          ListTile(
            title: const Text('Empty DB'),
            onTap: () {
              VerbAppDatabase.clearData();
            },
          ),
          SizedBox(height: 7),

          ListTile(
            title: const Text('LeftWords'),
            onTap: () {
              applicationController.getCurrentSessionWordsLeft();
            },
          ),
          SizedBox(height: 7),

          ListTile(
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(  '/search');
            },
          ),
          SizedBox(height: 7),
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
