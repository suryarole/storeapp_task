import 'package:flutter/material.dart';
import 'package:storeapp_task/const.dart';
import 'package:storeapp_task/otpPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    _emailId.clear();
  }

  List<bool> _isSelected = [false, false];

  TextEditingController _emailId = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _referralCode = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldMessengerState>();

  // void userLoginCheck() async {
  //   final url = Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp');
  //   final headers = {'Content-Type': 'application/json'};
  //   final body = json.encode({
  //     "mobileNumber": _phoneNum.text,
  //     "deviceId": deviceID,
  //   });

  //   // Perform API call here
  //   try {
  //     final response = await http.post(url, headers: headers, body: body);
  //     print('responseresponse ====> ${response.body}');
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       print('Data ====> $data');
  //       // Navigate to HomeScreen or another screen based on the data
  //       // _navigateToHome();
  //     } else {
  //       // Handle the case where the API call fails
  //     }
  //   } catch (e) {
  //     print("objectsdasd = $e");
  //     // Handle any errors that occur during the API call
  //   }
  // }

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
              
                Text(
                  'Lets Begin!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Please enter your credentials to proceed',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _emailId,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Your Email'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _password,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Create Password'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _referralCode,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Referrel Code (Optional)'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: Icon(Icons.arrow_right_alt_outlined,size: 40, color: Colors.white),
                  onPressed: () {
                    if (_emailId.text.isNotEmpty) {
                      // userLoginCheck();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => Otppage(
                      //             otpText: _phoneNum.text,
                      //           )),
                      // );
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
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
