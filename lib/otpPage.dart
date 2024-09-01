import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:storeapp_task/homePage.dart';

class Otppage extends StatefulWidget {
  const Otppage({super.key, required this.otpText});

  final String otpText;

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  void otpCheck(String pinNum) async {}

  TextEditingController _phoneNum = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Field is Empty"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    );
    return MaterialApp(
      home: Scaffold(
        key: _globalKey,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'images/img/one-time-password.png',
                  height: 100,
                ),

                SizedBox(
                  height: 20,
                ),
                Text(
                  'OTP Verification',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'We have sent a unique OTP number',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'to your mobile +91 ${widget.otpText}',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),

                SizedBox(
                  height: 30,
                ),
                OtpPinField(
                  maxLength: 4,
                  fieldWidth: 40.0,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                  onSubmit: (String pin) {
                    print("asdasdasasdasdasdasdasdasddad $pin");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  onChange: (String pin) {
                    print("asdasdasdad");
                  },
                ),
                // ElevatedButton(
                //   child: Text(
                //     'Submit',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   onPressed: () {
                //     if (_phoneNum.text.isNotEmpty) {

                //     } else {
                //       print("sdsad");
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) {
                //           return alert;
                //         },
                //       );
                //     }
                //   },
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.red,
                //       padding:
                //           EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //       textStyle: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.normal,
                //           color: Colors.white)),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
