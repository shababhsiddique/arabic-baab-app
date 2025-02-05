import 'package:baab_practice/controller/appController.dart';
import 'package:baab_practice/controller/searchController.dart';
import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
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
                    vertical: 5,
                  ),
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    controller: _searchBoxController,
                    decoration: InputDecoration(
                      hintText: 'حمل/বহন করা...',
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
                SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: PaginatedDataTable(
                        columns: const [
                          DataColumn(label: Text(ArabicTerms.maadi, style: MyTextStyles.datatableHeader,)),
                          DataColumn(label: Text(ArabicTerms.meaning, style: MyTextStyles.datatableHeader,)),
                          DataColumn(label: Text(ArabicTerms.mudari, style: MyTextStyles.datatableHeader,)),
                          DataColumn(label: Text(ArabicTerms.masdar, style: MyTextStyles.datatableHeader,)),
                          DataColumn(label: Text(ArabicTerms.baab, style: MyTextStyles.datatableHeader,)),
                        ],
                        source: VerbsDataSource(searchControl.searchedVerbs),
                        rowsPerPage: 9, // Number of rows per page
                      ),
                    ),
                  ),
                )
                //SearchWordCard(searchControl: searchControl)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerbsDataSource extends DataTableSource {
  final List<ArabicVerb> verbs;

  VerbsDataSource(this.verbs){
    // Sort the selectedVerbs list by the baab column
    //verbs.sort((a, b) => a.baab.compareTo(b.baab));
  }

  @override
  DataRow getRow(int index) {
    final verb = verbs[index];
    return DataRow(cells: [
      DataCell(Text(verb.maadi)),
      DataCell(Text(verb.bengaliMeaning)),
      DataCell(Text(verb.mudari)),
      DataCell(Text(verb.masdar)),
      DataCell(Text(verb.baab)),

    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => verbs.length;

  @override
  int get selectedRowCount => 0;
}


class SearchWordCard extends StatelessWidget {
  const SearchWordCard({
    super.key,
    required this.searchControl,
  });

  final SearchControllerState searchControl;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            createDataRow(ArabicTerms.maadi,
                searchControl.searchedVerb?.maadi ?? "", true),
            SizedBox(height: 3),
            createDataRow(ArabicTerms.mudari,
                searchControl.searchedVerb?.mudari ?? "", true),
            SizedBox(height: 3),
            createDataRow(ArabicTerms.masdar,
                searchControl.searchedVerb?.masdar ?? "", true),
            SizedBox(height: 3),
            createDataRow(
                ArabicTerms.meaning,
                searchControl.searchedVerb?.bengaliMeaning ?? "",
                true),
            SizedBox(height: 3),
            createDataRow(ArabicTerms.baab,
                searchControl.searchedVerb?.baab ?? "", true),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
