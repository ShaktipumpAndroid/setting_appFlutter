import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:setting_app/home_page/model/HomeListModel.dart';
import 'package:setting_app/web_service/HTTP.dart' as HTTP;

import '../Utility/colors.dart';
import '../ui_widget/appbar.dart';
import '../ui_widget/robotoTextWidget.dart';
import '../utility/string.dart';
import '../web_service/APIDirectory.dart';

class HomePageListItem extends StatefulWidget {
  String pumpCode;

  HomePageListItem({Key? key, required this.pumpCode}) : super(key: key);

  @override
  State<HomePageListItem> createState() => _HomePageListItemState();
}

class _HomePageListItemState extends State<HomePageListItem> {
  var isLoading = false;
  List<Response> homePageList = [];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    if (homePageList.isEmpty) {
      _firstLoad();
    }
  }

  Future<void> _firstLoad() async {
    setState(() {
      isLoading = true;
    });
    dynamic response = await HTTP.get(context, gethomeList(widget.pumpCode));
    if (response != null && response.statusCode == 200) {
      setState(() {
        isLoading = false;
        homePageList = (jsonDecode(response.body)['response'] as List)
            .map((i) => Response.fromJson(i))
            .toList();
      });
    } else {
      Errormsg = jsonDecode(response.body)['message'];
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(
              pagetitle: appName,
              isBackButtonNeeded: false,
            ),
             SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        :getHomeList(homePageList))
          ],
        ),
      ),
    );
  }

  Widget getHomeList(List<Response> homePageList) {
    return Scaffold(
        body: Container(
                child: homePageList.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          //onSelectTripDetailPage(context);
                        },
                        child: ListView.builder(
                          controller: _controller,
                          itemBuilder: (context, index) {
                            return HomeListItem(index);
                          },
                          itemCount: homePageList.length,
                          padding: const EdgeInsets.all(8),
                        ))
                    : showNoDataFound()));
  }

  Widget HomeListItem(int index) {
    return Wrap(children: [
      GestureDetector(
        onTap: () {},
        child: Card(
            color: const Color(0xFFE4F3F5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(children: <Widget>[
                      const Center(child: robotoTextWidget(textval: "test", colorval: AppColors.black, sizeval: 14, fontWeight: FontWeight.w400),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        setGetWidget(getTxt,homePageList[index]),
                        retrieveValue(homePageList[index]),
                        setGetWidget(setTxt,homePageList[index])
                      ],
                    )
                  ],),
                ),
              ],
            )),
      )
    ]);
  }


  Widget setGetWidget(String txt, Response homePageList) {
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
              textval: txt,
              colorval: AppColors.white,
              sizeval: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {},
    );
  }

  Widget retrieveValue(Response homePageList) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 150,
      height: 50,
      child: TextFormField(
        initialValue: homePageList.pValue.toString(),
        decoration: InputDecoration(
          hintText: "Please enter digit",
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            //<-- SEE HERE
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
          //  onUpdate(index,value);
        },
        onSaved: (newValue) {
          // Handle the saved input value
        },
      ),
    );
  }

  Widget showNoDataFound() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        margin: const EdgeInsets.all(10),
        child: Card(
            elevation: 5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: robotoTextWidget(
                        textval: Errormsg,
                        colorval: AppColors.blue,
                        sizeval: 14,
                        fontWeight: FontWeight.w800),
                  ),
                  Container(
                      height: 40,
                      width: 120,
                      margin: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          _firstLoad();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: robotoTextWidget(
                          textval: retry,
                          colorval: AppColors.white,
                          sizeval: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
