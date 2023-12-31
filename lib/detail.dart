import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    bool isInStock = product['stock'] > 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         
            CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: false,
              ),
              items: product['images'].map<Widget>((imageUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            // Product details section
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Brand: ${product['brand']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Category: ${product['category']}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Rating: ${product['rating'].toString()} / 5',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Price: \$${product['price']}',
                    style: TextStyle(fontSize: 18.0, color: Colors.redAccent),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'In Stock: ${isInStock ? "Yes" : "No"}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: isInStock ? Colors.green : Colors.red),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product['description'],
                    style: TextStyle(fontSize: 16.0),
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
