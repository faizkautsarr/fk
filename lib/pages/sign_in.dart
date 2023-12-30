import 'package:fk/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:fk/repositories/users.dart';
import 'package:fk/models/user.dart';
import 'package:fk/tools/utils.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = false;
  bool isLoading = false;
  late User currentUser;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // default user login from https://fakestoreapi.com/docs
    // you can use another user that listed on that api
    usernameController.text = "johnd";
    passwordController.text = "m38rmF\$";
  }

  Future<void> _login() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      User userTemp = await UsersRepositories().userLogin(
          username: usernameController.text, password: passwordController.text);

      if (userTemp.id != 0) {
        setState(() {
          currentUser = userTemp;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomePage(
              user: currentUser,
            ),
          ),
        );
        showSnackBar(context, "success", "Yayy, login successful");
      } else {
        showSnackBar(context, "error",
            "Failed to login, please check your credentials carefully");
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Lottie.asset('assets/store.json', width: 100),
            ),
            // Tagline

            const Text(
              'TUTUPLAPAK.COM',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set text color
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                floatingLabelStyle: TextStyle(color: Color(0xFF0ECF82)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF0ECF82)), // Set the focused border color
                ),
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                floatingLabelStyle: const TextStyle(color: Color(0xFF0ECF82)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xFF0ECF82)), // Set the focused border color
                ),
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  color: const Color(0xFFb4b4b4),
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showSnackBar(context, "success", "Coming soon...");
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Color(0xFFB4B4B4)),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(40.0),
                backgroundColor: const Color(0xFF0ECF82), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Border radius
                ),
              ),
              onPressed: () {
                _login();
              },
              child: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                showSnackBar(context, "success", "Coming soon...");
              },
              child: const Text(
                "Don't have an account? Sign up here",
                style: TextStyle(color: Color(0xFFB4B4B4)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
