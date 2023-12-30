import 'package:fk/pages/cart.dart';
import 'package:fk/stores/liked_products.dart';
import 'package:fk/stores/carts.dart';
import 'package:flutter/material.dart';
import 'package:fk/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
  });

  final Product product;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        return BlocBuilder<LikedProductsBloc, LikedProductsState>(
          builder: (context, likedProductState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.0,
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
                          if (cartState.items.isNotEmpty)
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Image.network(
                      widget.product.image,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "USD ${widget.product.price.toString()}",
                          style: const TextStyle(
                              color: Color(0xFF0ECF82),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        GestureDetector(
                          child: Icon(
                            likedProductState.likedProducts
                                    .contains(widget.product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: likedProductState.likedProducts
                                    .contains(widget.product.id)
                                ? Colors.red
                                : const Color(0xFF0ECF82),
                            size: 24,
                          ),
                          onTap: () {
                            if (likedProductState.likedProducts
                                .contains(widget.product.id)) {
                              context.read<LikedProductsBloc>().add(
                                  RemoveLikedProductEvent(widget.product.id));
                            } else {
                              context
                                  .read<LikedProductsBloc>()
                                  .add(AddLikedProductEvent(widget.product.id));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.product.rating.toString(),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.product.ratingCount.toString()} reviews",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.product.description,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<CartBloc>()
                              .add(AddToCartEvent(widget.product));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CartPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          backgroundColor: const Color(0xFF0ECF82),
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
