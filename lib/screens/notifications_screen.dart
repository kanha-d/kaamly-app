
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Booking Confirmed!',
      'message':
      'Your Home Cleaning booking has been confirmed by Priya Sharma.',
      'time': '10 min ago',
      'category': 'Bookings',
      'icon': Icons.check_circle_rounded,
      'color': Color(0xFFE3F8EC),
      'iconColor': Color(0xFF168653),
      'read': false,
    },
    {
      'title': 'Professional is on the way',
      'message':
      'Rahul Kumar is on the way to your location for the electrical repair.',
      'time': '30 min ago',
      'category': 'Bookings',
      'icon': Icons.delivery_dining_rounded,
      'color': Color(0xFFEAF1FF),
      'iconColor': AppTheme.primary,
      'read': false,
    },
    {
      'title': 'Payment Successful',
      'message':
      'Your payment of ₹799 was completed successfully.',
      'time': '2 hours ago',
      'category': 'Payments',
      'icon': Icons.account_balance_wallet_rounded,
      'color': Color(0xFFE3F8EC),
      'iconColor': Color(0xFF168653),
      'read': false,
    },
    {
      'title': 'Special offer just for you!',
      'message':
      'Get 20% off your next service booking. Explore services today!',
      'time': 'Yesterday',
      'category': 'Offers',
      'icon': Icons.local_offer_rounded,
      'color': Color(0xFFFFF0DB),
      'iconColor': Color(0xFFCC8500),
      'read': true,
    },
    {
      'title': 'Booking Completed',
      'message':
      'Your AC Repair service has been marked as completed. Share your feedback!',
      'time': 'Yesterday',
      'category': 'Bookings',
      'icon': Icons.task_alt_rounded,
      'color': Color(0xFFF3E8FF),
      'iconColor': Color(0xFF7C3AED),
      'read': true,
    },
    {
      'title': 'Welcome to Kaamly!',
      'message':
      'Find trusted professionals for your everyday needs, all in one place.',
      'time': '2 days ago',
      'category': 'General',
      'icon': Icons.waving_hand_rounded,
      'color': Color(0xFFEAF1FF),
      'iconColor': AppTheme.primary,
      'read': true,
    },
  ];

  int get unreadCount =>
      notifications.where((n) => n['read'] == false).length;

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == 'Unread') {
      return notifications.where((n) => n['read'] == false).toList();
    }

    if (selectedFilter == 'All') return notifications;

    return notifications
        .where((n) => n['category'] == selectedFilter)
        .toList();
  }

  void markAllAsRead() {
    setState(() {
      for (final notification in notifications) {
        notification['read'] = true;
      }
    });
  }

  void markAsRead(Map<String, dynamic> notification) {
    setState(() {
      notification['read'] = true;
    });
  }

  void deleteNotification(Map<String, dynamic> notification) {
    setState(() {
      notifications.remove(notification);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification deleted'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredNotifications;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FC),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Unread summary
            Container(
              margin: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          unreadCount == 0
                              ? 'You’re all caught up!'
                              : '$unreadCount unread notifications',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Stay updated on your services',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Filters
            SizedBox(
              height: 42,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  'All',
                  'Unread',
                  'Bookings',
                  'Payments',
                  'Offers',
                  'General',
                ].map((filter) {
                  final selected = selectedFilter == filter;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: selected,
                      onSelected: (_) {
                        setState(() => selectedFilter = filter);
                      },
                      selectedColor: AppTheme.primary,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      side: BorderSide(
                        color: selected
                            ? AppTheme.primary
                            : Colors.grey.shade300,
                      ),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 14),

            // Notification list
            Expanded(
              child: items.isEmpty
                  ? _EmptyNotifications(
                isUnread: selectedFilter == 'Unread',
              )
                  : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 30),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final notification = items[index];

                  return Dismissible(
                    key: ValueKey(notification['title']),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 22),
                      decoration: BoxDecoration(
                        color: Colors.red.shade500,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    onDismissed: (_) =>
                        deleteNotification(notification),
                    child: _NotificationCard(
                      notification: notification,
                      onTap: () => markAsRead(notification),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isRead = notification['read'] as bool;

    return Material(
      color: isRead ? Colors.white : const Color(0xFFF0F5FF),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isRead
                  ? const Color(0xFFEEF0F5)
                  : const Color(0xFFDCE7FF),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: notification['color'] as Color,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  notification['icon'] as IconData,
                  color: notification['iconColor'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (!isRead)
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.only(top: 5, left: 5),
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification['message'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          notification['time'] as String,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          notification['category'] as String,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  final bool isUnread;

  const _EmptyNotifications({required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFEAF1FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: AppTheme.primary,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isUnread ? 'You’re all caught up!' : 'Nothing to see here',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isUnread
                  ? 'You have no unread notifications.'
                  : 'New updates will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}