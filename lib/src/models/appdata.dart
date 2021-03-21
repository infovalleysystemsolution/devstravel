import 'dart:convert'; // jsonDecode

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppData with ChangeNotifier {
  var data = [];

  var favorites = [];

  List favoritesCities() {
    List result = [];

    for (var favorite in favorites) {
      List foundCities = this.searchCity(favorite);
      if (foundCities.length > 0) {
        result.add(foundCities[0]);
      }
    }
    return result;
  }

  bool hasFavorite(cityName) {
    return favorites.contains(cityName);
  }

  bool favorite(cityName) {
    if (this.hasFavorite(cityName)) {
      favorites.remove(cityName);
      return false;
    } else {
      favorites.add(cityName);
    }
  }

  void setData(newData) {
    data = newData;
    notifyListeners();
  }

  List searchCity(text) {
    List result = [];
    text = text.trim().toLowerCase();
    if (text == '') return result;

    for (var continents in data) {
      for (var country in continents['çountries']) {
        for (var city in country['cities']) {
          if (city['name'].toLowerCase().contains(text)) {
            result.add(city);
          }
        }
      }
    }

    return result;
  }

  Future<bool> requestData() async {
    final res = await http.get('https://api.b7web.com.br/flutter1wb/');
    if (res.statusCode == 200) {
      // inserir os dados em DATA
      // print(res.body);
      setData(jsonDecode(res.body));
      return true;
    } else {
      return false;
    }
  }
}
