import 'package:flutter/material.dart';

/// A basic implementation of a drop-down button that handles internal state
/// and displays the overlay menu.
class BasicDropDownButton extends StatefulWidget {
  /// Creates a [BasicDropDownButton].
  ///
  /// Either [buttonText] or [buttonChild] must be provided, and either
  /// [menuItems]
  /// or [menuList] must be provided.
  const BasicDropDownButton({
    required this.buttonStyle,
    required this.buttonText,
    required this.menuItems,
    required this.menuVerticalSpacing,
    required this.menuBackgroundColor,
    required this.buttonIcon,
    required this.position,
    this.buttonIconSpace = 0,
    Key? key,
    this.buttonIconColor = Colors.black,
    this.buttonIconFirst = true,
    this.menuItemsSpacing = 0,
    this.menuClipBehavior = Clip.hardEdge,
    this.menuPadding,
    this.buttonChild,
    this.menuBorderRadius,
    this.buttonTextStyle,
    this.customButton,
    this.menuList,
    this.menuKey,
  })  : assert(
          !(buttonChild == null && buttonText == null && customButton == null),
          'Either provide a [buttonText] or a custom [customButton] or a '
          'custom [buttonChild].',
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
  final ButtonStyle? buttonStyle;

  /// Text displayed on the main button.
  final String? buttonText;

  /// Text style for the main button.
  final TextStyle? buttonTextStyle;

  /// Vertical spacing between the main button and the drop-down menu.
  final double menuVerticalSpacing;

  /// Determines whether to show the indicator icon on the main button.
  final Widget Function({required bool showedMenu})? buttonIcon;

  /// Padding for the menu items inside the drop-down.
  final EdgeInsets? menuPadding;

  /// Background color of the drop-down menu.
  final Color? menuBackgroundColor;

  /// Custom builder for the main button.
  final Widget Function({
    required VoidCallback? showHideMenuEvent,
    required bool showMenu,
  })? customButton;

  /// Custom widget for the entire menu list. If provided, overrides
  /// [menuItems].
  final Widget Function(double buttonWidth)? menuList;

  /// Color for the icon displayed on the main button.
  final Color buttonIconColor;

  /// Spacing between menu items.
  final double menuItemsSpacing;

  /// Clipping behavior for the drop-down menu.
  final Clip menuClipBehavior;

  final Key? menuKey;

  /// Alignment for the icon within the main button.
  final bool buttonIconFirst;

  final double buttonIconSpace;

  @override
  State<BasicDropDownButton> createState() => _BasicDropDownButtonState();
}

class _BasicDropDownButtonState extends State<BasicDropDownButton> {
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

    _menuKey = GlobalKey(debugLabel: 'menu_key');
    _anchorKey = GlobalKey(debugLabel: 'button_key');
  }

  /// Toggles the visibility of the drop-down menu.
  void showHideMenu() {
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

  /// Returns the height of the anchor button.
  double get getWidth {
    final context = _anchorKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject()! as RenderBox;
      return box.hasSize ? box.size.width : 0;
    }
    return 0;
  }

  /// Determines the position of the drop-down menu based on available
  /// screen space.
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
    final items = widget.menuItems?.call(showHideMenu);
    final menu = CompositedTransformFollower(
      link: _optionsLayerLink,
      showWhenUnlinked: false,
      targetAnchor: positionValue.getMenuPosition,
      followerAnchor: positionValue.getContentPosition,
      child: Align(
        alignment: positionValue.getContentPosition,
        child: Padding(
          key: widget.menuKey,
          padding: EdgeInsets.only(
            top: widget.menuVerticalSpacing,
            bottom: widget.menuVerticalSpacing,
          ),
          child: TapRegion(
            key: _menuKey,
            onTapOutside: (event) => showHideMenu(),
            child: widget.menuList?.call(getWidth) ??
                Container(
                  decoration: BoxDecoration(
                    color: widget.menuBackgroundColor,
                    borderRadius: widget.menuBorderRadius,
                  ),
                  clipBehavior: widget.menuClipBehavior,
                  child: Padding(
                    padding: widget.menuPadding ?? EdgeInsets.zero,
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: widget.menuItemsSpacing > 0
                            ? List.generate(
                                items!.length * 2 - 1,
                                (index) {
                                  if (index.isOdd) {
                                    return SizedBox(
                                      height: widget.menuItemsSpacing,
                                    );
                                  } else {
                                    return items.elementAt(index ~/ 2);
                                  }
                                },
                              )
                            : List.generate(
                                items!.length,
                                items.elementAt,
                              ),
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
    if (menuHeight == null) {
      return Opacity(opacity: 0, child: menu);
    } else {
      return menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: OverlayPortal.targetsRootOverlay(
        controller: _controller,
        overlayChildBuilder: _getMenuWidget,
        child: CompositedTransformTarget(
          key: _anchorKey,
          link: _optionsLayerLink,
          child: widget.customButton?.call(
                showHideMenuEvent: _showMenu ? null : showHideMenu,
                showMenu: _showMenu,
              ) ??
              _defaultButton,
        ),
      ),
    );
  }

  /// Default button widget if no custom button is provided.
  Widget get _defaultButton {
    final icon = widget.buttonIcon?.call(showedMenu: _showMenu);
    final textWidget = widget.buttonChild ??
        Text(
          widget.buttonText!,
          style: widget.buttonTextStyle ?? const TextStyle(color: Colors.black),
        );
    final Widget child;
    if (icon == null) {
      child = textWidget;
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.buttonIconFirst
            ? [
                icon,
                SizedBox(width: widget.buttonIconSpace),
                Flexible(child: textWidget),
              ]
            : [
                Flexible(child: textWidget),
                SizedBox(width: widget.buttonIconSpace),
                icon,
              ],
      );
    }
    return TextButton(
      onPressed: _showMenu ? null : showHideMenu,
      style: _showMenu
          ? widget.buttonStyle?.merge(
              TextButton.styleFrom(
                disabledMouseCursor: SystemMouseCursors.click,
                iconColor: widget.buttonIconColor,
              ),
            )
          : widget.buttonStyle,
      child: child,
    );
  }
}

/// Enum representing the possible positions of the drop-down menu relative
/// to the button.
enum DropDownButtonPosition {
  bottomCenter,
  bottomRight,
  bottomLeft,
  topCenter,
  topRight,
  topLeft,
}

/// Extension on [DropDownButtonPosition] to calculate effective positioning
/// and alignment.
extension _DropDownButtonPositionExtension on DropDownButtonPosition {
  /// Determines the effective position of the drop-down menu based on
  /// available space.
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

  /// Returns the alignment for the drop-down content based on the
  /// current position.
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
