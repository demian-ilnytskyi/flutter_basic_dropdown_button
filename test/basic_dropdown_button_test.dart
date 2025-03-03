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
          return BasicDropDownButton(
            key: buttonKey,
            menuKey: menuKey,
            buttonStyle: const ButtonStyle(),
            buttonText: null,
            customButton: ({required showHideMenuEvent, required showMenu}) =>
                TextButton(
              onPressed: showHideMenuEvent,
              child: const Text('test'),
            ),
            menuItems: (hideMenu) => List.generate(
              3,
              (index) => TextButton(
                key: Key('item_key_$index'),
                child: Text('Item value is ${index + 1}'),
                onPressed: () {
                  hideMenu();
                  value.value = index;
                },
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            menuVerticalSpacing: 8,
            menuBackgroundColor: Colors.grey,
            position: DropDownButtonPosition.topCenter,
            buttonIcon: null,
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

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    expect(value.value, null);
  });

  testWidgets('Custom DropDown Button with custom List', (tester) async {
    final value = ValueNotifier<int?>(null);
    await initTest(
      tester: tester,
      child: ValueListenableBuilder<int?>(
        valueListenable: value,
        builder: (BuildContext context, int? selected, child) {
          return BasicDropDownButton(
            key: buttonKey,
            menuKey: menuKey,
            menuItems: null,
            buttonStyle: const ButtonStyle(),
            buttonText: null,
            customButton: ({required showHideMenuEvent, required showMenu}) =>
                TextButton(
              onPressed: showHideMenuEvent,
              child: const Text('test'),
            ),
            menuList: ({required buttonWidth, required hideMenu}) =>
                ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 100),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => SizedBox(
                  key: Key('item_key_$index'),
                  width: buttonWidth,
                  child: Text('Test_$index'),
                ),
              ),
            ),
            menuBorderRadius: BorderRadius.circular(
              8,
            ),
            menuVerticalSpacing: 8,
            menuBackgroundColor: Colors.grey,
            position: DropDownButtonPosition.topCenter,
            buttonIcon: null,
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

    await tester.tap(find.byKey(buttonKey));

    await tester.pumpAndSettle();

    expect(find.byKey(buttonKey), findsOneWidget);

    expect(find.byKey(menuKey), findsNothing);

    expect(find.byKey(const Key('item_key_0')), findsNothing);

    expect(value.value, null);
  });
}
