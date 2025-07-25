import 'package:baab_practice/screens/all.dart';
import 'package:baab_practice/screens/currentMistakes.dart';
import 'package:baab_practice/screens/favorites.dart';
import 'package:baab_practice/screens/home.dart';
import 'package:baab_practice/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final dynamic args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const AppHome(),
        );
      case '/search':
        return MaterialPageRoute(
          fullscreenDialog: false,
          builder: (_) => const SearchPage(),
        );
      case '/viewAll':
        return MaterialPageRoute(
          fullscreenDialog: false,
          builder: (_) => AllVerbsPage(),
        );
      case '/viewMistake':
        return MaterialPageRoute(
          fullscreenDialog: false,
          builder: (_) => AllMistakesPage(),
        );
      case '/viewFavorites':
        return MaterialPageRoute(
          fullscreenDialog: false,
          builder: (_) => AllFavoritesPage(),
        );

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
