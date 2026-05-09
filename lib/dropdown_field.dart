import 'dart:ui' as ui;

import 'package:basic_dropdown_button/basic_dropwon_button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A drop-down field that combines a [TextField] with a [BasicDropDownButton].
///
/// This widget supports all standard [TextField] parameters and passes through
/// menu-related parameters to the underlying [BasicDropDownButton].
class AppDropDownTextField<T> extends StatefulWidget {
  const AppDropDownTextField({
    Key? key,
    // TextField parameters
    this.controller,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.cursorWidth = 2,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20),
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.canRequestFocus = true,
    this.contentInsertionConfiguration,
    this.cursorOpacityAnimates,

    // BasicDropDownButton parameters
    this.menuItems,
    this.menuVerticalSpacing = 0,
    this.menuBackgroundColor,
    this.position = DropDownButtonPosition.bottomCenter,
    this.menuItemsSpacing = 0,
    this.menuClipBehavior = Clip.hardEdge,
    this.menuPadding,
    this.menuBorderRadius,
    this.menuList,
    this.menuKey,
    this.initValue,
    this.customField,
    this.onMenuChanged,
    this.suffixIcon,
  }) : super(key: key);

  // TextField fields
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? Function({required bool showMenu})? decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool readOnly;
  final bool? showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool? enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final GestureTapCallback? onTap;
  final void Function({required bool showMenu})? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollController? scrollController;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final Clip clipBehavior;
  final String? restorationId;
  final bool enableIMEPersonalizedLearning;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final UndoHistoryController? undoController;
  final bool canRequestFocus;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final bool? cursorOpacityAnimates;
  // BasicDropDownButton fields
  final List<Widget> Function(VoidCallback hideMenu)? menuItems;
  final double menuVerticalSpacing;
  final Color? menuBackgroundColor;
  final DropDownButtonPosition position;
  final double menuItemsSpacing;
  final Clip menuClipBehavior;
  final EdgeInsets? menuPadding;
  final BorderRadius? menuBorderRadius;
  final Widget Function({
    required double buttonWidth,
    required VoidCallback hideMenu,
  })? menuList;
  final Key? menuKey;
  final String? Function()? initValue;

  final Widget Function({
    required VoidCallback showHideMenuEvent,
    required bool showMenu,
    required String groupId,
    required FocusNode focusNode,
    required TextEditingController controller,
    required Widget Function(BuildContext, EditableTextState)?
        contextMenuBuilder,
    required void Function({required bool showMenu})? onTapOutside,
  })? customField;

  final void Function({required bool showMenu})? onMenuChanged;
  final Widget Function({required bool showMenu})? suffixIcon;

  @override
  State<AppDropDownTextField<T>> createState() =>
      _AppDropDownTextFieldState<T>();
}

