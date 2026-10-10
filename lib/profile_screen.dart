import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(
                22,
                25,
                22,
                30,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE0EBFF),
                    Color(0xFFF0E9F7),
                    Color(0xFFF7E1E8),
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withOpacity(.75),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(.08),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 48,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Kanha',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    '+91 98765 43210',
                    style: TextStyle(
                      color: AppTheme.greyText,
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 48,
                    child: OutlinedButton(
                      onPressed: () {},
                      style:
                      OutlinedButton.styleFrom(
                        backgroundColor:
                        Colors.white
                            .withOpacity(.7),
                        side: BorderSide.none,
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                            25,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                          color:
                          AppTheme.darkText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                25,
                22,
                12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      value: '8',
                      label: 'Jobs',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      value: '5',
                      label: 'Completed',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      value: '4.9',
                      label: 'Rating',
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                18,
                22,
                10,
              ),
              child: const Text(
                'Account',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _ProfileOption(
              icon: Icons.location_on_outlined,
              title: 'Saved Addresses',
              subtitle: 'Manage your locations',
              onTap: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: _ProfileOption(
              icon: Icons.favorite_border_rounded,
              title: 'Saved Professionals',
              subtitle: 'Your favourite providers',
              onTap: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: _ProfileOption(
              icon: Icons.notifications_none_rounded,
              title: 'Notifications',
              subtitle: 'Manage notification settings',
              onTap: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: _ProfileOption(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              subtitle: 'Get help with Kaamly',
              onTap: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: _ProfileOption(
              icon: Icons.info_outline_rounded,
              title: 'About Kaamly',
              subtitle: 'Version 1.0.0',
              onTap: () {},
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(
                22,
                15,
                22,
                120,
              ),
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFE05252),
                ),
                label: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Color(0xFFE05252),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                  const Size(double.infinity, 56),
                  side: BorderSide(
                    color: const Color(
                      0xFFE05252,
                    ).withOpacity(.25),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.greyText,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius:
                BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: AppTheme.primary,
                size: 24,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xFF8B8F97),
            ),
          ],
        ),
      ),
    );
  }
}