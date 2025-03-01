import 'package:basic_dropdown_button/basic_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const buttonKey = Key('button_key');
  const menuKey = Key('menu_key');
  // Helper function to initialize the test environment
  Future<void> initTest({
    required WidgetTester tester,
    required Widget child,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              const SizedBox(
                height: 200,
              ),
              Center(child: child),
              const SizedBox(
                height: 200,
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
  }

  testWidgets('Custom DropDown Button Default Position(bottom center)',
      (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            buttonStyle: const ButtonStyle(),
            buttonText: 'test',
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx, buttonPosition.dx);

    expect(menuPosition.dy > buttonPosition.dy, isTrue);

    await tester.tap(find.byKey(const Key('item_key_0')));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    expect(value.value, 0);
  });

  testWidgets('Custom DropDown Button bottom left Position', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            position: DropDownButtonPosition.bottomLeft,
            buttonStyle: const ButtonStyle(),
            buttonText: 'test',
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
                icon: const Icon(Icons.abc),
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx > buttonPosition.dx, isTrue);

    expect(menuPosition.dy > buttonPosition.dy, isTrue);
  });

  testWidgets('Custom DropDown Button bottom right Position', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            position: DropDownButtonPosition.bottomRight,
            buttonStyle: const ButtonStyle(),
            buttonText: 'test',
            buttonIconFirst: false,
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx < buttonPosition.dx, isTrue);

    expect(menuPosition.dy > buttonPosition.dy, isTrue);
  });

  testWidgets('Custom DropDown Button top center Position', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            buttonStyle: const ButtonStyle(),
            position: DropDownButtonPosition.topCenter,
            buttonText: 'test',
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx, buttonPosition.dx);

    expect(menuPosition.dy < buttonPosition.dy, isTrue);
  });

  testWidgets('Custom DropDown Button top left Position', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            position: DropDownButtonPosition.topLeft,
            buttonStyle: const ButtonStyle(),
            buttonText: 'test',
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
                icon: const Icon(Icons.abc),
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx > buttonPosition.dx, isTrue);

    expect(menuPosition.dy < buttonPosition.dy, isTrue);
  });

  testWidgets('Custom DropDown Button top right Position', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return CustomDropDownButton<int>(
            key: buttonKey,
            menuKey: menuKey,
            position: DropDownButtonPosition.topRight,
            buttonStyle: const ButtonStyle(),
            buttonText: 'test',
            menuItems: List.generate(
              3,
              (index) => CustomDropDownButtonItem(
                key: Key('item_key_$index'),
                value: index + 1,
                text: 'Item value is ${index + 1}',
                onPressed: () => value.value = index,
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            selectedValue: selected,
          );
        },
      ),
    );

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsOneWidget);

    expect(find.byKey(const Key('item_key_0')), findsOneWidget);

    final menuPosition = tester.getCenter(find.byKey(menuKey));

    final buttonPosition = tester.getCenter(find.byKey(buttonKey));

    expect(menuPosition.dx < buttonPosition.dx, isTrue);

    expect(menuPosition.dy < buttonPosition.dy, isTrue);
  });
}
