import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fk/components/category_item.dart';

void main() {
  testWidgets('CategoryItem widget displays correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CategoryItem(
            isCurrentCategories: true,
            category: 'Test Category',
          ),
        ),
      ),
    );

    expect(find.text('Test Category'), findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.style?.color == Colors.white &&
            widget.data == 'Test Category',
      ),
      findsOneWidget,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CategoryItem(
            isCurrentCategories: false,
            category: 'Test Category',
          ),
        ),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Text &&
            widget.style?.color == Colors.grey &&
            widget.data == 'Test Category',
      ),
      findsOneWidget,
    );
  });
}
