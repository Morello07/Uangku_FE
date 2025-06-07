import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/auth_link.dart';
import '../widgets/custom_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final success = await _authService.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
      if (success) {
        Navigator.pushReplacementNamed(
          context,
          '/home',
          arguments: _nameController.text,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const AuthHeader(
                  title: 'Register',
                  subtitle: 'Buat akun baru di UangKu',
                ),
                const SizedBox(height: 48),
                AuthInputField(
                  icon: Icons.person,
                  hint: 'Nama',
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  icon: Icons.email,
                  hint: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) return 'Email tidak boleh kosong';
                    if (!value.contains('@')) return 'Email tidak valid';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AuthInputField(
                  icon: Icons.lock,
                  hint: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) =>
                      value!.length < 6 ? 'Password minimal 6 karakter' : null,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: 'Register',
                  onPressed: _register,
                ),
                const SizedBox(height: 24),
                AuthLink(
                  text: 'Sudah punya akun?',
                  linkText: 'Login disini',
                  onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
