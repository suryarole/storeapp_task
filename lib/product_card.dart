import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final IconItemTwo category;

  const ProductCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            // Product Image
            Stack(
              children: [
                Container(
                  height: 200,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        category.prodimg, // Replace with product image URL
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      category.prodoffer,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    
            // Product Details
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    category.prodname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
    
                  SizedBox(height: 10),
                  // Price and Buy Button
                  ElevatedButton(
                    onPressed: () {
                      // Action for buy button
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconItemTwo {
  final String prodimg;
  final String prodoffer;
  final String prodname;

  IconItemTwo(
      {required this.prodimg, required this.prodoffer, required this.prodname});

  factory IconItemTwo.fromJson(Map<String, dynamic> json) {
    return IconItemTwo(
        prodimg: json['icon'],
        prodname: json['label'],
        prodoffer: json['offer']);
  }
}
