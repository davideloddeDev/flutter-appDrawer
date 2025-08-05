import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_app_drawer/custom_app_drawer.dart';

void main() {
  group('Custom App Drawer Tests', () {
    testWidgets('CustomAppDrawer should render with default config',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomAppDrawer(),
            body: const Center(child: Text('Test')),
          ),
        ),
      );

      // Verifica che il drawer non sia visibile inizialmente
      expect(find.byType(CustomAppDrawer), findsNothing);

      // Apri il drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verifica che il drawer sia visibile
      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Nome Utente'), findsOneWidget);
      expect(find.text('utente@email.com'), findsOneWidget);
    });

    testWidgets('CustomAppDrawer should render with custom config',
        (WidgetTester tester) async {
      const config = DrawerConfig(
        userName: 'Test User',
        userEmail: 'test@example.com',
        items: [
          DrawerItemConfig(
            icon: Icons.home,
            title: 'Home Test',
          ),
          DrawerItemConfig(
            icon: Icons.settings,
            title: 'Settings Test',
          ),
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomAppDrawer(config: config),
            body: const Center(child: Text('Test')),
          ),
        ),
      );

      // Apri il drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Verifica il contenuto personalizzato
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('Home Test'), findsOneWidget);
      expect(find.text('Settings Test'), findsOneWidget);
    });

    testWidgets('DrawerItem should handle tap correctly',
        (WidgetTester tester) async {
      bool tapped = false;

      final testConfig = DrawerItemConfig(
        icon: Icons.star,
        title: 'Test Item',
        onTap: () {
          tapped = true;
        },
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawerItem(config: testConfig),
          ),
        ),
      );

      // Trova e tocca l'elemento
      await tester.tap(find.text('Test Item'));
      await tester.pump();

      // Verifica che la callback sia stata chiamata
      expect(tapped, isTrue);
    });

    testWidgets('DrawerItem should render divider when isDivider is true',
        (WidgetTester tester) async {
      const config = DrawerItemConfig.divider();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DrawerItem(config: config),
          ),
        ),
      );

      // Verifica che il divider sia presente
      expect(find.byType(Divider), findsOneWidget);
    });

    test('DrawerConfig should have correct default values', () {
      const config = DrawerConfig();

      expect(config.userName, isNull);
      expect(config.userEmail, isNull);
      expect(config.userAvatarUrl, isNull);
      expect(config.customHeader, isNull);
      expect(config.items, isEmpty);
      expect(config.headerBackgroundColor, isNull);
      expect(config.headerGradient, isNull);
      expect(config.userNameStyle, isNull);
      expect(config.userEmailStyle, isNull);
    });

    test('DrawerItemConfig should have correct values', () {
      const config = DrawerItemConfig(
        icon: Icons.star,
        title: 'Test',
      );

      expect(config.icon, Icons.star);
      expect(config.title, 'Test');
      expect(config.onTap, isNull);
      expect(config.trailing, isNull);
      expect(config.isDivider, isFalse);
    });

    test('DrawerItemConfig.divider should create divider item', () {
      const config = DrawerItemConfig.divider();

      expect(config.isDivider, isTrue);
      expect(config.title, '');
      expect(config.onTap, isNull);
      expect(config.trailing, isNull);
    });
  });
}
