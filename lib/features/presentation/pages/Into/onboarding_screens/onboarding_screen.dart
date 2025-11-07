import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskmanagenet/core/constants/app_colors.dart';
import 'package:taskmanagenet/features/presentation/pages/Into/language_screen.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Plan Your Journey 📝",
      "desc":
          "Organize your tasks and create a clear roadmap for what you want to achieve.",
    },
    {
      "title": "Process & Set Goals 🎯",
      "desc":
          "Break down tasks, track your progress, and stay focused on reaching your goals.",
    },
    {
      "title": "Win & Celebrate 🏆",
      "desc":
          "Complete your tasks efficiently and enjoy the satisfaction of achieving your goals!",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => isLastPage = index == onboardingData.length - 1);
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: OnboardingPage(
                    key: ValueKey(index),
                    image: "assets/images/s${index + 1}.png",
                    title: data["title"]!,
                    description: data["desc"]!,
                  ),
                );
              },
            ),
            Positioned(
              bottom: 90,
              child: SmoothPageIndicator(
                controller: _controller,
                count: onboardingData.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primary,
                  dotColor: AppColors.accent,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
                onPressed: () {
                  if (isLastPage) {
                    Get.offAll(
                      () => const LanguageScreen(),
                      transition: Transition.fadeIn,
                    );
                  } else {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(isLastPage ? "Get Started" : "Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
