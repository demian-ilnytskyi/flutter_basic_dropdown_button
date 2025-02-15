import 'package:custom_drop_down_button/custom_drop_down_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Drop Down Button Preview',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
          spacing: 100,
          children: [
            Text(
              'Example With All Button Position State\n And With Different Button Style',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 60,
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
                DropDownWidget(
                  event: (index) => setState(() {
                    currentIndex = index + 1;
                  }),
                  position: DropDownButtonPosition.topCenter,
                  currentIndex: currentIndex,
                  buttonStyle: _buttonStyle2,
                  itemButtonStyle: _itemButtonStyle2,
                  text: 'Select Item',
                  buttonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 1,
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
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 60,
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
                  buttonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 5,
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
                  buttonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  iconColor: Colors.white,
                  itemTextColor: Colors.white,
                  itemCount: 6,
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
                  buttonTextStyle: TextStyle(
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

  ButtonStyle get _buttonStyle1 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.amber[700]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle1 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.amber),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      );

  ButtonStyle get _buttonStyle2 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue[600]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle2 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue[200]),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );

  ButtonStyle get _buttonStyle3 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.green[700]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle3 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.green[200]),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );

  ButtonStyle get _buttonStyle4 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.purple[700]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle4 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      );

  ButtonStyle get _buttonStyle5 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.teal[600]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle5 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.teal[200]),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );

  ButtonStyle get _buttonStyle6 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.red[700]),
        padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      );

  ButtonStyle get _itemButtonStyle6 => ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.red[200]),
        textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
        )),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.event,
    required this.currentIndex,
    required this.buttonStyle,
    required this.itemButtonStyle,
    required this.position,
    required this.text,
    required this.itemTextColor,
    this.buttonTextStyle,
    this.iconColor,
    required this.itemCount,
  });
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
      buttonIconColor: iconColor,
      buttonTextStyle: buttonTextStyle,
      menuItems: List.generate(
        itemCount,
        (index) => CustomDropDownButtonItem(
          value: index + 1,
          text: 'Item value is ${index + 1}',
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
    );
  }
}
