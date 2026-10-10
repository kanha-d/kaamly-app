import 'package:flutter/material.dart';
import 'package:kaamly/post_job_screen.dart';

import '../../../core/theme/app_theme.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int selectedTab = 0;

  final tabs = [
    'All',
    'Active',
    'Completed',
  ];

  final jobs = const [
    _Job(
      title: 'Custom Wardrobe',
      category: 'Furniture',
      location: '2.4 km away',
      price: '₹18,500',
      provider: 'Rahul Furniture',
      status: '2 Quotes',
      statusType: 'quote',
      icon: Icons.door_sliding_outlined,
    ),
    _Job(
      title: 'House Deep Cleaning',
      category: 'Cleaning',
      location: '1.8 km away',
      price: '₹1,499',
      provider: 'CleanPro Services',
      status: 'In Progress',
      statusType: 'active',
      icon: Icons.cleaning_services_outlined,
    ),
    _Job(
      title: 'Birthday Photography',
      category: 'Photography',
      location: '4.2 km away',
      price: '₹5,000',
      provider: 'Frame Studio',
      status: 'Completed',
      statusType: 'completed',
      icon: Icons.camera_alt_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Jobs',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -.8,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Track your requirements',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.greyText,
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
                          builder: (_) => const PostJobScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF1FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final selected =
                      selectedTab == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 13,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppTheme.primary
                            : const Color(0xFFF3F4F6),
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : const Color(
                            0xFF50545B,
                          ),
                          fontWeight:
                          selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 12),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final job = jobs[index];

                return _JobCard(job: job);
              },
              childCount: jobs.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 110),
          ),
        ],
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final _Job job;

  const _JobCard({
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;

    if (job.statusType == 'active') {
      statusColor = const Color(0xFF168A53);
    } else if (job.statusType == 'completed') {
      statusColor = const Color(0xFF6D5AE6);
    } else {
      statusColor = AppTheme.primary;
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(
        22,
        8,
        22,
        12,
      ),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFECEEF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F4FF),
                  borderRadius:
                  BorderRadius.circular(17),
                ),
                child: Icon(
                  job.icon,
                  color: AppTheme.primary,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      job.category,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.greyText,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(.10),
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Text(
                  job.status,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(
            height: 1,
            color: Color(0xFFEDEEF0),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppTheme.greyText,
              ),
              const SizedBox(width: 5),
              Text(
                job.location,
                style: const TextStyle(
                  color: AppTheme.greyText,
                  fontSize: 13,
                ),
              ),

              const Spacer(),

              Text(
                job.price,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: 18,
                color: AppTheme.greyText,
              ),
              const SizedBox(width: 5),
              Text(
                job.provider,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppTheme.greyText,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Job {
  final String title;
  final String category;
  final String location;
  final String price;
  final String provider;
  final String status;
  final String statusType;
  final IconData icon;

  const _Job({
    required this.title,
    required this.category,
    required this.location,
    required this.price,
    required this.provider,
    required this.status,
    required this.statusType,
    required this.icon,
  });
}