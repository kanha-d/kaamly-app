import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../chat_detail_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: const Text(
          'Job Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_rounded,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          22,
          10,
          22,
          120,
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius:
                BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: AppTheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wedding Photography',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '2 professionals responded',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                            AppTheme.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF168A53),
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Requirement',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 15),

            _InfoRow(
              icon: Icons.category_outlined,
              title: 'Category',
              value: 'Photography',
            ),
            _InfoRow(
              icon: Icons.calendar_today_outlined,
              title: 'Date',
              value: '18 October 2026',
            ),
            _InfoRow(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: 'Indirapuram, Ghaziabad',
            ),
            _InfoRow(
              icon: Icons.currency_rupee_rounded,
              title: 'Budget',
              value: '₹5,000 – ₹8,000',
            ),

            const SizedBox(height: 15),

            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Looking for a photographer for a small wedding function. Need candid photos and some family portraits.',
              style: TextStyle(
                color: AppTheme.greyText,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                const Text(
                  'Quotes received',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '2 quotes',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            _QuoteCard(
              name: 'Frame Studio',
              rating: '4.9',
              price: '₹6,500',
              time: '1 day',
              context: context,
            ),

            _QuoteCard(
              name: 'Moments Photography',
              rating: '4.8',
              price: '₹7,200',
              time: '1 day',
              context: context,
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
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const ChatDetailScreen(
                        providerName: 'Frame Studio',
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.chat_bubble_outline_rounded,
                ),
                label: const Text('Chat'),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                  const Size(0, 55),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(28),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  AppTheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize:
                  const Size(0, 55),
                  elevation: 0,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Accept Quote',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4FA),
              borderRadius:
              BorderRadius.circular(13),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              color: AppTheme.greyText,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteCard extends StatelessWidget {
  final String name;
  final String rating;
  final String price;
  final String time;
  final BuildContext context;

  const _QuoteCard({
    required this.name,
    required this.rating,
    required this.price,
    required this.time,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFE7E9ED),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FF),
              borderRadius:
              BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFFFB400),
                    ),
                    Text(
                      ' $rating',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(
                        color: AppTheme.greyText,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color:
                        AppTheme.greyText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}