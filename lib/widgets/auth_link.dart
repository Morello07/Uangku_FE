import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class AuthLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const AuthLink({
    Key? key,
    required this.text,
    required this.linkText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              linkText,
              style: AppTextStyles.button,
            ),
          ),
        )
      ],
    );
  }
}