import 'package:flutter/material.dart';
import 'package:project_mobile/components/bottom_nav_bar.dart';
import 'package:project_mobile/components/contact_container.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TooCook Official',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 30,),
              ),
              const SizedBox(height: 8),
              Text(
                'สามารถติดตามข่าวสารหรือสั่งซื้อได้ที่',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20,),
              ),
              const SizedBox(height: 30),
              ContactContainer(color: Colors.blueAccent, icon: Icons.facebook, text: 'TooCook Facebook'),
              ContactContainer(color: Colors.green, icon: Icons.chat, text: 'TooCook Line'),
              ContactContainer(color: Colors.purple, icon: Icons.camera_alt, text: 'TooCook Instagram'),
              ContactContainer(color: Colors.black, icon: Icons.music_note, text: 'TooCook TikTok'),
            ],
          ),
        ),
      ),
    );
  }
}
