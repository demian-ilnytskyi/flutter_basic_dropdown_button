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
            customButton: ({
              required showHideMenuEvent,
              required showMenu,
              String? groupId,
            }) =>
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
            customButton: ({
              required showHideMenuEvent,
              required showMenu,
              String? groupId,
            }) =>
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

  testWidgets('Keyboard size update and other branches coverage',
      (tester) async {
    await initTest(
      tester: tester,
      child: BasicDropDownButton(
        buttonStyle: const ButtonStyle(),
        buttonText: 'Test',
        menuItems: (hideMenu) => [
          const Text('Item 1'),
          const Text('Item 2'),
        ],
        menuVerticalSpacing: 10,
        menuBackgroundColor: Colors.white,
        buttonIcon: ({required showedMenu}) =>
            const Icon(Icons.arrow_drop_down),
        buttonIconFirst: false,
        buttonIconSpace: 5,
        menuItemsSpacing: 5,
        menuPadding: const EdgeInsets.all(8),
        position: DropDownButtonPosition.bottomCenter,
      ),
    );

    // Initial state
    expect(find.text('Test'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);

    // Simulate keyboard appearance (more than 10 pixels difference)
    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    tester.binding.handleMetricsChanged();
    await tester.pump();

    // Opening menu to trigger _positionCalculate with keyboard size
    await tester.tap(find.text('Test'));
    await tester.pumpAndSettle();

    expect(find.text('Item 1'), findsOneWidget);

    // Simulate keyboard disappearance (bottomInset = 0)
    tester.view.viewInsets = FakeViewPadding.zero;
    tester.binding.handleMetricsChanged();
    await tester.pumpAndSettle();

    // To hit line 131: keyboardDifferentSize < 10 and bottomInset != 0
    // Current _keyboardSize is 0. Set to 5.
    tester.view.viewInsets = const FakeViewPadding(bottom: 5);
    tester.binding.handleMetricsChanged();
    await tester.pump();

    // Close menu
    await tester.tap(find.text('Test')); // Tap button to close (or tap outside)
    await tester.pumpAndSettle();

    // Reset view insets
    tester.view.resetViewInsets();
  });

  testWidgets('BasicDropDownButton listener and onMenuChanged coverage',
      (tester) async {
    var onMenuChangedCalled = false;
    var listenerCalled = false;

    await initTest(
      tester: tester,
      child: BasicDropDownButton(
        buttonStyle: const ButtonStyle(),
        buttonText: 'Test',
        menuItems: (hideMenu) => [const Text('Item 1')],
        menuVerticalSpacing: 0,
        menuBackgroundColor: Colors.white,
        buttonIcon: null,
        position: DropDownButtonPosition.bottomCenter,
        onMenuChanged: ({required showMenu}) {
          onMenuChangedCalled = true;
        },
        listener: (getParams) {
          listenerCalled = true;
          final params = getParams();
          expect(params.showMenu, isFalse);
          params.showHideMenuEvent(); // Toggle menu
        },
      ),
    );

    expect(listenerCalled, isTrue);
    await tester.pumpAndSettle();

    expect(onMenuChangedCalled, isTrue);
    expect(find.text('Item 1'), findsOneWidget);
  });

  testWidgets('BasicDropDownButton horizontal bounds shifting test',
      (tester) async {
    const customPadding = 12.0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Positioned(
                right: 2,
                top: 100,
                child: BasicDropDownButton(
                  key: const Key('dropdown_right'),
                  menuKey: const Key('menu_right'),
                  menuHorizontalPadding: customPadding,
                  buttonStyle: const ButtonStyle(),
                  buttonText: 'Right Button',
                  position: DropDownButtonPosition.bottomLeft,
                  menuItems: (hideMenu) => [
                    const SizedBox(
                      width: 200,
                      child: Text('Menu Item Right'),
                    ),
                  ],
                  buttonIcon: null,
                  menuVerticalSpacing: 8,
                  menuBackgroundColor: Colors.grey,
                ),
              ),
              Positioned(
                left: 2,
                top: 300,
                child: BasicDropDownButton(
                  key: const Key('dropdown_left'),
                  menuKey: const Key('menu_left'),
                  menuHorizontalPadding: customPadding,
                  buttonStyle: const ButtonStyle(),
                  buttonText: 'Left Button',
                  position: DropDownButtonPosition.bottomRight,
                  menuItems: (hideMenu) => [
                    const SizedBox(
                      width: 200,
                      child: Text('Menu Item Left'),
                    ),
                  ],
                  buttonIcon: null,
                  menuVerticalSpacing: 8,
                  menuBackgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Open right dropdown
    await tester.tap(find.byKey(const Key('dropdown_right')));
    await tester.pumpAndSettle();

    final menuRightRect = tester.getRect(find.byKey(const Key('menu_right')));
    expect(menuRightRect.right, 800.0 - customPadding);

    // Close right dropdown
    await tester.tap(find.byKey(const Key('dropdown_right')));
    await tester.pumpAndSettle();

    // Open left dropdown
    await tester.tap(find.byKey(const Key('dropdown_left')));
    await tester.pumpAndSettle();

    final menuLeftRect = tester.getRect(find.byKey(const Key('menu_left')));
    expect(menuLeftRect.left, customPadding);
  });

  testWidgets('BasicDropDownButton menuOffset parameter test', (tester) async {
    const customOffset = Offset(15, 25);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: BasicDropDownButton(
              key: const Key('dropdown_offset'),
              menuKey: const Key('menu_offset'),
              menuOffset: customOffset,
              buttonStyle: const ButtonStyle(),
              buttonText: 'Offset Button',
              position: DropDownButtonPosition.bottomCenter,
              menuItems: (hideMenu) => [
                const SizedBox(
                  width: 100,
                  height: 50,
                  child: Text('Menu Item Offset'),
                ),
              ],
              buttonIcon: null,
              menuVerticalSpacing: 0,
              menuBackgroundColor: Colors.grey,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Open dropdown
    await tester.tap(find.byKey(const Key('dropdown_offset')));
    await tester.pumpAndSettle();

    final buttonRect = tester.getRect(find.byKey(const Key('dropdown_offset')));
    final menuRect = tester.getRect(find.byKey(const Key('menu_offset')));

    expect(
      menuRect.left,
      buttonRect.center.dx - menuRect.width / 2 + customOffset.dx,
    );
    expect(menuRect.top, buttonRect.bottom + customOffset.dy);
  });
}
