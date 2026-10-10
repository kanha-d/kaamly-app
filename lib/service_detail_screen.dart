import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceName;

  const ServiceDetailScreen({
    super.key,
    this.serviceName = 'Photography',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
              ),
              title: Text(
                serviceName,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                  ),
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  0,
                ),
                height: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE3EDFF),
                      Color(0xFFF2E7F7),
                      Color(0xFFFFE8EA),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 85,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  25,
                  22,
                  10,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -.7,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFB400),
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '(128 professionals)',
                          style: TextStyle(
                            color: AppTheme.greyText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Find trusted professionals near you',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: AppTheme.greyText,
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
                  20,
                  22,
                  12,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Popular services',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                _ServiceOption(
                  title: 'Wedding Photography',
                  description:
                  'Wedding, pre-wedding & events',
                  price: 'From ₹5,000',
                  icon: Icons.camera_alt_outlined,
                ),
                _ServiceOption(
                  title: 'Birthday Photography',
                  description:
                  'Birthday parties & celebrations',
                  price: 'From ₹2,500',
                  icon: Icons.celebration_outlined,
                ),
                _ServiceOption(
                  title: 'Product Photography',
                  description:
                  'Products, ecommerce & brands',
                  price: 'From ₹1,500',
                  icon: Icons.shopping_bag_outlined,
                ),
                _ServiceOption(
                  title: 'Event Videography',
                  description:
                  'Professional event video shoots',
                  price: 'From ₹4,000',
                  icon: Icons.videocam_outlined,
                ),
              ]),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(
          20,
          8,
          20,
          15,
        ),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const _PostJobPlaceholder(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              'Post a Requirement',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceOption extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final IconData icon;

  const _ServiceOption({
    required this.title,
    required this.description,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        22,
        7,
        22,
        7,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.greyText,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _PostJobPlaceholder extends StatelessWidget {
  const _PostJobPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Post Job'),
      ),
    );
  }
}