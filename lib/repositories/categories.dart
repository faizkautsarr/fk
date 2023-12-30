import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesRepositories {
  Future<List<String>> getCategories() async {
    List<String> categories = [];
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));

    try {
      if (response.statusCode == 200) {
        categories = List<String>.from(json.decode(response.body));
      }
    } catch (e) {
      throw Exception('Failed to load categories');
    }
    return categories;
  }
}
