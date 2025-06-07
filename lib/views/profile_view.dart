import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data user sementara, nanti dari state user login
    final userName = 'aksa ganteng';
    final userEmail = 'aksa@gmail.com';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama', style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            Text(userName, style: AppTextStyles.body),
            const SizedBox(height: 24),
            Text('Email', style: AppTextStyles.subtitle),
            const SizedBox(height: 8),
            Text(userEmail, style: AppTextStyles.body),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement logout logic
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('Logout'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
