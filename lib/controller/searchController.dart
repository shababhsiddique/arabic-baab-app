// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
import 'dart:math';

import 'package:baab_practice/helper/arabic.dart';
import 'package:baab_practice/helper/hive.dart';
import 'package:baab_practice/helper/preferences.dart';
import 'package:baab_practice/model/ArabicVerb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchController = ChangeNotifierProvider<SearchControllerState>((ref) => SearchControllerState());


class SearchControllerState extends ChangeNotifier {


  //final ref;
  SearchControllerState() {

    loadSession();
  }

  loadSession(){

  }



}
