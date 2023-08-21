import 'package:flutter/material.dart';
import 'package:screenseeker/pages/navigation_bar_widget.dart';

void main() {
  runApp(const ScreenSeeker());
}

class ScreenSeeker extends StatelessWidget {
  const ScreenSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey,
        ),
        home: const NavigationBarWidget());
  }
}
