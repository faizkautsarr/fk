import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fk/components/shimmer.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  testWidgets('ShimmerComponent should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ShimmerComponent()),
    ));

    expect(find.byType(ShimmerComponent), findsOneWidget);

    expect(find.byType(Shimmer), findsNWidgets(3));
  });
}
