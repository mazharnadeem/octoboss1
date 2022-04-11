import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octbs_ui/screens/users/Octoboss/select_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectPage(),
    );
  }
}
