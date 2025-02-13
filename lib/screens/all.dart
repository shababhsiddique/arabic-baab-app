import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/styles.dart';
import 'package:baab_practice/widgets/verbdetail.dart';
import 'package:flutter/material.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:baab_practice/helper/hive.dart';

class AllVerbsPage extends StatefulWidget {
  const AllVerbsPage({super.key});

  @override
  _AllVerbsPageState createState() => _AllVerbsPageState();
}

class _AllVerbsPageState extends State<AllVerbsPage> {
  late final List<ArabicVerb> verbs ;

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
              columns: const [
                DataColumn(label: Text('#', style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text(ArabicTerms.maadi, style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text(ArabicTerms.mudari, style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text(ArabicTerms.masdar, style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text(ArabicTerms.baab, style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text(ArabicTerms.meaning, style: MyTextStyles.datatableHeader,)),
                DataColumn(label: Text('Mistake History', style: MyTextStyles.datatableHeader,)),
              ],
              source: VerbsDataSource(verbs, context),
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
  final BuildContext context;

  VerbsDataSource(this.verbs, this.context){
    // Sort the selectedVerbs list by the baab column
    verbs.sort((a, b) => a.baab.compareTo(b.baab));
  }

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
