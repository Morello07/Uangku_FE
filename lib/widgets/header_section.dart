import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String userName;

  const HeaderSection({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFFFFB800),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end  ,
        children: [
          const Text(
            'UangKu',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai! Aksa Ganteng',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                  ),
                ),
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}