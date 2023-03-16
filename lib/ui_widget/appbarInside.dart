import 'package:flutter/material.dart';
import 'package:setting_app/Utility/colors.dart';
import 'package:setting_app/ui_widget/robotoTextWidget.dart';
import 'package:setting_app/utility/utils.dart';


class AppBarInsideWidget extends StatefulWidget {
  final String pagetitle;
  final bool isBackButtonNeeded;
  final dynamic onPressBack;
  final EdgeInsets? customMargin;
  const AppBarInsideWidget(
      {Key? key,
      required this.pagetitle,
      this.isBackButtonNeeded = true,
      this.onPressBack,
      this.customMargin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBarInsidePageState();
}

class _AppBarInsidePageState extends State<AppBarInsideWidget> {
  String? loginPic;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.customMargin ??
          const EdgeInsets.only(top: 30, left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          Card(
              elevation: 4,
              color: AppColors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.isBackButtonNeeded)
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back,size: 25,color: AppColors.white,),
                          onPressed: widget.onPressBack ??
                              () {
                                Navigator.pop(context);
                              })
                      : const SizedBox(),
                  robotoTextWidget(
                    textval: widget.pagetitle.toTitleCase(),
                    colorval: AppColors.white,
                    sizeval: 18.0,
                    fontWeight: FontWeight.w800,
                  ),

                ],
              )),
        ],
      ),
    );
  }
}
