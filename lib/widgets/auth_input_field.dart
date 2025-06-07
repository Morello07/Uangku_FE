import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AuthInputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const AuthInputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.textLight),
        hintText: hint,
        hintStyle: AppTextStyles.inputLabel,
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
      ),
      style: AppTextStyles.inputLabel,
    );
  }
}