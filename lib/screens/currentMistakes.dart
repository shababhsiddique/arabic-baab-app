import 'package:baab_practice/helper/arabic.dart';
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
      appBar: AppBar(title: const Text('Previous Mistakes')),
      body: verbs.isEmpty
          ? Text("No mistake history found")
          : SingleChildScrollView(
            child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            width: MediaQuery.of(context).size.width,
            child: PaginatedDataTable(
              header: const Text('Available Verbs'),
              columns: const [
                DataColumn(label: Text('#')),
                DataColumn(label: Text('${ArabicTerms.maadi} (Past)')),
                DataColumn(label: Text('${ArabicTerms.meaning}  (Meaning)')),
                DataColumn(label: Text('Mistake History')),
              ],
              source: VerbsDataSource(verbs),
              rowsPerPage: 10, // Number of rows per page
            ),
                    ),
                  ),
          ),
    );
  }
}

class VerbsDataSource extends DataTableSource {
  final List<ArabicVerb> verbs;

  VerbsDataSource(this.verbs);

  @override
  DataRow getRow(int index) {
    final verb = verbs[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())), // Serial number
      DataCell(Text(verb.maadi)),
      DataCell(Text(verb.bengaliMeaning)),
      DataCell(Text("${verb.failHistory??0}")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => verbs.length;

  @override
  int get selectedRowCount => 0;
}
