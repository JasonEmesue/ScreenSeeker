import 'package:flutter/material.dart';
import 'package:screenseeker/pages/home.dart';
import 'package:screenseeker/pages/categories_page.dart';
import 'package:screenseeker/pages/account_page.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        iconSize: 27.0,
        selectedItemColor: Colors.purpleAccent,
        backgroundColor: const Color.fromARGB(255, 31, 30, 30),
        elevation: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
          ),

          //
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category_outlined,
            ),
            label: 'Categories',
          ),

          //
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

//Page List
const List<Widget> _pages = <Widget>[
  Home(),
  CategoriesPage(),
  AccountPage(),
];
