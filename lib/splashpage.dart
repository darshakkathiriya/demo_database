import 'package:demo_database/view_page.dart';
import 'package:flutter/material.dart';

import 'DBHelper.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gonext();
  }

  gonext() {
    DBHelper.createMyDB().then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return ViewPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
