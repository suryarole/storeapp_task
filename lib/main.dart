import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON decoding
import 'package:device_info_plus/device_info_plus.dart';
import 'package:storeapp_task/const.dart';
import 'package:storeapp_task/homePage.dart';
import 'package:storeapp_task/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Splash API Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Set the SplashScreen as the initial route
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
    _loadData();
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = androidInfo.model; // e.g. "Pixel 2 XL"
          deviceID = androidInfo.id; // e.g. "abc123def456"
          deviceOs = androidInfo.device; // e.g. "abc123def456"
        });
        print("object======`. $deviceOs");
      }
    } catch (e) {
      print('Failed to get device info: $e');
    }
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {}); // Delay for 3 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  Future<void> _loadData() async {
    // Simulate a delay for the splash screen
    await Future.delayed(Duration(seconds: 2));

    final url =
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/device/add');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      "deviceType": "andriod",
      "deviceId": deviceID,
      "deviceName": deviceName,
      "deviceOSVersion": "2.3.6",
      "deviceIPAddress": "11.433.445.66",
      "lat": 9.9312,
      "long": 76.2673,
      "buyer_gcmid": "",
      "buyer_pemid": "",
      "app": {
        "version": "1.20.5",
        "installTimeStamp": "2022-02-10T12:33:30.696Z",
        "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
        "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
      }
    });

    // Perform API call here
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data ====> $data');
        // Navigate to HomeScreen or another screen based on the data
        _navigateToHome();
      } else {
        // Handle the case where the API call fails
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ErrorScreen()),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ErrorScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            'images/img/intro.jpg'), // Show a loading indicator while the API call is in progress
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final dynamic data;

  HomeScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Text('API Data: ${data.toString()}'),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error Screen')),
      body: Center(
        child: Text('An error occurred!'),
      ),
    );
  }
}
