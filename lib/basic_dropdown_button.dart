import 'package:flutter/material.dart';

/// A customizable drop-down button widget that displays a menu with configurable styling,
/// positioning, and behavior.
///
/// This widget is intended for use in a Flutter package. It provides a flexible API to customize
/// both the button and its drop-down menu.
class CustomDropDownButton<T> extends StatelessWidget {
  /// Creates a [CustomDropDownButton].
  ///
  /// The [buttonStyle], [buttonText], and [menuItems] parameters are required.
  const CustomDropDownButton({
    Key? key,
    required this.buttonStyle,
    required this.buttonText,
    required this.menuItems,
    this.menuVerticalSpacing = 8,
    this.menuBackgroundColor = Colors.grey,
    this.showIndicatorIcon = true,
    this.position = DropDownButtonPosition.bottomCenter,
    this.iconAlignment = IconAlignment.start,
    this.menuPadding,
    this.buttonCloseMenuIcon,
    this.buttonOpenMenuIcon,
    this.menuBorderRadius,
    this.buttonTextStyle,
    this.customButton,
    this.itemSpacing = 8,
    this.selectedValue,
    this.buttonIconColor,
  }) : super(key: key);

  /// List of menu items to be displayed in the drop-down.
  final List<CustomDropDownButtonItem<T>> menuItems;

  /// Border radius for the drop-down menu.
  final BorderRadius? menuBorderRadius;

  /// Preferred position for the drop-down menu relative to the button.
  final DropDownButtonPosition position;

  /// Button style for the main drop-down button.
  final ButtonStyle buttonStyle;

  /// Text displayed on the main button.
  final String buttonText;

  /// Text style for the main button.
  final TextStyle? buttonTextStyle;

  /// Vertical spacing between the main button and the drop-down menu.
  final double menuVerticalSpacing;

  /// Alignment for the icon within the main button.
  final IconAlignment iconAlignment;

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

  /// A custom builder for the main button. If provided, it overrides [buttonText].
  final Widget Function(VoidCallback?)? customButton;

  /// Spacing between individual menu items.
  final double itemSpacing;

  /// The currently selected value.
  final T? selectedValue;

  /// Color for the icon displayed on the main button.
  final Color? buttonIconColor;

