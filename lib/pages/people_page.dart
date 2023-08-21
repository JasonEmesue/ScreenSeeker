import 'package:flutter/material.dart';
import 'package:screenseeker/people.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Popular People',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: size.width,
              height: 720,
              child: const Column(
                children: [
                  PeopleWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
