import 'package:dating_app/pages/theme/theme.dart';
import 'package:flutter/material.dart';

import 'pages/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Destiny',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MainPage(),
    );
  }
}
