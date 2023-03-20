import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:setting_app/Utility/colors.dart';
import 'package:setting_app/ui_widget/robotoTextWidget.dart';
import 'package:setting_app/utility/utils.dart';

class AppBarWidget extends StatefulWidget {
  final String pagetitle;
  final EdgeInsets? customMargin;
  final bool isBackButtonNeeded;
  final dynamic onPressBack;

  const AppBarWidget(
      {Key? key,
      required this.pagetitle,
      required this.isBackButtonNeeded,
      this.customMargin,
      this.onPressBack})
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
    return Container(
      margin: widget.customMargin ?? const EdgeInsets.only(top: 30),
      child: Stack(
        children: <Widget>[
         SizedBox(
           width: MediaQuery.of(context).size.width,
           height: 55,
           child:  Card(
               elevation: 4,
               color: AppColors.blue,
               child: Padding(
                 padding: const EdgeInsets.all(5),
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         (widget.isBackButtonNeeded)
                             ? IconButton(
                             icon: const Icon(CupertinoIcons.back,size: 20,color: AppColors.white,),
                             onPressed: widget.onPressBack ??
                                     () {
                                   Navigator.pop(context);
                                 })
                             : const SizedBox(),
                         robotoTextWidget(
                           textval: widget.pagetitle.toTitleCase(),
                           colorval: AppColors.white,
                           sizeval: 16.0,
                           fontWeight: FontWeight.w800,
                         ),
                       ],
                     ),
                     const Icon(Icons.bluetooth,color: AppColors.white,size: 20,)
                   ],),
               )),

         ),
        ],
      ),
    );
  }
}
