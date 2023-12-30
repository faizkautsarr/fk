import 'package:fk/components/category_item.dart';
import 'package:fk/components/product_card.dart';
import 'package:fk/components/shimmer.dart';
import 'package:fk/pages/cart.dart';
import 'package:fk/pages/search.dart';
import 'package:fk/repositories/categories.dart';
import 'package:fk/repositories/products.dart';
import 'package:flutter/material.dart';
import 'package:fk/models/product.dart';
import 'package:fk/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fk/stores/carts.dart';
import 'package:fk/tools/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> filteredProducts = [];
  List<Product> products = [];
  List<String> categories = [];
  String currentCategories = "All";
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _initFunction();
  }

  _initFunction() async {
    setState(() {
      currentCategories = "All";
      isLoading = true;
    });
    await Future.wait(
      [
        _getProducts(),
        _getCategories(),
      ],
    );
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getProducts() async {
    List<Product> productsTemp = await ProductsRepositories().getProducts();
    if (productsTemp.isNotEmpty) {
      setState(() {
        products = productsTemp;
        filteredProducts = productsTemp;
      });
    }
  }

  Future<void> _getCategories() async {
    List<String> categoriesTemp =
        await CategoriesRepositories().getCategories();
    if (categoriesTemp.isNotEmpty) {
      setState(() {
        categoriesTemp.insert(0, "All");
        categories = categoriesTemp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              centerTitle: true,
              title: const Text(
                "TUTUPLAPAK.COM",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  showSnackBar(context, "success",
                      "Hi ${widget.user.email},\nwelcome to tutuplapak.com,\nhappy shopping and have a nice day!!");
                },
              ),
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (products.isNotEmpty) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SearchPage(
                                products: products,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 24,
                        ),
                      ), // First icon on the right
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const CartPage(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        if (state.items.isNotEmpty)
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Hi, ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, // Set text color
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                widget.user.fullName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // Set text color
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const Text(
                            'What are you looking for today?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          _initFunction();
                        },
                        child: const Icon(
                          Icons.replay,
                          color: Colors.black,
                          size: 24,
                        ), // First icon on the right
                      ),
                    ],
                  ),
                ),
                isLoading
                    ? const ShimmerComponent()
                    : Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 18),
                          child: Column(
                            children: [
                              if (categories.isNotEmpty)
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          scrollController.animateTo(
                                            0.0,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                          setState(() {
                                            currentCategories = categories[i];
                                            if (currentCategories != "All") {
                                              filteredProducts = products
                                                  .where((element) =>
                                                      element.category ==
                                                      currentCategories)
                                                  .toList();
                                            } else {
                                              filteredProducts = products;
                                            }
                                          });
                                        },
                                        child: CategoryItem(
                                            isCurrentCategories:
                                                currentCategories ==
                                                    categories[i],
                                            category: categories[i]),
                                      );
                                    },
                                  ),
                                ),
                              if (filteredProducts.isNotEmpty)
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ListView.builder(
                                      controller: scrollController,
                                      itemCount:
                                          (filteredProducts.length / 2).ceil(),
                                      itemBuilder: (context, rowIndex) {
                                        int startIndex = rowIndex * 2;
                                        int endIndex = (rowIndex + 1) * 2;
                                        endIndex =
                                            endIndex > filteredProducts.length
                                                ? filteredProducts.length
                                                : endIndex;

                                        List<Product> rowProducts =
                                            filteredProducts.sublist(
                                                startIndex, endIndex);

                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: rowProducts.map(
                                            (product) {
                                              return ProductCard(
                                                product: product,
                                                from: "home",
                                              );
                                            },
                                          ).toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