  @override
  Widget build(BuildContext context) {
    return BasicDropDownButton(
      buttonStyle: buttonStyle,
      buttonText: buttonText,
      // Map each [CustomDropDownButtonItem] to a [TextButton] widget.
      menuItems: (hideMenu) => List.generate(menuItems.length, (index) {
        final item = menuItems.elementAt(index);
        final isSelected = selectedValue != null && selectedValue == item.value;
        return TextButton(
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
                  spacing: item.iconSpacing,
                  children: [
                    item.icon!,
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
      }),
      menuVerticalSpacing: menuVerticalSpacing,
      menuBackgroundColor: menuBackgroundColor,
      showIndicatorIcon: showIndicatorIcon,
      position: position,
      iconAlignment: iconAlignment,
      menuItemsPadding: menuPadding,
      key: key,
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
      itemSpacing: itemSpacing,
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
}

/// A basic implementation of a drop-down button that handles internal state
/// and displays the overlay menu.
///
/// This widget is used internally by [CustomDropDownButton].
class BasicDropDownButton extends StatefulWidget {
  /// Creates a [BasicDropDownButton].
  ///
  /// Either [buttonText] or [buttonChild] must be provided, and either [menuItems]
  /// or [menuList] must be provided.
  const BasicDropDownButton({
    Key? key,
    required this.buttonStyle,
    required this.buttonText,
    required this.menuItems,
    required this.menuVerticalSpacing,
    required this.menuBackgroundColor,
    required this.showIndicatorIcon,
    required this.position,
    required this.buttonCloseMenuIcon,
    required this.buttonOpenMenuIcon,
    this.itemSpacing = 8,
    this.buttonIconColor = Colors.black,
    this.iconAlignment = IconAlignment.start,
    this.menuItemsSpacing = 0,
    this.menuClipBehavior = Clip.hardEdge,
    this.menuItemsPadding,
    this.buttonChild,
    this.menuBorderRadius,
    this.buttonTextStyle,
    this.customButton,
    this.menuList,
  })  : assert(
          !(buttonChild == null && buttonText == null),
          'Either provide a [buttonText] or a custom [buttonChild].',
        ),
        assert(
          !(menuItems == null && menuList == null),
          'Either provide [menuItems] or a custom [menuList].',
        ),
        super(key: key);

  /// Custom widget for the button. If provided, overrides [buttonText].
  final Widget? buttonChild;

  /// Builder function to generate the list of menu item widgets.
  final List<Widget> Function(VoidCallback hideMenu)? menuItems;

  /// Border radius for the drop-down menu.
  final BorderRadius? menuBorderRadius;

  /// Position of the drop-down menu relative to the button.
  final DropDownButtonPosition position;

  /// Button style for the main button.
  final ButtonStyle buttonStyle;

  /// Text displayed on the main button.
  final String? buttonText;

  /// Text style for the main button.
  final TextStyle? buttonTextStyle;

  /// Vertical spacing between the main button and the drop-down menu.
  final double menuVerticalSpacing;

  /// Alignment for the icon within the main button.
  final IconAlignment iconAlignment;

  /// Icon to display when the menu is open.
  final Widget buttonCloseMenuIcon;

  /// Icon to display when the menu is closed.
  final Widget buttonOpenMenuIcon;

  /// Determines whether to show the indicator icon on the main button.
  final bool showIndicatorIcon;

  /// Padding for the menu items inside the drop-down.
  final EdgeInsets? menuItemsPadding;

  /// Background color of the drop-down menu.
  final Color menuBackgroundColor;

  /// Custom builder for the main button.
  final Widget Function(VoidCallback?)? customButton;

  /// Spacing between individual menu items in the drop-down.
  final double itemSpacing;

  /// Custom widget for the entire menu list. If provided, overrides [menuItems].
  final Widget? menuList;

  /// Color for the icon displayed on the main button.
  final Color buttonIconColor;

  /// Spacing between menu items.
  final double menuItemsSpacing;

  /// Clipping behavior for the drop-down menu.
  final Clip menuClipBehavior;

  @override
  BasicDropDownButtonState createState() => BasicDropDownButtonState();
}

class BasicDropDownButtonState<T> extends State<BasicDropDownButton> {
  late bool _showMenu;
  late OverlayPortalController _controller;
  late LayerLink _optionsLayerLink;
  late double? menuHeight;
  late GlobalKey _menuKey;
  late GlobalKey _anchorKey;

  @override
  void initState() {
    super.initState();
    _controller = OverlayPortalController();
    _optionsLayerLink = LayerLink();

    _showMenu = false;
    menuHeight = null;

    _menuKey = GlobalKey();
    _anchorKey = GlobalKey();
  }

  /// Toggles the visibility of the drop-down menu.
  void showHideButtonMenu() {
    _controller.toggle();
    setState(() {
      _showMenu = !_showMenu;
    });
  }

  /// Sets the height of the drop-down menu after it has been rendered.
  void setMenuHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _menuKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject()! as RenderBox;
        if (box.hasSize) {
          setState(() {
            menuHeight = box.size.height;
          });
        }
      }
    });
  }