class _AppDropDownTextFieldState<T> extends State<AppDropDownTextField<T>> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.text = widget.initValue?.call() ?? '';
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _focusListener(ListenerParams Function() paramsResult) {
    final params = paramsResult();
    if (_focusNode.hasFocus && !params.showMenu) {
      params.showHideMenuEvent();
    } else if (!_focusNode.hasFocus && params.showMenu) {
      params.showHideMenuEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicDropDownButton(
      menuItems: widget.menuItems,
      menuVerticalSpacing: widget.menuVerticalSpacing,
      menuBackgroundColor: widget.menuBackgroundColor,
      position: widget.position,
      menuItemsSpacing: widget.menuItemsSpacing,
      menuClipBehavior: widget.menuClipBehavior,
      menuPadding: widget.menuPadding,
      menuBorderRadius: widget.menuBorderRadius,
      menuList: widget.menuList,
      menuKey: widget.menuKey,
      // Required but not used when customButton is provided
      buttonStyle: null,
      buttonText: null,
      buttonIcon: null,
      onMenuChanged: widget.onMenuChanged ??
          ({required showMenu}) {
            if (!showMenu && _focusNode.hasFocus) {
              _focusNode.unfocus();
            }
          },
      listener: (getParams) =>
          _focusNode.addListener(() => _focusListener(getParams)),
      onTapOutside: _onTapOutside,
      customButton: ({
        required showHideMenuEvent,
        required showMenu,
        required groupId,
      }) =>
          widget.customField != null
              ? widget.customField!.call(
                  showHideMenuEvent: showHideMenuEvent,
                  showMenu: showMenu,
                  groupId: groupId,
                  focusNode: _focusNode,
                  controller: _controller,
                  contextMenuBuilder: _contextMenuBuilder(groupId),
                  onTapOutside: _onTapOutside,
                )
              : TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: widget.decoration?.call(showMenu: showMenu) ??
                      InputDecoration(
                        suffixIcon: widget.suffixIcon
                                ?.call(showMenu: showMenu) ??
                            AnimatedRotation(
                              turns: (showMenu && !widget.readOnly) ? 0.5 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                              ),
                            ),
                      ),
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  textCapitalization: widget.textCapitalization,
                  style: widget.style,
                  strutStyle: widget.strutStyle,
                  textAlign: widget.textAlign,
                  textAlignVertical: widget.textAlignVertical,
                  textDirection: widget.textDirection,
                  readOnly: widget.readOnly,
                  showCursor: widget.showCursor,
                  autofocus: widget.autofocus,
                  obscuringCharacter: widget.obscuringCharacter,
                  obscureText: widget.obscureText,
                  autocorrect: widget.autocorrect,
                  smartDashesType: widget.smartDashesType,
                  smartQuotesType: widget.smartQuotesType,
                  enableSuggestions: widget.enableSuggestions,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  expands: widget.expands,
                  maxLength: widget.maxLength,
                  maxLengthEnforcement: widget.maxLengthEnforcement,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  onSubmitted: widget.onSubmitted,
                  onAppPrivateCommand: widget.onAppPrivateCommand,
                  inputFormatters: widget.inputFormatters,
                  enabled: widget.enabled,
                  cursorWidth: widget.cursorWidth,
                  cursorHeight: widget.cursorHeight,
                  cursorRadius: widget.cursorRadius,
                  cursorColor: widget.cursorColor,
                  selectionHeightStyle: widget.selectionHeightStyle,
                  selectionWidthStyle: widget.selectionWidthStyle,
                  keyboardAppearance: widget.keyboardAppearance,
                  scrollPadding: widget.scrollPadding,
                  dragStartBehavior: widget.dragStartBehavior,
                  enableInteractiveSelection: widget.enableInteractiveSelection,
                  selectionControls: widget.selectionControls,
                  onTap: widget.onTap,
                  mouseCursor: widget.mouseCursor,
                  buildCounter: widget.buildCounter,
                  contextMenuBuilder: _contextMenuBuilder(groupId),
                  scrollController: widget.scrollController,
                  scrollPhysics: widget.scrollPhysics,
                  autofillHints: widget.autofillHints,
                  clipBehavior: widget.clipBehavior,
                  restorationId: widget.restorationId,
                  enableIMEPersonalizedLearning:
                      widget.enableIMEPersonalizedLearning,
                  spellCheckConfiguration: widget.spellCheckConfiguration,
                  magnifierConfiguration: widget.magnifierConfiguration,
                  undoController: widget.undoController,
                  canRequestFocus: widget.canRequestFocus,
                  contentInsertionConfiguration:
                      widget.contentInsertionConfiguration,
                  cursorOpacityAnimates: widget.cursorOpacityAnimates,
                ),
    );
  }

  void _onTapOutside({required bool showMenu}) {
    if (widget.onTapOutside != null) {
      widget.onTapOutside!(showMenu: showMenu);
    } else {
      if (_focusNode.hasFocus) _focusNode.unfocus();
    }
  }

  Widget Function(BuildContext, EditableTextState)? _contextMenuBuilder(
    String groupId,
  ) {
    return (context, editableTextState) {
      // if (defaultTargetPlatform == TargetPlatform.iOS &&
      //     SystemContextMenu.isSupported(context)) {
      //   return TapRegion(
      //     groupId: groupId,
      //     child: SystemContextMenu.editableText(
      //       editableTextState: editableTextState,
      //     ),
      //   );
      // }
      return TapRegion(
        groupId: groupId,
        child: AdaptiveTextSelectionToolbar.editableText(
          editableTextState: editableTextState,
        ),
      );
    };
  }
}
