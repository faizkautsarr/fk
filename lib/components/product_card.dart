import 'package:fk/pages/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:fk/models/product.dart';
import 'package:fk/stores/liked_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.from = 'search',
  }) : super(key: key);

  final Product product;
  final String from;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikedProductsBloc, LikedProductsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  product: product,
                ),
              ),
            );
          },
          child: from == 'search'
              ? Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Image.network(
                            product.image,
                            width: 80,
                            filterQuality: FilterQuality.high,
                            gaplessPlayback: true,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 50,
                                child: Text(
                                  product.title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "USD ${product.price.toString()}",
                                style: const TextStyle(
                                    color: Color(0xFF0ECF82),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    product.rating.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${product.ratingCount.toString()} reviews",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Icon(
                            state.likedProducts.contains(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: state.likedProducts.contains(product.id)
                                ? Colors.red
                                : const Color(0xFF0ECF82),
                            size: 24,
                          ),
                          onTap: () {
                            if (state.likedProducts.contains(product.id)) {
                              context
                                  .read<LikedProductsBloc>()
                                  .add(RemoveLikedProductEvent(product.id));
                            } else {
                              context
                                  .read<LikedProductsBloc>()
                                  .add(AddLikedProductEvent(product.id));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  height: 270,
                  width: MediaQuery.of(context).size.width / 2 - 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Icon(
                            state.likedProducts.contains(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: state.likedProducts.contains(product.id)
                                ? Colors.red
                                : const Color(0xFF0ECF82),
                            size: 20,
                          ),
                          onTap: () {
                            if (state.likedProducts.contains(product.id)) {
                              context
                                  .read<LikedProductsBloc>()
                                  .add(RemoveLikedProductEvent(product.id));
                            } else {
                              context
                                  .read<LikedProductsBloc>()
                                  .add(AddLikedProductEvent(product.id));
                            }
                          },
                        ),
                      ),
                      Center(
                        child: Image.network(
                          product.image,
                          height: 100,
                          filterQuality: FilterQuality.high,
                          gaplessPlayback: true,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          product.title,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "USD ${product.price.toString()}",
                        style: const TextStyle(
                            color: Color(0xFF0ECF82),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${product.ratingCount.toString()} reviews",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                                fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
