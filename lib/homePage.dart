import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:storeapp_task/login.dart';
import 'dart:convert';

import 'package:storeapp_task/product_card.dart';
import 'package:storeapp_task/signInpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> imageUrls = [];
  bool isLoading = true;

  List<IconItem> iconsList = [];
  List<IconItemTwo> productDeti = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<void> fetchImages() async {
    final response = await http.get(Uri.parse(
        'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categories = data['data']['category'];
      final List<dynamic> productDetail = data['data']['products'];
      // print("URL ==> $data");
      setState(() {
        for (var item in data['data']['banner_one']) {
          imageUrls.add(item['banner']);
        }

        print("URL ==> $imageUrls");

        isLoading = false;
      });
      setState(() {
        iconsList = categories.map((item) => IconItem.fromJson(item)).toList();
        isLoading = false;
        print("URL ==> $iconsList");
      });
      setState(() {
        productDeti =
            productDetail.map((item) => IconItemTwo.fromJson(item)).toList();
        isLoading = false;
        print("URL ==> $iconsList");
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    LoginPage(),
    SignInPage(),
    HomePage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Menu Icon',
              onPressed: () {},
            ),
            title: TextField(
                textAlign: TextAlign.center,

                // controller: searchCtrl,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'images/img/icons8-shop-location-48.png',
                        height: 30,
                      ),
                    ),
                    suffixIcon: Icon(Icons.search),
                    hintText: "Search here",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)))),

            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications),
                tooltip: 'Comment Icon',
                onPressed: () {},
              ), //IconButton
              //IconButton
            ], //<Widget>[]
            backgroundColor: Colors.white,
            elevation: 50.0,
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(color: Colors.red),
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.red,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,color: Colors.grey,),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined,color: Colors.grey,),
                label: 'Search',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person,color: Colors.grey,),
                label: 'Profile',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CarouselSlider.builder(
                        itemCount: imageUrls.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              child: Image.network(
                                imageUrls[index],
                                fit: BoxFit.contain,
                                width: 1000.0,
                              ),
                            ),
                          );
                        },
                      ),
                Container(
                  height: 200,
                  width: 400,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color.fromARGB(255, 67, 54, 250),
                          Colors.blue
                        ]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'KYC Pending',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'You need to provide the required',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Document for your account verfication',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Click Here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final iconItem = iconsList[index];

                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20.0, // Horizontal spacing
                      runSpacing: 10.0, // Vertical spacing
                      children: iconsList.map((category) {
                        return CategoryItem(category: category);
                      }).toList(),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.topRight,
                        colors: <Color>[
                          Color.fromARGB(255, 67, 54, 250),
                          Colors.blue
                        ]),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EXCLUSIVE FOR YOU",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_right_alt_outlined,
                              size: 30,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          scrollDirection: Axis.horizontal,
                          //physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final iconItem = productDeti[index];

                            return Row(
                              children: [
                                Wrap(
                                  // direction: Axis.horizontal,
                                  alignment: WrapAlignment.center,
                                  spacing: 10.0, // Horizontal spacing
                                  runSpacing: 10.0, // Vertical spacing
                                  children: productDeti.map((category) {
                                    return ProductCard(category: category);
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ) //Center
          ), //Scaffold
      debugShowCheckedModeBanner: false, //Removing Debug Banner
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final IconItem category;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(category.iconUrl),
        Text(category.label),
      ],
    );
  }
}

class IconItem {
  final String label;
  final String iconUrl;

  IconItem({required this.label, required this.iconUrl});

  factory IconItem.fromJson(Map<String, dynamic> json) {
    return IconItem(
      label: json['label'],
      iconUrl: json['icon'],
    );
  }
}
