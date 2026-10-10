import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import 'service_detail_screen.dart';

class ServiceListScreen extends StatefulWidget {
  final String? initialSearch;

  const ServiceListScreen({
    super.key,
    this.initialSearch,
  });

  @override
  State<ServiceListScreen> createState() =>
      _ServiceListScreenState();
}

class _ServiceListScreenState
    extends State<ServiceListScreen> {
  late TextEditingController searchController;

  final services = const [
    _Service(
      name: 'Makeup Artist',
      category: 'Beauty',
      rating: '4.9',
      jobs: '320',
      price: 'From ₹999',
      icon: Icons.face_retouching_natural,
    ),
    _Service(
      name: 'Photographer',
      category: 'Photography',
      rating: '4.8',
      jobs: '240',
      price: 'From ₹2,500',
      icon: Icons.camera_alt_outlined,
    ),
    _Service(
      name: 'Carpenter',
      category: 'Furniture',
      rating: '4.7',
      jobs: '180',
      price: 'From ₹500',
      icon: Icons.handyman_outlined,
    ),
    _Service(
      name: 'Interior Designer',
      category: 'Home',
      rating: '4.9',
      jobs: '145',
      price: 'From ₹3,000',
      icon: Icons.design_services_outlined,
    ),
    _Service(
      name: 'Electrician',
      category: 'Home Repair',
      rating: '4.8',
      jobs: '410',
      price: 'From ₹299',
      icon: Icons.electrical_services_outlined,
    ),
    _Service(
      name: 'Plumber',
      category: 'Home Repair',
      rating: '4.7',
      jobs: '290',
      price: 'From ₹299',
      icon: Icons.plumbing_outlined,
    ),
    _Service(
      name: 'Tailor',
      category: 'Fashion',
      rating: '4.8',
      jobs: '130',
      price: 'From ₹199',
      icon: Icons.content_cut_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController(
      text: widget.initialSearch ?? '',
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  20,
                  22,
                  15,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Find Services',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 22,
                ),
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5F7),
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: TextField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'What service do you need?',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
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
                child: Row(
                  children: [
                    const Text(
                      'Nearby services',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F7),
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.tune_rounded,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              sliver: SliverList(
                delegate:
                SliverChildBuilderDelegate(
                      (context, index) {
                    final service = services[index];

                    final search =
                    searchController.text
                        .toLowerCase();

                    if (search.isNotEmpty &&
                        !service.name
                            .toLowerCase()
                            .contains(search)) {
                      return const SizedBox.shrink();
                    }

                    return _ServiceCard(
                      service: service,
                    );
                  },
                  childCount: services.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final _Service service;

  const _ServiceCard({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceDetailScreen(
              serviceName: service.name,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFECEEF2),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 68,
              width: 68,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius:
                BorderRadius.circular(20),
              ),
              child: Icon(
                service.icon,
                size: 31,
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
                    service.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    service.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.greyText,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 17,
                        color: Color(0xFFFFB400),
                      ),
                      Text(
                        ' ${service.rating}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        '  •  ',
                        style: TextStyle(
                          color: AppTheme.greyText,
                        ),
                      ),
                      Text(
                        '${service.jobs} jobs',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.greyText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              service.price,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Service {
  final String name;
  final String category;
  final String rating;
  final String jobs;
  final String price;
  final IconData icon;

  const _Service({
    required this.name,
    required this.category,
    required this.rating,
    required this.jobs,
    required this.price,
    required this.icon,
  });
}