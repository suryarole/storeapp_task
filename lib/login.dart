import 'package:flutter/material.dart';
import 'package:storeapp_task/const.dart';
import 'package:storeapp_task/otpPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:storeapp_task/signInpage.dart'; // For JSON decoding

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _phoneNum.clear();
  }

  List<bool> _isSelected = [true, false];

  TextEditingController _phoneNum = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  void userLoginCheck() async {
    final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "mobileNumber": _phoneNum.text,
      "deviceId": deviceID,
    });

    // Perform API call here
    try {
      final response = await http.post(url, headers: headers, body: body);
      print('responseresponse ====> ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data ====> $data');
        // Navigate to HomeScreen or another screen based on the data
        // _navigateToHome();
      } else {
        // Handle the case where the API call fails
      }
    } catch (e) {
      print("objectsdasd = $e");
      // Handle any errors that occur during the API call
    }
  }

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
                  'images/img/task_logo.png',
                  height: 200,
                ),
                ToggleButtons(
                  constraints: BoxConstraints(minHeight: 30, minWidth: 100),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                  fillColor: Colors.red,
                  selectedColor: Colors.white,
                  focusColor: Colors.red,
                  children: <Widget>[
                    Text('Phone'),
                    Text('Email'),
                  ],
                  isSelected: _isSelected,
                  onPressed: (int index) {
                    setState(() {
                      _isSelected[index] = !_isSelected[index];
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Glad to see you!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please provide your phone number',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _phoneNum,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Phone'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_phoneNum.text.isNotEmpty) {
                      // userLoginCheck();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Otppage(
                                  otpText: _phoneNum.text,
                                )),
                      );
                    } else {
                      print("sdsad");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      height: 1.2,
                      fontSize: 13,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: const Text('You Dont have account,Create it!'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
