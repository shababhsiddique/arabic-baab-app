import 'package:baab_practice/controller/appController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaabPracticeAppDrawer extends ConsumerWidget {
  const BaabPracticeAppDrawer({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Drawer(
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
            title: const Text('Search'),
            onTap: () {
              Navigator.of(context).popAndPushNamed(  '/search');
            },
          ),

          SizedBox(height: 20),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode"),
                Switch(
                  value:  ref.read(appController).isDarkmode,
                  onChanged: (value) {
                    ref.read(appController).toggleDarkmode();
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
