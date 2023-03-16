import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:setting_app/Utility/colors.dart';
import 'package:setting_app/ui_widget/robotoTextWidget.dart';
import 'package:setting_app/utility/utils.dart';


class AppBarWidget extends StatefulWidget {
  final String pagetitle;

  const AppBarWidget(
      {Key? key,
      required this.pagetitle,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBarInsidePageState();
}

class _AppBarInsidePageState extends State<AppBarWidget> {
  String? loginPic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  robotoTextWidget(textval: widget.pagetitle, colorval: AppColors.white,
            sizeval: 18, fontWeight: FontWeight.bold),
         //<Widget>[]
        backgroundColor: AppColors.blue,
        elevation: 10.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        automaticallyImplyLeading: false,
      ), //AppBar//Center
     //Scaffold
    );
  }
}
