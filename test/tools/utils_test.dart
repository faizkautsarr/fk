import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fk/tools/utils.dart';

void main() {
  testWidgets('showSnackBar displays correct snackbar success',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showSnackBar(context, "success", "success message");
                },
                child: const Text('Press me success'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press me success'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('success message'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(
      (tester.widget(find.byType(SnackBar)) as SnackBar).backgroundColor,
      Colors.black,
    );
  });

  testWidgets('showSnackBar displays correct snackbar error',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showSnackBar(context, "error", "error message");
                },
                child: const Text('Press me error'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Press me error'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('error message'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(
      (tester.widget(find.byType(SnackBar)) as SnackBar).backgroundColor,
      Colors.red,
    );
  });
}
