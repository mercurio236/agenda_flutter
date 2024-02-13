import 'package:agenda_flutter/ui/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
        appBarTheme:
            AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
            iconTheme: IconThemeData(color: Colors.white)
            )
            ,
  ));
}
