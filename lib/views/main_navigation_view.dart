// file: main_navigation_view.dart
import 'package:flutter/material.dart';
import 'home_view.dart';
import 'goals_view.dart';
import 'statistics_view.dart';
import 'profile_view.dart';
import '../widgets/bottom_navigation_bar.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const GoalsView(),
    StatisticsView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    final isTablet = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      body: Row(
        children: [
          if (isTablet)
            NavigationRail(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) => setState(() => _currentIndex = index),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.flag),
                  label: Text('Goals'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bar_chart),
                  label: Text('Statistics'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('Profile'),
                ),
              ],
            ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isTablet ? null : CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
