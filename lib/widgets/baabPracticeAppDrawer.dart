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

    showMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }

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
              value: applicationController.includeBaabs.contains(baab),
              onChanged: (value) {
                applicationController.updateBaabSelection(
                    baab: baab, enable: value);
                showMessage("Updated word pool");
              },
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
          SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Verb Settings',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/search');
            },
          ),
          Divider(),
          ListTile(
            title: const Text('View All Verbs'),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/viewAll');
            },
          ),
          SizedBox(height: 2),
          ListTile(
            title: const Text('View Mistake History'),
            onTap: () {
              Navigator.of(context).popAndPushNamed('/viewMistake');
            },
          ),
          SizedBox(height: 2),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Practice Mistakes Only"),
                Switch(
                  value: applicationController.practiceMistakesOnly,
                  onChanged: (value) {
                    applicationController.toggleMistakeOnlyMode();
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 2),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Option:"),
                DropdownButton<String>(
                  value: applicationController.questionBy,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      applicationController.updateSelectedQuestionBy(newValue);
                      showMessage("Question By Option updated");
                    }
                  },
                  items: <String>['maadi', 'mudari', 'meaning', 'masdar', 'random']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 2),
          ListTile(
            title: const Text('Included baabs:'),
          ),
          ...baabOptions,
          Divider(),
          ListTile(
            title: const Text('Restart session'),
            onTap: () async {
              applicationController.loadSession();
              applicationController.generateNewRandomQuestionVerb();
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 2),
          ListTile(
            title: const Text('Clear Mistake History'),
            onTap: () async {
              await VerbAppDatabase.clearFailHistory();
              applicationController.loadSession();
              applicationController.generateNewRandomQuestionVerb();
              showMessage("Mistake history cleared");
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 2),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text("Dark Mode"),
                  onLongPress: () async {
                    await VerbAppDatabase.clearData();
                    await VerbAppDatabase.fillVerbsFromSource();
                    applicationController.loadSession();
                    applicationController.generateNewRandomQuestionVerb();
                    print("updated verb source");
                  },
                ),
                Switch(
                  value: applicationController.isDarkmode,
                  onChanged: (value) {
                    applicationController.toggleDarkMode();
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            child: Text(
              "v${applicationController.appVersion}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
