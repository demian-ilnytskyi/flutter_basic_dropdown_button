# Basic DropDown Button

<p align="center">
  <a href="https://pub.dev/packages/basic_dropdown_button "><img src="https://img.shields.io/pub/v/basic_dropdown_button " alt="pub"></a>
  <a href="https://app.codecov.io/github/demian-ilnytskyi/flutter_basic_dropdown_button"><img src="https://img.shields.io/codecov/c/github/demian-ilnytskyi/flutter_basic_dropdown_button" alt="pub"></a>
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/actions/workflows/generate_code_coverate.yaml"><img src="https://img.shields.io/github/actions/workflow/status/demian-ilnytskyi/flutter_basic_dropdown_button/generate_code_coverate.yaml?event=push&branch=main&label=tests&logo=github" alt="tests"></a>
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/actions/workflows/ci.yaml">
    <img src="https://img.shields.io/github/actions/workflow/status/demian-ilnytskyi/flutter_basic_dropdown_button/ci.yaml?event=pull_request&label=Code%20Analysis%20%26%20Formatting&logo=github" 
        alt="Code Analysis & Formatting">
  </a>
</p>

A highly customizable drop-down button widget for Flutter. This package offers two variants—one streamlined for ease-of-use and one with full customization—so you can integrate a stylish, adaptive drop-down button into your app with minimal hassle or with extensive control over every detail.

---

## Preview

<p align="center">
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/blob/main/lib/custom_dropdown_button.dart">
   Preview
  </a>
</p>

<p align="center">
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/blob/main/assets/read_me/preview.png">
    <img src="https://raw.githubusercontent.com/demian-ilnytskyi/flutter_basic_dropdown_button/main/assets/read_me/preview.png" alt="preview">
  </a>
</p>

<p align="center">
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/blob/main/lib/basic_dropwon_button_widget.dart">
   Position Adaptive
  </a>
</p>

<p align="center">
  <a href="https://github.com/demian-ilnytskyi/flutter_basic_dropdown_button/blob/main/assets/read_me/adaptive_menu_position.gif">
    <img src="https://raw.githubusercontent.com/demian-ilnytskyi/flutter_basic_dropdown_button/main/assets/read_me/adaptive_menu_position.gif" alt="position adaptive">
  </a>
</p>

---

## Overview

**Custom DropDown Button** provides two distinct implementations:

1. **CustomDropDownButton**  
   A simplified version that exposes only the most essential parameters for quick integration and basic customization.

2. **BasicDropDownButton**  
   A more advanced version offering extensive customization options for both the button and its menu. This version is ideal if you need fine-grained control or want to build your own widget based on our implementation.

---

## Features

### 1. Two Versions for Flexibility

- **CustomDropDownButton**  
  - **Simplified API:** Designed for ease-of-use with most primary parameters preconfigured.
  - **Quick Integration:** Ideal when you want a functional drop-down without specifying many properties.

- **BasicDropDownButton**  
  - **Advanced Customization:** Offers a broader API with many parameters to tweak both the button and menu appearance and behavior.
  - **Custom Widget Development:** Serves as an example for developers who want to create their own highly customizable widgets.

### 2. Automatic Menu Positioning

- **Adaptive Layout:** The widget automatically changes the menu's position based on available screen space.
  - If there isn’t enough space below the button, the menu opens above.
  - Conversely, if space above is limited, it opens below.
- **Enhanced Usability:** This dynamic positioning ensures that the menu is always fully visible, regardless of screen size or orientation.

### 3. Full Customization of Style and Widgets

- **Button & Menu Styling:**  
  - You can change the style or even replace the widget for both the button and the menu.
  - Customize colors, shapes, padding, spacing, and more using Flutter's [ButtonStyle](https://api.flutter.dev/flutter/material/ButtonStyle-class.html) API and other styling parameters.

### 4. Simplified API with CustomDropDownButton

- **Minimal Configuration:**  
  - When using `CustomDropDownButton`, you don’t need to provide an extensive list of parameters—the majority of essential settings are already configured for you.
  - This makes it easier and faster to implement a drop-down button in your projects.

### 5. An Example for Custom Widget Development

- **Learning Resource:**  
  - `CustomDropDownButton` can serve as a practical example of how to build and customize your own widget.
  - You can study its structure and even extend it using the more flexible `BasicDropDownButton` as a foundation.

---

## Test Coverage and Flutter Version Support

This package has 100% test coverage, ensuring reliability and robustness. The tests have been executed on Flutter versions 3.16.0 and 3.29.0, confirming full support for these versions and all versions in between.

---

## Example

```dart
CustomDropDownButton<int>(
  buttonStyle: ButtonStyle(
    backgroundColor:
        WidgetStatePropertyAll(Colors.blue[600]),
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
  ),
  buttonText: 'Select Item',
  position: DropDownButtonPosition.bottomCenter,
  buttonIconColor: Colors.black,
  buttonTextStyle: TextStyle(
    color: Colors.white,
  ),
  menuItems: List.generate(
    itemCount,
    (index) => CustomDropDownButtonItem(
      value: index + 1,
      text: 'Item value is ${index + 1}',
      onPressed: () => event(index),
      buttonStyle: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          textStyle: WidgetStatePropertyAll(const TextStyle(
          color: Colors.black,
          )),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
            ),
          ),
      ),
      textStyle: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  menuBorderRadius: BorderRadius.circular(
    8,
  ),
  selectedValue: 1,
)
