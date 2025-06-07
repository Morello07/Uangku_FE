import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/custom_button.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text('Hai!', style: AppTextStyles.heading),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Welcome to UangKu', style: AppTextStyles.subtitle),
                ),
                const SizedBox(height: 48),
                AuthInputField(
                  icon: Icons.email,
                  hint: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  icon: Icons.lock,
                  hint: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Login',
                  onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum punya akun?"),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/register'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          "Register disini",
                          style: AppTextStyles.button,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}