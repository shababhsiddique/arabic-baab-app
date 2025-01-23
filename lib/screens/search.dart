import 'package:baab_practice/helper/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.blueAccent,
          title: Text(
            'Verbs Search',
            style: appbarTextStyle,
          ),
        ),
        body: SingleChildScrollView(
          child: Text("Under construction"),
        ),
      ),
    );
  }
}
