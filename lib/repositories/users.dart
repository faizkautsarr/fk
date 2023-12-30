import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fk/models/user.dart';

class UsersRepositories {
  Future<User> userLogin({
    required String username,
    required String password,
  }) async {
    User currentUser =
        User(id: 0, username: "", email: "", token: "", fullName: "");

    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/auth/login'),
        body: jsonEncode(
          {"username": username, "password": password},
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];

        final userResponse =
            await http.get(Uri.parse("https://fakestoreapi.com/users"));

        if (userResponse.statusCode == 200) {
          var userTemp = List.from(jsonDecode(userResponse.body))
              .where((user) => user["username"] == username)
              .first;

          currentUser = User(
            id: userTemp["id"],
            username: userTemp["username"],
            email: userTemp["email"],
            token: token,
            fullName: userTemp["name"]["firstname"] +
                " " +
                userTemp["name"]["lastname"],
          );
        }
      }
    } catch (e) {
      throw Exception('Failed to login');
    }
    return currentUser;
  }
}
