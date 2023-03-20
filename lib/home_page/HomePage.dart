import 'package:flutter/material.dart';
import 'package:setting_app/home_page/HomePageListItem.dart';
import 'package:setting_app/ui_widget/appbar.dart';

import '../utility/string.dart';



class HomePage extends StatefulWidget {

  String pumpCode;
   HomePage({Key? key,required this.pumpCode}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(alignment: Alignment.centerRight, children: <Widget>[

        HomePageListItem(pumpCode: widget.pumpCode)


       // HomePageListItem(pumpCode: widget.pumpCode)
      ])
    );
  }}
