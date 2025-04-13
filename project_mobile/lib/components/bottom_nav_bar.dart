  import 'package:flutter/material.dart';
  import 'package:project_mobile/contact.dart';
  import 'package:project_mobile/homepage.dart';
  import 'package:project_mobile/random_menu.dart';

  class BottomNavBar extends StatelessWidget {
    final int selectedIndex;

    const BottomNavBar({super.key, required this.selectedIndex});

    void _onItemTapped(BuildContext context, int index) {

      final List<Widget> destinations = [
        const RandomMenu(),
        const Homepage(),
        const Contact(),
      ];

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => destinations[index]),
        (route) => false,
      );
    }

    @override
    Widget build(BuildContext context) {
      return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
      );
    }
  }
