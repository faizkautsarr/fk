import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fk/models/product.dart';

class ProductsRepositories {
  Future<List<Product>> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);

      List<Product> products = [];

      for (var json in jsonList) {
        Product temp = Product(
            id: json['id'],
            title: json['title'],
            price: json['price'].toDouble(),
            description: json['description'],
            category: json['category'],
            image: json['image'],
            rating: json['rating']['rate'].toDouble(),
            ratingCount: json['rating']['count']);

        products.add(temp);
      }
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
