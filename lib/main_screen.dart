import 'package:flutter/material.dart';
import 'package:kaamly/my_bookings.dart';

import '../../../core/widgets/kaamly_bottom_nav.dart';
import '../../chat_screen.dart';
import '../../job_screen.dart';
import '../../profile_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final screens = const [
    HomeScreen(),
    JobsScreen(),
    MyBookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: KaamlyBottomNav(
        selectedIndex: selectedIndex,
        onChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}