import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaamly/screens/notifications_screen.dart';
import 'package:kaamly/service_detail_screen.dart';
import 'package:kaamly/service_list_screen.dart';

import '../../../core/theme/app_theme.dart';
import 'screens/advanced_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNav = 0;

  final categories = const [
    _Category(
      title: 'Makeup',
      icon: Icons.face_retouching_natural,
    ),
    _Category(
      title: 'Cleaning',
      icon: Icons.cleaning_services_rounded,
    ),
    _Category(
      title: 'Plumber',
      icon: Icons.plumbing_rounded,
    ),
    _Category(
      title: 'Electrician',
      icon: Icons.electrical_services_rounded,
    ),
    _Category(
      title: 'Carpenter',
      icon: Icons.handyman_rounded,
    ),
  ];

  final services = const [
    _Service(
      title: 'Professional Photography',
      category: 'Photography',
      image: 'assets/images/provider_1.jpg',
      rating: '4.9',
      completed: '172',
      price: '₹2,500',
    ),
    _Service(
      title: 'Makeup Artist for Events',
      category: 'Makeup',
      image: 'assets/images/provider_2.jpg',
      rating: '4.8',
      completed: '94',
      price: '₹1,500',
    ),
    _Service(
      title: 'Home Deep Cleaning',
      category: 'Cleaning',
      image: 'assets/images/provider_3.jpg',
      rating: '4.9',
      completed: '231',
      price: '₹999',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Location header (Zomato style)
            SliverToBoxAdapter(
              child: _LocationHeader(
                onTap: () {
                  // TODO: Open location selection screen
                },
              ),
            ),

            // 2. Small full-width promotional slider
            SliverToBoxAdapter(
              child: _HomeBannerSlider(),
            ),

            // 3. Search input with animated category hints
            SliverToBoxAdapter(
              child: _AnimatedServiceSearch(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ServiceListScreen(),
                    ),
                  );
                },
              ),
            ),

            // 4. Categories heading + View All
            // 5. Eight categories in one horizontal row
            SliverToBoxAdapter(
              child: _CategoryGrid(
                categories: categories,
                onViewAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ServiceListScreen(),
                    ),
                  );
                },
              ),
            ),

            // 6. Popular services
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Popular Services',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ServiceListScreen(),
                    ),
                  );
                },
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 285,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: services.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 16),
                  itemBuilder: (_, index) {
                    return _ServiceCard(
                      service: services[index],
                    );
                  },
                ),
              ),
            ),

            // 7. Service list section
            SliverToBoxAdapter(
              child: _SectionHeader(
                title: 'Nearby Professionals',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ServiceListScreen(),
                    ),
                  );
                },
              ),
            ),

            // Vertical list of service cards
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final service = services[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _ServiceCard(
                        service: service,
                      ),
                    );
                  },
                  childCount: services.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 120),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TOP SECTION
// ============================================================

class _TopSection extends StatelessWidget {
  final List<_Category> categories;