  /// Returns the height of the anchor button.
  double get getHeight {
    final context = _anchorKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.height : 0;
    }
    return 0;
  }

  /// Determines the position of the drop-down menu based on available screen space.
  DropDownButtonPosition get _positionCalculate {
    final renderObject = context.findRenderObject();

    bool? hasBottomSpace;
    bool? hasTopSpace;

    if (menuHeight != null && renderObject != null) {
      final renderBox = renderObject as RenderBox;
      final screenHeight = MediaQuery.sizeOf(context).height;
      final buttonPosition = renderBox.localToGlobal(Offset.zero);
      final availableHeight = screenHeight - (buttonPosition.dy + getHeight);
      hasBottomSpace = availableHeight > menuHeight!;
      hasTopSpace = buttonPosition.dy > menuHeight!;
    }

    return widget.position.positionCalculate(
      hasBottomPlace: hasBottomSpace,
      hasTopPlace: hasTopSpace,
    );
  }

  /// Builds the drop-down menu widget.
  Widget _getMenuWidget(BuildContext context) {
    final positionValue = _positionCalculate;
    if (menuHeight == null) setMenuHeight();
    final items = widget.menuItems?.call(showHideButtonMenu);
    return CompositedTransformFollower(
      link: _optionsLayerLink,
      showWhenUnlinked: false,
      targetAnchor: positionValue.getMenuPosition,
      followerAnchor: positionValue.getContentPosition,
      child: Align(
        alignment: positionValue.getContentPosition,
        child: Padding(
          padding: EdgeInsets.only(
            top: widget.menuVerticalSpacing,
            bottom: widget.menuVerticalSpacing,
          ),
          child: TapRegion(
            onTapOutside: (event) => showHideButtonMenu(),
            child: widget.menuList ??
                Container(
                  key: _menuKey,
                  decoration: BoxDecoration(
                    color: widget.menuBackgroundColor,
                    borderRadius: widget.menuBorderRadius,
                  ),
                  clipBehavior: widget.menuClipBehavior,
                  child: Padding(
                    padding: widget.menuItemsPadding ?? EdgeInsets.zero,
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: widget.menuItemsSpacing,
                        children: List.generate(
                          items!.length,
                          (index) => items.elementAt(index),
                        ),
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: OverlayPortal.targetsRootOverlay(
        controller: _controller,
        overlayChildBuilder: _getMenuWidget,
        child: CompositedTransformTarget(
          link: _optionsLayerLink,
          child: widget.customButton
                  ?.call(_showMenu ? null : showHideButtonMenu) ??
              _defaultButton,
        ),
      ),
    );
  }

  /// Default button widget if no custom button is provided.
  Widget get _defaultButton => TextButton.icon(
        key: _anchorKey,
        onPressed: _showMenu ? null : showHideButtonMenu,
        style: _showMenu
            ? widget.buttonStyle.copyWith(
                mouseCursor: const WidgetStatePropertyAll(
                  SystemMouseCursors.click,
                ),
                iconColor: WidgetStatePropertyAll(
                  widget.buttonIconColor,
                ),
              )
            : widget.buttonStyle,
        icon: widget.showIndicatorIcon
            ? _showMenu
                ? widget.buttonCloseMenuIcon
                : widget.buttonOpenMenuIcon
            : null,
        iconAlignment: widget.iconAlignment,
        label: widget.buttonChild ??
            Text(
              widget.buttonText!,
              style: widget.buttonTextStyle ??
                  const TextStyle(color: Colors.black),
            ),
      );
}

/// Enum representing the possible positions of the drop-down menu relative to the button.
enum DropDownButtonPosition {
  bottomCenter,
  bottomRight,
  bottomLeft,
  topCenter,
  topRight,
  topLeft,
}

/// Extension on [DropDownButtonPosition] to calculate effective positioning and alignment.
extension _DropDownButtonPositionExtension on DropDownButtonPosition {
  /// Determines the effective position of the drop-down menu based on available space.
  DropDownButtonPosition positionCalculate({
    required bool? hasBottomPlace,
    required bool? hasTopPlace,
  }) {
    if (hasBottomPlace == null || hasTopPlace == null) return this;
    switch (this) {
      case DropDownButtonPosition.bottomCenter:
        return hasBottomPlace ? this : DropDownButtonPosition.topCenter;
      case DropDownButtonPosition.bottomLeft:
        return hasBottomPlace ? this : DropDownButtonPosition.topLeft;
      case DropDownButtonPosition.bottomRight:
        return hasBottomPlace ? this : DropDownButtonPosition.topRight;
      case DropDownButtonPosition.topCenter:
        return hasTopPlace ? this : DropDownButtonPosition.bottomCenter;
      case DropDownButtonPosition.topLeft:
        return hasTopPlace ? this : DropDownButtonPosition.bottomLeft;
      case DropDownButtonPosition.topRight:
        return hasTopPlace ? this : DropDownButtonPosition.bottomRight;
    }
  }

  /// Returns the alignment for the drop-down content based on the current position.
  Alignment get getContentPosition {
    switch (this) {
      case DropDownButtonPosition.bottomCenter:
        return Alignment.topCenter;
      case DropDownButtonPosition.bottomLeft:
        return Alignment.topLeft;
      case DropDownButtonPosition.bottomRight:
        return Alignment.topRight;
      case DropDownButtonPosition.topCenter:
        return Alignment.bottomCenter;
      case DropDownButtonPosition.topLeft:
        return Alignment.bottomLeft;
      case DropDownButtonPosition.topRight:
        return Alignment.bottomRight;
    }
  }

  /// Returns the alignment for the drop-down menu relative to the button.
  Alignment get getMenuPosition {
    switch (this) {
      case DropDownButtonPosition.bottomCenter:
        return Alignment.bottomCenter;
      case DropDownButtonPosition.bottomLeft:
        return Alignment.bottomLeft;
      case DropDownButtonPosition.bottomRight:
        return Alignment.bottomRight;
      case DropDownButtonPosition.topCenter:
        return Alignment.topCenter;
      case DropDownButtonPosition.topLeft:
        return Alignment.topLeft;
      case DropDownButtonPosition.topRight:
        return Alignment.topRight;
    }
  }
}
