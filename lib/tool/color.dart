//ダークモードに使う文字色と背景色を定義しています。

import 'package:flutter/material.dart';

Color setBackgroundColor(context) {
  bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }

  if (isDarkMode(context)) {
    return const Color.fromARGB(255, 28, 28, 29);
  } else {
    return const Color.fromARGB(255, 255, 255, 255);
  }
}

Color setPraimryBackgroundColor(context) {
  bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }

  if (isDarkMode(context)) {
    return const Color.fromARGB(255, 44, 44, 45);
  } else {
    return const Color.fromARGB(255, 244, 244, 248);
  }
}

Color setTextColor(context) {
  bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }

  if (isDarkMode(context)) {
    return const Color.fromARGB(255, 240, 240, 240);
  } else {
    return const Color.fromARGB(255, 37, 37, 37);
  }
}

Color setPraimryTextColor(context) {
  bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }

  if (isDarkMode(context)) {
    return const Color.fromARGB(255, 172, 175, 178);
  } else {
    return const Color.fromARGB(255, 164, 164, 165);
  }
}
