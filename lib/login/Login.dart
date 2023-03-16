import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Utility/colors.dart';
import '../Utility/string.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
          isLoading?const Center(child: CircularProgressIndicator(),)
              :Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                Text(openscanner,
                                    style: const TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left),
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
                      Container(
                        margin: const EdgeInsets.all(25),
                        child: Center(
                            child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            child: Text(submit, style: const TextStyle(fontSize: 18)),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                          ),
                        )),
                      ),
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
              Text(text,
                  style: const TextStyle(fontSize: 16), textAlign: TextAlign.left),
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
