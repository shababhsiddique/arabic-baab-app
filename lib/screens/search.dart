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

    TextEditingController _searchBoxController =
        TextEditingController(text: searchControl.searchString);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Verbs Search',
            style: appbarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    controller: _searchBoxController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: InkWell(
                        child: Icon(Icons.search),
                        onTap: (){
                          searchControl.search(
                            forceRefresh: true
                          );
                        },
                      ),
                    ),
                    onChanged: (query) {
                      searchControl.updateSearchString(query);
                    },
                  ),
                ),
                Card(
                  elevation: 2, // Adds shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 80
                        : 0,
                    bottom: 5,
                    right: 15,
                    left: 15,
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 500,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        createDataRow("Maadi",
                            searchControl.searchedVerb?.maadi ?? "", true),
                        SizedBox(height: 3),
                        createDataRow("Mudari",
                            searchControl.searchedVerb?.mudari ?? "", true),
                        SizedBox(height: 3),
                        createDataRow("Masdar",
                            searchControl.searchedVerb?.masdar ?? "", true),
                        SizedBox(height: 3),
                        createDataRow(
                            "Bengali",
                            searchControl.searchedVerb?.bengaliMeaning ?? "",
                            true),
                        SizedBox(height: 3),
                        createDataRow("Baab",
                            searchControl.searchedVerb?.baab ?? "", true),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
