import 'package:flutter/material.dart';

//เป็น component ContactContainer แบบ StatelessWidget ที่รับค่า color, icon, text เพื่อแสดงผลที่ต่างกันตามแต่ละประเภท contact
class ContactContainer extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  const ContactContainer({
    super.key,
    required this.color,
    required this.icon,
    required this.text,
  });

  //สร้าง Container ที่ใช้สำหรับแสดงสี ไอคอน ข้อความ ตามที่ได้รับค่ามา
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 35),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 23),
          ),
        ],
      ),
    );
  }
}
