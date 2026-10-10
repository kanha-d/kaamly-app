import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class KaamlyBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const KaamlyBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const items = [
      (
      icon: Icons.home_rounded,
      label: 'Home',
      ),
      (
      icon: Icons.assignment_outlined,
      label: 'Jobs',
      ),
      (
      icon: Icons.bookmark_border_outlined,
      label: 'Bookings',
      ),
      (
      icon: Icons.person_outline_rounded,
      label: 'Profile',
      ),
    ];

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        14,
      ),
      child: Container(
        height: 76,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.97),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            items.length,
                (index) {
              final item = items[index];
              final selected = index == selectedIndex;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 220,
                    ),
                    height: 62,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEAF1FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 25,
                          color: selected
                              ? AppTheme.primary
                              : const Color(0xFF30343B),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? AppTheme.primary
                                : const Color(0xFF30343B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}