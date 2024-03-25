import 'package:blueberry_app/pages/books_page.dart';
import 'package:blueberry_app/pages/home_page.dart';
import 'package:blueberry_app/pages/profile_page.dart';
import 'package:blueberry_app/pages/trips_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavbarBottom extends StatefulWidget {
  const NavbarBottom({Key? key}) : super(key: key);

  @override
  State<NavbarBottom> createState() => _NavbarBottomState();
}

class _NavbarBottomState extends State<NavbarBottom> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    BookingPage(),
    TripsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              _onNavItemTapped(0);
            },
          ),
          GButton(
            icon: Icons.flight,
            text: 'Book',
            onPressed: () {
              _onNavItemTapped(1);
            },
          ),
          GButton(
            icon: Icons.sell,
            text: 'My Trips',
            onPressed: () {
              _onNavItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Me',
            onPressed: () {
              _onNavItemTapped(3);
            },
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          _onNavItemTapped(index);
        },
        rippleColor: Colors.grey.shade200,
        hoverColor: Colors.grey.shade100,
        activeColor: Color.fromARGB(255, 237, 83, 36),
        color: Colors.grey,
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
