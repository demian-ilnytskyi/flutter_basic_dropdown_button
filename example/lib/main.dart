import 'package:basic_dropdown_button/basic_dropdown_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Custom Drop Down Button Preview',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int? currentIndex;
  @override
  void initState() {
    currentIndex = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Example With All Button Position State\n And With'
              ' Different Button Style',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.topLeft,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle1,
                  itemButtonStyle: _itemButtonStyle1,
                  text: 'Example ${currentIndex ?? ''}',
                  itemTextColor: Colors.black,
                  itemCount: 2,
                ),
                const SizedBox(
                  width: 60,
                ),
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.topCenter,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle2,
                  itemButtonStyle: _itemButtonStyle2,
                  text: 'Select Item',
                  buttonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 1,
                ),
                const SizedBox(
                  width: 60,
                ),
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.topRight,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle3,
                  itemButtonStyle: _itemButtonStyle3,
                  text: 'Text',
                  itemTextColor: Colors.black,
                  itemCount: 3,
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.bottomLeft,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle4,
                  itemButtonStyle: _itemButtonStyle4,
                  text: 'Selected Item ${currentIndex ?? ''}',
                  buttonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 5,
                ),
                const SizedBox(
                  width: 60,
                ),
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.bottomCenter,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle5,
                  itemButtonStyle: _itemButtonStyle5,
                  text: 'Select Item',
                  buttonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 6,
                ),
                const SizedBox(
                  width: 60,
                ),
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.bottomRight,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle6,
                  itemButtonStyle: _itemButtonStyle6,
                  text: 'Text',
                  buttonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle get _buttonStyle1 => TextButton.styleFrom(
        backgroundColor: Colors.amber[700],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  ButtonStyle get _itemButtonStyle1 => TextButton.styleFrom(
        backgroundColor: Colors.amber,
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
          // ignore: avoid_redundant_argument_values
          borderRadius: BorderRadius.zero,
        ),
      );

  ButtonStyle get _buttonStyle2 => TextButton.styleFrom(
        backgroundColor: Colors.blue[600],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  ButtonStyle get _itemButtonStyle2 => TextButton.styleFrom(
        backgroundColor: Colors.blue[200],
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );

  ButtonStyle get _buttonStyle3 => TextButton.styleFrom(
        backgroundColor: Colors.green[700],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  ButtonStyle get _itemButtonStyle3 => TextButton.styleFrom(
        backgroundColor: Colors.green[200],
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );

  ButtonStyle get _buttonStyle4 => TextButton.styleFrom(
        backgroundColor: Colors.purple[700],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );

  ButtonStyle get _itemButtonStyle4 => TextButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: const RoundedRectangleBorder(
          // ignore: avoid_redundant_argument_values
          borderRadius: BorderRadius.zero,
        ),
      );

  ButtonStyle get _buttonStyle5 => TextButton.styleFrom(
        backgroundColor: Colors.teal[600],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  ButtonStyle get _itemButtonStyle5 => TextButton.styleFrom(
        backgroundColor: Colors.teal[200],
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );

  ButtonStyle get _buttonStyle6 => TextButton.styleFrom(
        backgroundColor: Colors.red[700],
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  ButtonStyle get _itemButtonStyle6 => TextButton.styleFrom(
        backgroundColor: Colors.red,
        textStyle: const TextStyle(
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      );
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key? key,
    required this.event,
    required this.currentIndex,
    required this.buttonStyle,
    required this.itemButtonStyle,
    required this.position,
    required this.text,
    required this.itemTextColor,
    required this.itemCount,
    this.buttonTextStyle,
    this.iconColor,
  }) : super(key: key);
  final void Function(int) event;
  final int? currentIndex;

  final ButtonStyle buttonStyle;
  final ButtonStyle itemButtonStyle;
  final DropDownButtonPosition position;
  final String text;
  final TextStyle? buttonTextStyle;
  final Color? iconColor;
  final Color itemTextColor;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownButton<int>(
      buttonStyle: buttonStyle,
      buttonText: text,
      position: position,
      buttonTextStyle: buttonTextStyle,
      menuItems: List.generate(
        itemCount,
        (index) => CustomDropDownButtonItem(
          value: index + 1,
          text: index > 2 ? 'test' : 'Item value is ${index + 1}',
          onPressed: () => event(index),
          buttonStyle: itemButtonStyle,
          textStyle: TextStyle(
            color: itemTextColor,
          ),
        ),
      ),
      menuBorderRadius: BorderRadius.circular(
        8,
      ),
      selectedValue: currentIndex,
      buttonIcon: ({required showedMenu}) => showedMenu
          ? Icon(
              Icons.arrow_drop_down,
              color: iconColor,
            )
          : Icon(
              Icons.arrow_drop_up,
              color: iconColor,
            ),
    );
  }
}
