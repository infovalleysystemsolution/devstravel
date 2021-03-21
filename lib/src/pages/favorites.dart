import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';
import '../partials/customappbar.dart';
import '../partials/customdrawer.dart';
import '../partials/citybox.dart';

class FavoritesPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  TextStyle styles = TextStyle(
      fontSize: 15, fontWeight: FontWeight.bold, fontFamily: 'Helvetica Neue');

  @override
  Widget build(BuildContext context) {
    return Consumer<AppData>(builder: (ctx, appdata, child) {
      List favorites = appdata.favoritesCities();

      return Scaffold(
        key: _scaffoldkey,
        appBar: CustomAppBar(
            scaffoldkey: _scaffoldkey,
            pageContext: context,
            title: 'Cidades Salvas'),
        drawer: CustomDrawer(pageContext: context),
        backgroundColor: Colors.white,
        body: GridView.count(
          crossAxisCount: 2,
          /*shrinkWrap: true,*/
          /*physics: NeverScrollableScrollPhysics(),*/
          children: List.generate(favorites.length, (index) {
            return CityBox(
              data: favorites[index],
              onTap: (cityData) {
                var cityData2 = cityData;
                Navigator.pushNamed(context, '/city', arguments: cityData2);
              },
            );
          }),
        ),
      );
    });
  }
}

/*
Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Text('Bem vindo(a) ao', style: styles),
                    ),
                    Image.asset('lib/assets/flutter1_devstravel_logo.png',
                        width: 200),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text('Seu guia de viagem perfeito', style: styles),
                    ),
                  ],
                  ),
*/
