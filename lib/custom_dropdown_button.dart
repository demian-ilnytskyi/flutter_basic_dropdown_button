import 'package:basic_dropdown_button/basic_dropdown_button.dart';
import 'package:flutter/material.dart';

/// A customizable drop-down button widget that displays a menu with
/// configurable styling,
/// positioning, and behavior.
///
/// This widget is intended for use in a Flutter package. It provides a
/// flexible API to customize
/// both the button and its drop-down menu.
class CustomDropDownButton<T> extends StatelessWidget {
  /// Creates a [CustomDropDownButton].
  ///
  /// The [buttonStyle], [buttonText], and [menuItems] parameters are required.
  const CustomDropDownButton({
    required this.buttonStyle,
    required this.buttonText,
    required this.menuItems,
    Key? key,
    this.menuVerticalSpacing = 8,
    this.menuBackgroundColor = Colors.grey,
    this.showIndicatorIcon = true,
    this.position = DropDownButtonPosition.bottomCenter,
    this.buttonIconFirst = true,
    this.menuPadding,
    this.buttonCloseMenuIcon,
    this.buttonOpenMenuIcon,
    this.menuBorderRadius,
    this.buttonTextStyle,
    this.customButton,
    this.selectedValue,
    this.buttonIconColor,
    this.menuKey,
    this.menuItemsSpacing = 0,
    this.buttonIconSpace = 0,
    this.buttonChild,
  })  : assert(
          !(buttonText == null && customButton == null && buttonChild == null),
          'Either provide a [buttonText] or a custom [customButton] or a custom [buttonChild].',
        ),
        super(key: key);

  /// List of menu items to be displayed in the drop-down.
  final List<CustomDropDownButtonItem<T>> menuItems;

  /// Border radius for the drop-down menu.
  final BorderRadius? menuBorderRadius;

  /// Preferred position for the drop-down menu relative to the button.
  final DropDownButtonPosition position;

  /// Button style for the main drop-down button.
  final ButtonStyle buttonStyle;

  /// Text displayed on the main button.
  final String? buttonText;

  /// Text style for the main button.
  final TextStyle? buttonTextStyle;

  /// Vertical spacing between the main button and the drop-down menu.
  final double menuVerticalSpacing;

  /// Alignment for the icon within the main button.
  final bool buttonIconFirst;

  /// Icon displayed when the menu is open.
  final Widget? buttonCloseMenuIcon;

  /// Icon displayed when the menu is closed.
  final Widget? buttonOpenMenuIcon;

  /// Determines whether to show the indicator icon on the main button.
  final bool showIndicatorIcon;

  /// Padding for the menu items inside the drop-down.
  final EdgeInsets? menuPadding;

  /// Background color of the drop-down menu.
  final Color menuBackgroundColor;

  /// A custom builder for the main button. If provided, it overrides
  /// [buttonText].
  final Widget Function(VoidCallback?)? customButton;

  /// The currently selected value.
  final T? selectedValue;

  /// Color for the icon displayed on the main button.
  final Color? buttonIconColor;

  final Key? menuKey;

  /// Spacing between menu items.
  final double menuItemsSpacing;

  final double buttonIconSpace;

  final Widget? buttonChild;

  @override
  Widget build(BuildContext context) {
    return BasicDropDownButton(
      buttonStyle: buttonStyle,
      buttonText: buttonText,
      // Map each [CustomDropDownButtonItem] to a [TextButton] widget.
      menuItems: (hideMenu) => List.generate(menuItems.length, (index) {
        final item = menuItems.elementAt(index);
        final isSelected = selectedValue != null && selectedValue == item.value;
        final button = TextButton(
          key: item.key,
          style: item.buttonStyle,
          onPressed: item.onPressed == null || isSelected
              ? null
              : () {
                  item.onPressed!();
                  hideMenu();
                },
          child: item.icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    item.icon!,
                    SizedBox(
                      width: item.iconSpacing,
                    ),
                    Flexible(
                      child: Text(
                        item.text,
                        textAlign: item.textAlign,
                        style: item.textStyle,
                      ),
                    ),
                  ],
                )
              : Text(
                  item.text,
                  textAlign: item.textAlign,
                  style: item.textStyle,
                ),
        );
        if (item.margin != null) {
          return Padding(
            padding: item.margin!,
            child: button,
          );
        } else {
          return button;
        }
      }),
      menuVerticalSpacing: menuVerticalSpacing,
      menuBackgroundColor: menuBackgroundColor,
      showIndicatorIcon: showIndicatorIcon,
      buttonIconSpace: buttonIconSpace,
      position: position,
      buttonIconFirst: buttonIconFirst,
      menuPadding: menuPadding,
      buttonCloseMenuIcon: buttonCloseMenuIcon ??
          Icon(
            Icons.arrow_drop_up,
            color: buttonIconColor,
          ),
      buttonOpenMenuIcon: buttonOpenMenuIcon ??
          Icon(
            Icons.arrow_drop_down,
            color: buttonIconColor,
          ),
      menuBorderRadius: menuBorderRadius,
      buttonTextStyle: buttonTextStyle,
      customButton: customButton,
      menuKey: menuKey,
      menuItemsSpacing: menuItemsSpacing,
      buttonChild: buttonChild,
    );
  }
}

/// Represents an item in the [CustomDropDownButton] menu.
class CustomDropDownButtonItem<T> {
  /// Creates a [CustomDropDownButtonItem] with the provided properties.
  ///
  /// The [text], [onPressed], and [value] parameters are required.
  CustomDropDownButtonItem({
    required this.text,
    required this.onPressed,
    required this.value,
    this.key,
    this.iconSpacing = 8,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.icon,
    this.textStyle,
    this.buttonStyle,
    this.margin,
  });

  /// Text displayed for this menu item.
  final String text;

  /// Callback event when the menu item is selected.
  final VoidCallback? onPressed;

  /// Unique key for the menu item.
  final Key? key;

  /// Determines if the menu item is enabled.
  final bool enabled;

  /// The value associated with this menu item.
  final T value;

  /// Optional icon displayed alongside the text.
  final Widget? icon;

  /// Padding (spacing) for the icon.
  final double iconSpacing;

  /// Text style for the menu item.
  final TextStyle? textStyle;

  /// Alignment of the text in the menu item.
  final TextAlign textAlign;

  /// Button style for the menu item.
  final ButtonStyle? buttonStyle;

  final EdgeInsets? margin;
}
