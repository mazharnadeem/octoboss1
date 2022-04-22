// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/screens/users/Octoboss/select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.kToDark
      ),
      debugShowCheckedModeBanner: false,
      home: SelectPage(),
    );
  }
}
class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xFF000000, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0x000000), //10%
      100: const Color(0xffb74c3a), //20%
      200: const Color(0xffa04332), //30%
      300: const Color(0xff89392b), //40%
      400: const Color(0xff733024), //50%
      500: const Color(0xff5c261d), //60%
      600: const Color(0xff451c16), //70%
      700: const Color(0xff2e130e), //80%
      800: const Color(0x000000), //90%
      900: const Color(0x000000), //100%
    },
  );
}