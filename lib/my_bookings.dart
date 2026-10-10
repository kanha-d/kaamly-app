
  import 'package:flutter/material.dart';
  import 'package:kaamly/core/theme/app_theme.dart';

  class MyBookingsScreen extends StatefulWidget {
    const MyBookingsScreen({super.key});

    @override
    State<MyBookingsScreen> createState() => _MyBookingsScreenState();
  }

  class _MyBookingsScreenState extends State<MyBookingsScreen> {
    String selectedStatus = 'All';

    final List<Map<String, dynamic>> bookings = [
      {
        'service': 'Home Cleaning',
        'provider': 'Priya Sharma',
        'date': '12 Oct 2026',
        'time': '10:00 AM',
        'price': '₹799',
        'status': 'Confirmed',
        'icon': Icons.cleaning_services_rounded,
        'color': const Color(0xFFEAF1FF),
      },
      {
        'service': 'Electrician',
        'provider': 'Rahul Kumar',
        'date': '14 Oct 2026',
        'time': '02:30 PM',
        'price': '₹499',
        'status': 'Pending',
        'icon': Icons.electrical_services_rounded,
        'color': const Color(0xFFFFF0DB),
      },
      {
        'service': 'Interior Designer',
        'provider': 'Amit Verma',
        'date': '08 Oct 2026',
        'time': '11:00 AM',
        'price': '₹1,499',
        'status': 'Completed',
        'icon': Icons.chair_alt_rounded,
        'color': const Color(0xFFE3F8EC),
      },
      {
        'service': 'AC Repair',
        'provider': 'Vikas Singh',
        'date': '06 Oct 2026',
        'time': '04:00 PM',
        'price': '₹699',
        'status': 'Cancelled',
        'icon': Icons.ac_unit_rounded,
        'color': const Color(0xFFF3E8FF),
      },
    ];

    List<Map<String, dynamic>> get filteredBookings {
      if (selectedStatus == 'All') return bookings;

      return bookings
          .where((booking) => booking['status'] == selectedStatus)
          .toList();
    }

    Color statusColor(String status) {
      switch (status) {
        case 'Confirmed':
          return const Color(0xFF168653);
        case 'Pending':
          return const Color(0xFFB7791F);
        case 'Completed':
          return const Color(0xFF2563EB);
        case 'Cancelled':
          return const Color(0xFFDC2626);
        default:
          return Colors.grey;
      }
    }

    @override
    Widget build(BuildContext context) {
      final items = filteredBookings;

      return Scaffold(
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFF8F9FC),
          elevation: 0,
          scrolledUnderElevation: 0,
          title: const Text(
            'My Bookings',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Summary banner
              Container(
                margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your services,',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'All in one place',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${bookings.length} bookings in total',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),

              // Status filters
              SizedBox(
                height: 42,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    'All',
                    'Pending',
                    'Confirmed',
                    'Completed',
                    'Cancelled',
                  ].map((status) {
                    final isSelected = selectedStatus == status;

                    return Padding(
                      padding: const EdgeInsets.only(right: 9),
                      child: ChoiceChip(
                        label: Text(status),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => selectedStatus = status);
                        },
                        selectedColor: AppTheme.primary,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? AppTheme.primary
                              : Colors.grey.shade300,
                        ),
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 12),

              // Booking list
              Expanded(
                child: items.isEmpty
                    ? _EmptyBookings()
                    : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 110),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final booking = items[index];

                    return _BookingCard(
                      booking: booking,
                      statusColor: statusColor(
                        booking['status'] as String,
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => _BookingDetailsSheet(
                            booking: booking,
                            statusColor: statusColor(
                              booking['status'] as String,
                            ),
                          ),
                        );
                      },
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

  class _BookingCard extends StatelessWidget {
    final Map<String, dynamic> booking;
    final Color statusColor;
    final VoidCallback onTap;

    const _BookingCard({
      required this.booking,
      required this.statusColor,
      required this.onTap,
    });

    @override
    Widget build(BuildContext context) {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEEF0F5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: booking['color'] as Color,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        booking['icon'] as IconData,
                        color: AppTheme.primary,
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['service'] as String,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'with ${booking['provider']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Divider(color: Colors.grey.shade200, height: 1),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 15,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        '${booking['date']} · ${booking['time']}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Text(
                      booking['price'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        booking['status'] as String,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'View details',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  class _BookingDetailsSheet extends StatelessWidget {
    final Map<String, dynamic> booking;
    final Color statusColor;

    const _BookingDetailsSheet({
      required this.booking,
      required this.statusColor,
    });

    @override
    Widget build(BuildContext context) {
      return Container(
        padding: EdgeInsets.fromLTRB(
          22,
          12,
          22,
          MediaQuery.of(context).viewInsets.bottom + 28,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 4,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                booking['service'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              _DetailRow(
                label: 'Professional',
                value: booking['provider'] as String,
              ),
              _DetailRow(
                label: 'Date',
                value: booking['date'] as String,
              ),
              _DetailRow(
                label: 'Time',
                value: booking['time'] as String,
              ),
              _DetailRow(
                label: 'Amount',
                value: booking['price'] as String,
              ),
              _DetailRow(
                label: 'Status',
                value: booking['status'] as String,
                valueColor: statusColor,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Close'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
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

  class _DetailRow extends StatelessWidget {
    final String label;
    final String value;
    final Color? valueColor;

    const _DetailRow({
      required this.label,
      required this.value,
      this.valueColor,
    });

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ],
        ),
      );
    }
  }

  class _EmptyBookings extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
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
                  Icons.calendar_month_rounded,
                  size: 48,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'No bookings found',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your service bookings will appear here.',
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