import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:machineroundshi/detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pagination Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<dynamic> _products = [];
  int _currentPage = 0;
  final int _limit = 10;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (_isFetching) return;

    setState(() {
      _isFetching = true;
    });

    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products?limit=$_limit&skip=${_currentPage * _limit}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _products.addAll(data['products']);
        _currentPage++;
        _isFetching = false;
      });
    } else {
      _isFetching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!_isFetching &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchProducts();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(
                  _products[index]['thumbnail'],
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                ),
                title: Text(_products[index]['title']),
                subtitle: Text(_products[index]['description']),
                trailing: Text(
                  '\$${_products[index]['price']}',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: _products[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
