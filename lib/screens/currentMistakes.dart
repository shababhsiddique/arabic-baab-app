import 'package:flutter/material.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/helper/hive.dart';

class AllVerbsPage extends StatefulWidget {
  const AllVerbsPage({super.key});

  @override
  _AllVerbsPageState createState() => _AllVerbsPageState();
}

class _AllVerbsPageState extends State<AllVerbsPage> {
  List<ArabicVerb> verbs = [];

  @override
  void initState() {
    super.initState();
    _loadVerbs();
  }

  Future<void> _loadVerbs() async {
    List<ArabicVerb> fetchedVerbs = VerbAppDatabase.fetchVerbs();
    setState(() {
      verbs = fetchedVerbs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Verbs Table')),
      body: verbs.isEmpty
          ? const Center(child: CircularProgressIndicator())
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
                DataColumn(label: Text('Maadi (Past)')),
                DataColumn(label: Text('Mudari (Present)')),
                DataColumn(label: Text('Masdar (Verbal Noun)')),
                DataColumn(label: Text('Baab (Pattern)')),
                DataColumn(label: Text('Bengali Meaning')),
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
      DataCell(Text(verb.mudari)),
      DataCell(Text(verb.masdar)),
      DataCell(Text(verb.baab)),
      DataCell(Text(verb.bengaliMeaning)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => verbs.length;

  @override
  int get selectedRowCount => 0;
}
