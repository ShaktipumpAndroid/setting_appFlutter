import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setting_app/login/model/ParameterListModel.dart';
import 'package:setting_app/ui_widget/appbar.dart';
import '../Utility/colors.dart';
import '../ui_widget/robotoTextWidget.dart';
import '../utility/string.dart';
import 'package:setting_app/web_service/HTTP.dart' as HTTP;
import '../web_service/APIDirectory.dart';



class HomePage extends StatefulWidget {
    String pumpcode;
   HomePage({Key? key ,required this.pumpcode}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var isLoading = false;
  final List<String> _textFields = List.generate(20, (index) => '') ;
  List<Response> parameterArraylist = [];

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
      body: Stack(
        children: [
          AppBarWidget(
            pagetitle: appName,
          ),
          isLoading?Center(child: CircularProgressIndicator(),): Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),

            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return cardWidget(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cardWidget(int index) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [getterWidget(), editWidget(index), setterWidget()],
        ),
      ),
    );
  }

  getterWidget() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(6),
        width: 70,
        height: 35,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: robotoTextWidget(
              textval: get,
              colorval: AppColors.white,
              sizeval: 20,
              fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {},
    );
  }

  setterWidget() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(6),
        width: 70,
        height: 35,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: robotoTextWidget(
              textval: set,
              colorval: AppColors.white,
              sizeval: 20,
              fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {},
    );
  }

  editWidget(int index) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 150,
      height: 50,
      child: TextFormField(
        initialValue: "" ,
        decoration: InputDecoration(
          hintText:    "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field can not be empty';
          }
          return null;
        },
        onChanged: (value) {
          // Handle input changes
          onUpdate(index,value);
        },
        onSaved: (newValue) {
          // Handle the saved input value

        },
      ),
    );
  }

  void onUpdate(int key, String value) {

    print( _textFields[key] = value);


  }

  void retrievePumpCodeList() async {
    dynamic response = await HTTP.get(context, listDetails(widget.pumpcode));
    if (response != null && response.statusCode == 200) {
      
      parameterArraylist = (jsonDecode(response.body)['response'] as List).map((i) => Response.fromJson(i)).toList();

    }
  }

}
