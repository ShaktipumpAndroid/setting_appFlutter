import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:setting_app/login/model/PumpCodeModel.dart';
import 'package:setting_app/ui_widget/robotoTextWidget.dart';
import 'package:setting_app/utility/string.dart';
import 'package:setting_app/web_service/HTTP.dart' as HTTP;

import '../Utility/colors.dart';
import '../home_page/HomePage.dart';
import '../web_service/APIDirectory.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false;
  var isloader = false;
  var pumpCode = pumpCodeTxt;
  var openScanner = openScannerTxt;

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
          Container(
            width: double.infinity,
            height: 340,
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Center(
                child: Image.asset(
                  "assets/logo.png",
                  height: 250,
                  width: 250,
                ),
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 70,
                              width: double.infinity,
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      robotoTextWidget(
                                          textval: openScanner,
                                          colorval: AppColors.black,
                                          sizeval: 14,
                                          fontWeight: FontWeight.w400),
                                      IconButton(
                                          padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: AppColors.black,
                                            size: 25,
                                          ),
                                          onPressed: () {
                                            scanQRCode();
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextWidget(pumpCode),
                            const SizedBox(
                              height: 15,
                            ),

                            Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  //set border radius more than 50% of height and width to make circle
                                ),
                                child: Container(
                                    width: double.infinity,
                                    height: 50,

                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0)
                                          )),

                                      onPressed: () {
                                        setState(() {
                                          isloader = true;

                                        });
                                        Future.delayed(
                                            const Duration(seconds: 3), () {
                                          setState(() {
                                            isloader = false;
                                          });
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                        });
                                      },
                                      child: isloader
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ],
                                            )
                                          :   robotoTextWidget(
                                          textval: submit,
                                          colorval: AppColors.white,
                                          sizeval: 14,
                                          fontWeight: FontWeight.w400),
                                    )))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  TextWidget(String text) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey.shade500,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              robotoTextWidget(
                  textval: pumpCode,
                  colorval: AppColors.black,
                  sizeval: 14,
                  fontWeight: FontWeight.w400),
            ],
          ),
        ),
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;
      if (qrCode != null && !qrCode.isEmpty && qrCode.toString() != "-1") {
        setState(() {
          openScanner = qrCode;
          isLoading = true;
          print("isLoading");
          print(isLoading);
          retrievePumpCode();
        });
      }
    } on PlatformException {
      openScanner = 'Failed to scan QR Code.';
    }
  }

  void retrievePumpCode() async {
    dynamic response = await HTTP.get(context, userLogin(openScanner));
    if (response != null && response.statusCode == 200) {
      isLoading = false;
      var jsonData = convert.jsonDecode(response.body);
      PumpCodeModel pumpCodeModel = PumpCodeModel.fromJson(jsonData);
      setState(() {
        pumpCode = pumpCodeModel.response.materialNumber.toString();
      });
    }
  }
}
