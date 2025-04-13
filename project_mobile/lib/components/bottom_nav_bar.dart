  import 'package:flutter/material.dart';
  import 'package:project_mobile/contact.dart';
  import 'package:project_mobile/homepage.dart';
  import 'package:project_mobile/random_menu.dart';

  //เป็น component BottomNavigationBar แบบ StatelessWidget
  class BottomNavBar extends StatelessWidget {
    final int selectedIndex;

    const BottomNavBar({super.key, required this.selectedIndex});

    // ฟังก์ชันนี้จะถูกเรียกเมื่อผู้ใช้แตะที่ไอคอนใน BottomNavigationBar และมีการสร้าง Route ไปยังหน้าที่ index
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
    
    //สร้าง BottomNavigationBar ประกอบไปด้วย Random, home, contact โดย currentIndex หรือหน้าจอที่จะแสดงผลจะถูกส่งมาจากหน้าที่เรียกใช้ component นี้
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
