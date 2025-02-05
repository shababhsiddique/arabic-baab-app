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


  ArabicVerb? searchedVerb;
  List<ArabicVerb> searchedVerbs = [];
  String? searchString;

  //final ref;
  SearchControllerState() {

    loadSession();
  }

  loadSession(){}

  updateSearchString(String q){

    if(searchString != q){
      print("seaching with $searchString");
      searchString = q;

      search();
    }
  }

  search({bool forceRefresh = false}){
    if(searchString != null && searchString != ""){
      var result = VerbAppDatabase.searchVerb(searchString!);
      if(result.isNotEmpty){
        searchedVerbs = result;
        print("found $searchString ${searchedVerbs.length} results");
        notifyListeners();
        return;
      }else{
        searchedVerbs = [];
        print("not found $searchString");
      }
    }else{
      searchedVerbs = [];
    }
    if(forceRefresh){
      notifyListeners();
    }
  }



}
