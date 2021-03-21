import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPage createState() => _PreloadPage();
}

class _PreloadPage extends State<PreloadPage> {
  bool loading = true;

  void requestInfo() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      loading = true;
    });

    bool req = await Provider.of<AppData>(context, listen: false).requestData();

    if (req) {
      Navigator.pushReplacementNamed(
          context, '/home'); /* pushReplacementNamed */
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void initState() {
    super.initState();
    requestInfo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('lib/assets/flutter1_devstravel_logo.png', width: 200),
            loading
                ? Container(
                    margin: EdgeInsets.all(30),
                    child: Text('Carregando Informações...',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  )
                : Container(),
            loading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                : Container(),
            !loading
                ? Container(
                    margin: EdgeInsets.all(30),
                    child: ElevatedButton(
                      child: Text('Tentar Novamente'),
                      onPressed: () {
                        requestInfo();
                      },
                    ))
                : Container(),
          ]),
    ));
  }
}
