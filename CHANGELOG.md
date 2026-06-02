## 1.3.0

- Added horizontal auto-correction bounds to prevent dropdown menus from overflowing the left or right edges of the screen.
- Added `menuHorizontalPadding` parameter to configure the screen boundary safety padding (defaults to `8.0`).
- Added `menuOffset` parameter (`Offset`) to allow manual adjustment of the dropdown menu's location from its default position.
- Added real-world use cases and demo section in the example application for manual offset and boundary shifting.
- Re-verified 100% code coverage across the package with new widget tests.
- Fixed all Flutter analysis warnings and formatting.

## 1.0.0

Release Version

## 1.0.0+1

Small Package ReadMe Rename

## 1.1.0

Added tests and fix flutter support version

## 1.1.0+1

Added buttonIconSpace as parameter

## 1.1.0+2

Fixed Assert

## 1.1.0+3

Added margin for CustomDropDownButtonItem

## 1.1.0+4

Fixed menuItemsSpacing. Now not add spacing for last item

## 1.1.1

Icon now one parameter and custom menu list has button width

## 1.1.1+1

Menu list add hide function

## 1.1.2+1

Change screen height base on keyboard size

## 1.1.3

Fix: Change screen height base on keyboard size

## 1.1.4

Fix: Double tap on outside not reaopen drop down menu

## 1.1.5

Fix: Tapping the button when the menu is open now allows for actions without the
menu closing automatically.

## 1.2.0

- Added `AppDropDownTextField` widget which combines a `TextField` with a
  dropdown menu.
- Added support for custom `onTapOutside` callbacks.
- Improved focus management for text-based dropdowns.

## 1.2.1

- Added `itemText` parameter to `AppDropDownTextField`.
- Added selectItem from dropdown to textField

## 1.2.2

- Improved automated test coverage to 100%.
- Added comprehensive widget testing for the `didUpdateWidget` lifecycle in `AppDropDownTextField`.
