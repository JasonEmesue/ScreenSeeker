import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenseeker/material_button_widget.dart';
import 'package:screenseeker/pages/movies_page.dart';
import 'package:screenseeker/pages/people_page.dart';
import 'package:screenseeker/pages/tv_shows_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 11.0),
          child: Image.asset(
            'assets/images/SSlogo3.png',
            width: 30.0,
            height: 20.0,
          ),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            //Movie Button
            MaterialButtonWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const MoviesPage()),
                );
              },
              icon: Icons.movie_creation_outlined,
              title: 'Movies',
            ),

            //TV Button
            MaterialButtonWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const TVShowsPage()),
                );
              },
              icon: Icons.tv,
              title: 'TV Shows',
            ),

            //People Button
            MaterialButtonWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => const PeoplePage()),
                );
              },
              icon: Icons.people_outline_rounded,
              title: 'People',
            ),

            //Trending Button
            MaterialButtonWidget(
              onPressed: () {},
              icon: Icons.trending_up,
              title: 'Trending',
            ),
          ],
        ),
      ),
    );
  }
}
