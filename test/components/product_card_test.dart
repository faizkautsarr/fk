import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fk/models/product.dart';
import 'package:fk/stores/liked_products.dart';
import 'package:fk/components/product_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('ProductCard widget displays correctly',
      (WidgetTester tester) async {
    await mockNetworkImagesFor(() async {
      return await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (context) => LikedProductsBloc(),
            child: ProductCard(
              product: Product(
                id: 1,
                title: 'Test Product',
                price: 19.99,
                description: 'desc',
                category: 'category',
                image: 'https://example.com/image.jpg',
                rating: 4.5,
                ratingCount: 100,
              ),
            ),
          ),
        ),
      );
    });

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('USD 19.99'), findsOneWidget);
    expect(find.text('4.5'), findsOneWidget);
    expect(find.text('100 reviews'), findsOneWidget);

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    // liked product
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
