import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() =>
      _PostJobScreenState();
}

class _PostJobScreenState
    extends State<PostJobScreen> {
  final titleController = TextEditingController();
  final descriptionController =
  TextEditingController();
  final budgetController = TextEditingController();

  String selectedCategory = 'Select category';
  String selectedDate = 'Select date';

  final categories = [
    'Photography',
    'Makeup Artist',
    'Carpenter',
    'Interior Designer',
    'Electrician',
    'Plumber',
    'Cleaning',
    'Tailor',
    'Other',
  ];

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    budgetController.dispose();
    super.dispose();
  }

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
          'Post a Requirement',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
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
            const Text(
              'Tell us what you need',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              'Nearby professionals will send you their quotes.',
              style: TextStyle(
                color: AppTheme.greyText,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 28),

            _label('What do you need?'),

            _input(
              controller: titleController,
              hint: 'e.g. Wedding photography',
            ),

            const SizedBox(height: 20),

            _label('Category'),

            GestureDetector(
              onTap: _showCategories,
              child: _selectBox(
                selectedCategory,
                Icons.category_outlined,
              ),
            ),

            const SizedBox(height: 20),

            _label('Describe your requirement'),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText:
                'Tell professionals what exactly you need...',
                filled: true,
                fillColor: const Color(0xFFF6F7F9),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            _label('Add photos'),

            GestureDetector(
              onTap: () {},
              child: Container(
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  borderRadius:
                  BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xFFE1E4E9),
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppTheme.primary,
                      size: 30,
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Add photos',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Help professionals understand your requirement',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _label('Your budget'),

            _input(
              controller: budgetController,
              hint: '₹ Enter your budget',
              keyboardType:
              TextInputType.number,
            ),

            const SizedBox(height: 20),

            _label('When do you need it?'),

            GestureDetector(
              onTap: _pickDate,
              child: _selectBox(
                selectedDate,
                Icons.calendar_today_outlined,
              ),
            ),

            const SizedBox(height: 20),

            _label('Location'),

            _selectBox(
              'Use my current location',
              Icons.location_on_outlined,
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius:
                BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppTheme.primary,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You will receive multiple quotes from professionals near you.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
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
            onPressed: _postJob,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Text(
              'Get Quotes',
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F7F9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _selectBox(
      String text,
      IconData icon,
      ) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7F9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.greyText,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: text.startsWith('Select')
                    ? AppTheme.greyText
                    : AppTheme.darkText,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
        ],
      ),
    );
  }

  void _showCategories() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (_) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            22,
            5,
            22,
            30,
          ),
          children: categories.map((category) {
            return ListTile(
              title: Text(category),
              trailing: selectedCategory ==
                  category
                  ? const Icon(
                Icons.check_rounded,
                color: AppTheme.primary,
              )
                  : null,
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate =
        '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  void _postJob() {
    if (titleController.text.trim().isEmpty) {
      return;
    }

    // Later:
    // POST /api/requirement/create

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Requirement posted successfully',
        ),
      ),
    );
  }
}