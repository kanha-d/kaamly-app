import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/kaamly_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final pages = const [
    (
    icon: 'assets/images/hire.jpg',
    title: 'Find Local Professionals',
    description:
    'Discover trusted professionals and service providers near you.',
    ),
    (
    icon: 'assets/images/quotes.jpg',
    title: 'Compare Multiple Quotes',
    description:
    'Tell us what you need and receive quotes from nearby professionals.',
    ),
    (
    icon: 'assets/images/success.jpg',
    title: 'Hire With Confidence',
    description:
    'Compare profiles, prices and reviews before choosing the right person.',
    ),
  ];

  void next() {
    if (currentPage == pages.length - 1) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.login),
                  child: const Text('Skip'),
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    final page = pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 280,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EEFF),
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: Image.asset(
                            page.icon,
                          )
                        ),
                        const SizedBox(height: 50),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 7,
                    width: currentPage == index ? 24 : 7,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? const Color(0xFF5B4BFF)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              KaamlyButton(
                text: currentPage == pages.length - 1
                    ? 'Get Started'
                    : 'Continue',
                onPressed: next,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}