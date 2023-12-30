import 'package:fk/stores/carts.dart';
import 'package:fk/stores/liked_products.dart';
import 'package:flutter/material.dart';
import 'package:fk/pages/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // singleton, bloc init
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LikedProductsBloc>(
          create: (context) => LikedProductsBloc(),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
    );
  }
}
