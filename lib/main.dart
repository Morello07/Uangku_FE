import 'package:flutter/material.dart';
import 'package:uangku_app/views/add_transaction_view.dart';
import 'package:uangku_app/views/goals_view.dart';
import 'package:uangku_app/views/home_view.dart';
import 'package:uangku_app/views/main_navigation_view.dart';
import 'package:uangku_app/views/profile_view.dart';
import 'package:uangku_app/views/statistics_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'theme/colors.dart';
import 'views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manajemen Uang',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
        '/register': (context) => const RegisterView(),
        '/home': (context) => const HomeView(),
        '/add_transaction': (context) => const AddTransactionView(),
         '/statistics': (context) => StatisticsView(),
         '/profile': (context) => const ProfileView(),
         '/goals': (context) => const GoalsView(),
         '/main': (context) => const MainNavigationView(),

      },
    );
  }
}