  const _TopSection({
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        22,
        18,
        22,
        25,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDDE9FF),
            Color(0xFFEDE5F7),
            Color(0xFFF5DDE3),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const Expanded(
                child: Text(
                  'kaamly',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                  ),
                ),
              ),

              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.confirmation_number_outlined,
                      size: 21,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Offers',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  size: 25,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // Popular categories
          SizedBox(
            height: 108,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: categories.length,
              separatorBuilder: (_, __) =>
              const SizedBox(width: 18),
              itemBuilder: (_, index) {
                return _TopCategoryItem(
                  category: categories[index],
                );
              },
            ),
          ),

          const SizedBox(height: 22),
          // Search
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdvancedSearchScreen(),
                ),
              );
            },
            child: Container(
              height: 58,
              margin: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 28,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'What service do you need?',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TOP CATEGORY
// ============================================================

class _TopCategoryItem extends StatelessWidget {
  final _Category category;

  const _TopCategoryItem({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      child: Column(
        children: [
          Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.65),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              category.icon,
              size: 34,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            category.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// QUICK CATEGORIES
// ============================================================

class _QuickCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      (
      '❤️',
      'For You',
      ),
      (
      '✨',
      'Popular',
      ),
      (
      '📸',
      'Photography',
      ),
      (
      '💄',
      'Beauty',
      ),
      (
      '🔧',
      'Home Repair',
      ),
    ];

    return Container(
      height: 145,
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 12,
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 28),
        itemBuilder: (_, index) {
          return SizedBox(
            width: 78,
            child: Column(
              children: [
                Text(
                  items[index].$1,
                  style: const TextStyle(
                    fontSize: 42,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  items[index].$2,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LocationHeader extends StatelessWidget {
  final VoidCallback onTap;

  const _LocationHeader({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 18, 22, 18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              height: 46,
              width: 46,
              child: const Icon(
                Icons.location_on_rounded,
                color: AppTheme.primary,
                size: 26,
              ),
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your location',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 22,
                      ),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Choose your delivery location',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 21,
                backgroundColor: Color(0xFFF3F4F6),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _HomeBannerSlider extends StatefulWidget {
  const _HomeBannerSlider();

  @override
  State<_HomeBannerSlider> createState() =>
      _HomeBannerSliderState();
}

class _HomeBannerSliderState extends State<_HomeBannerSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _images = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer?.cancel();

    if (_images.length < 2) return;

    _timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) {
        if (!mounted || !_controller.hasClients) return;

        final nextPage = (_currentPage + 1) % _images.length;

        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 5,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Image.asset(
                  _images[index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: Color(0xFFEAF1FF),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: AppTheme.primary,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _images.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 5,
              width: _currentPage == index ? 18 : 5,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? AppTheme.primary
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


// ============================================================
// SECTION HEADER
// ============================================================
class _AnimatedServiceSearch extends StatefulWidget {
  final VoidCallback onTap;

  const _AnimatedServiceSearch({
    required this.onTap,
  });

  @override
  State<_AnimatedServiceSearch> createState() =>
      _AnimatedServiceSearchState();
}

class _AnimatedServiceSearchState
    extends State<_AnimatedServiceSearch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  final List<String> _hints = [
    'Makeup artist',
    'Electrician',
    'Interior designer',
    'Photographer',
    'Lawyer',
    'Furniture repair',
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
    _rotateHint();
  }

  Future<void> _rotateHint() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      await _animationController.reverse();

      if (!mounted) return;

      setState(() {
        _index = (_index + 1) % _hints.length;
      });

      await _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 14, 22, 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: AppTheme.primary,
                  size: 25,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Find ',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: ClipRect(
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        _hints[_index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.tune_rounded,
                  color: Colors.grey.shade600,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List categories;
  final VoidCallback onViewAll;

  _CategoryGrid({
    required this.categories,
    required this.onViewAll,
  });

  static const List<String> _icons = [
    'assets/images/makeup-artist.png',
    'assets/images/web-developer.png',
    'assets/images/photographer.png',
    'assets/images/digital-marketer.png',
    'assets/images/interior-designer.png',
    'assets/images/event-planner.png',
    'assets/images/accountant.png',
    'assets/images/graphic-designer.png',
    'assets/images/video-editor.png',
    'assets/images/lwayer.png',
    'assets/images/pet-care.png',
    'assets/images/tutor.png',
    'assets/images/video-grapher.png'
  ];

  static const List<String> _fallbackNames = [
    'Makeup Artist',
    'Web Developer',
    'Photography',
    'Digital Marketer',
    'Interior',
    'Event Planner',
    'Accountant',
    'Graphic Designer',
    'Video Editor',
    'Lawyer',
    'Pet Care',
    'Tutor',
    'Videographer',
  ];

  final List<int> _displayedCategoryIndices = () {
    final remaining = List<int>.generate(
      _icons.length - 4,
          (index) => index + 4,
    )..shuffle(Random());

    return [0, 1, 2, 3, ...remaining.take(4)];
  }();

  String _categoryName(dynamic category, int index) {
    if (category is String) return category;

    try {
      final value = category.name;
      if (value is String && value.isNotEmpty) return value;
    } catch (_) {}

    return _fallbackNames[index % _fallbackNames.length];
  }

  @override
  Widget build(BuildContext context) {
    final count = categories.length < 8 ? categories.length : 8;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Find Freelancer',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _displayedCategoryIndices.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 6,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              final categoryIndex = _displayedCategoryIndices[index];
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ServiceListScreen(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAFD),
                        borderRadius: BorderRadius.circular(58),
                      ),
                      child: Image.asset(
                        _icons[categoryIndex],
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      _fallbackNames[categoryIndex],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF656565)
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        22,
        20,
        22,
        18,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -.5,
              ),
            ),
          ),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F6F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SERVICE CARD
// ============================================================

class _ServiceCard extends StatelessWidget {
  final _Service service;

  const _ServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 285,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              service.image,
              height: 175,
              width: 285,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  height: 175,
                  width: 285,
                  color: const Color(0xFFE8ECF5),
                  child: const Icon(
                    Icons.image_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          Text(
            service.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 17,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                size: 21,
                color: Color(0xFF555B65),
              ),
              const SizedBox(width: 5),
              Text(
                service.rating,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF60656D),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 7,
                ),
                child: Text(
                  '|',
                  style: TextStyle(
                    color: Color(0xFFB0B3B8),
                  ),
                ),
              ),
              Text(
                '${service.completed} jobs',
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF60656D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FLOATING BOTTOM NAV
// ============================================================

class _FloatingBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _FloatingBottomNavigation({
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (
      Icons.home_rounded,
      'Home',
      ),
      (
      Icons.assignment_outlined,
      'Jobs',
      ),
      (
      Icons.chat_bubble_outline_rounded,
      'Chat',
      ),
      (
      Icons.person_outline_rounded,
      'Profile',
      ),
    ];

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(
        22,
        0,
        22,
        15,
      ),
      child: Container(
        height: 76,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.95),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.12),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            items.length,
                (index) {
              final selected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onChanged(index),
                  child: AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 200),
                    height: 60,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFFEAF1FF)
                          : Colors.transparent,
                      borderRadius:
                      BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          items[index].$1,
                          size: 25,
                          color: selected
                              ? AppTheme.primary
                              : const Color(
                            0xFF292D35,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index].$2,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? AppTheme.primary
                                : const Color(
                              0xFF292D35,
                            ),
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

// ============================================================
// MODELS
// ============================================================

class _Category {
  final String title;
  final IconData icon;

  const _Category({
    required this.title,
    required this.icon,
  });
}

class _Service {
  final String title;
  final String category;
  final String image;
  final String rating;
  final String completed;
  final String price;

  const _Service({
    required this.title,
    required this.category,
    required this.image,
    required this.rating,
    required this.completed,
    required this.price,
  });
}