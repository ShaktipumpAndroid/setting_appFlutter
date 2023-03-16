import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:setting_app/home_page/HomePage.dart';
import 'package:setting_app/ui_widget/robotoTextWidget.dart';

import '../Utility/colors.dart';
import '../Utility/string.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 340,
            decoration: const BoxDecoration(
              color: AppColors.blue,
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(100)),
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
          if (isLoading) const Center(child: CircularProgressIndicator(),) else Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
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
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                robotoTextWidget(textval: openscanner, colorval: AppColors.black, sizeval: 14, fontWeight: FontWeight.w400),

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
                      TextWidget(pumpcode),

                      SizedBox(
                        height: 15,
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child:InkWell(
                          child: Container(
                              height: 50,
                              width:  double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Center(
                                child: robotoTextWidget(textval: submit, colorval: AppColors.white, sizeval: 20, fontWeight: FontWeight.w400),
                              )
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                            print("Click event on Submit");
                          },
                        ),

                      )
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
              robotoTextWidget(textval: text, colorval: AppColors.black, sizeval: 14, fontWeight: FontWeight.w400),
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
      if (qrCode != null && !qrCode.isEmpty && qrCode.toString()!="-1") {
        setState(() {
          openscanner = qrCode;
          isLoading = true;
        });
      }
      print("QRCode_Result====>$isLoading");

    } on PlatformException {
      openscanner = 'Failed to scan QR Code.';
    }
  }
}
