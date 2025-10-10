import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/main_button.dart';
import '../../home/screens/home_screen.dart';
import '../data/onboard_repository.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  static const routePath = '/OnboardScreen';

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final pageController = PageController();

  int index = 0;

  void onContinue() async {
    if (index == 2) {
      await context.read<OnboardRepository>().removeOnboard();
      if (mounted) {
        context.go(HomeScreen.routePath);
      }
    } else {
      setState(() {
        index++;
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      });
    }
  }

  void onPageChanged(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: const [
              Center(child: Text('1')),
              Center(child: Text('2')),
              Center(child: Text('3')),
            ],
          ),
          Container(
            height: 260,
            color: AppColors.tile,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: const ScaleEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      scale: 1.5,
                      dotColor: AppColors.text,
                      activeDotColor: AppColors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  switch (index) {
                    0 => 'Best auto-clicker',
                    1 => 'Easy tap tool',
                    2 => 'Set up your multiclick',
                    _ => '',
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontFamily: AppFonts.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  switch (index) {
                    0 => 'Auto-clicker for Roblox and more',
                    1 => 'Quick precise taps - for any game or task',
                    2 => 'Multi-click makes gaming even easier',
                    _ => '',
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontFamily: AppFonts.w500,
                  ),
                ),
                const Spacer(),
                MainButton(
                  title: 'Continue',
                  horizontal: Constants.padding,
                  onPressed: onContinue,
                ),
                const SizedBox(height: Constants.padding * 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
