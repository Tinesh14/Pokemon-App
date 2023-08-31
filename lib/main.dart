import 'package:flutter/material.dart';
import 'package:poke_app/modules/home/ui/home_ui.dart';

import 'config/routes/routes.dart';
import 'config/themes/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      debugShowCheckedModeBanner: true,
      theme: appTheme,
      routes: PageRoutes().routes(),
      home: const HomeUi(),
    );
  }
}
