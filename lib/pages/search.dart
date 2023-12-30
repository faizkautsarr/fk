import 'package:fk/components/product_card.dart';
import 'package:fk/pages/cart.dart';
import 'package:flutter/material.dart';
import 'package:fk/models/product.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.products,
  });

  final List<Product> products;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      filteredProducts = widget.products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "SEARCH",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 24,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Row(
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
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextField(
                onChanged: (value) {
                  setState(
                    () {
                      if (value == "") {
                        filteredProducts = filteredProducts;
                      } else {
                        filteredProducts = widget.products
                            .where(
                              (element) => element.title.toLowerCase().contains(
                                    searchController.text.toLowerCase(),
                                  ),
                            )
                            .toList();
                      }
                    },
                  );
                },
                controller: searchController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'Find your favorite product here...',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                        filteredProducts = widget.products;
                      });
                    },
                  ),
                ),
              ),
            ),
            if (widget.products.isNotEmpty)
              if (filteredProducts.isEmpty && searchController.text != "")
                const Text(
                  "Sorry, product not found \n please use another keyword.",
                  textAlign: TextAlign.center,
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
