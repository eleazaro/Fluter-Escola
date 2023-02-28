import 'package:flutter/material.dart';
import 'package:flutter_escola/home/home_module.dart';
import 'package:flutter_escola/home/presentation/view/home_page.dart';
import 'package:flutter_escola/shared/fixed_string.dart';
import 'package:flutter_escola/shared/widgets/chart.dart';
import 'package:flutter_escola/shared/widgets/my_appbar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

void main() {
  group('HomePage', () {
    setUp(() {
      initModule(HomeModule());
    });

    Widget loadTester() {
      return MaterialApp(
        home: Scaffold(
          body: HomePage(
            title: FixedString.appTitle,
          ),
        ),
      );
    }

    testWidgets('return screen success with widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(loadTester());

      expect(find.text(FixedString.appTitle), findsOneWidget);
      expect(find.byType(MyAppBar), findsOneWidget);
      expect(find.byType(Chart), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
    });

    testWidgets('return drawer when tap icon', (WidgetTester tester) async {
      await tester.pumpWidget(loadTester());

      expect(find.text(FixedString.menuCourse), findsNothing);
      expect(find.text(FixedString.menuStudent), findsNothing);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text(FixedString.menuCourse), findsOneWidget);
      expect(find.text(FixedString.menuStudent), findsOneWidget);
    });

    testWidgets('golden test', (WidgetTester tester) async {
      await tester.pumpWidget(loadTester());

      await expectLater(
          find.byType(HomePage), matchesGoldenFile('home_page.png'));
    });
  });
}
