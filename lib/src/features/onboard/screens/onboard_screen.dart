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
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: [
              Image.asset(Assets.onb1),
              Padding(
                padding: const EdgeInsets.all(Constants.padding),
                child: Image.asset(Assets.onb2),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  Assets.icon,
                  color: AppColors.accent,
                ),
              ),
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
                    0 => 'Automate Your Clicks Effortlessly',
                    1 => 'Full Control, Your Way',
                    2 => 'Ready to Click?',
                    _ => '',
                  },
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 20,
                    fontFamily: AppFonts.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Constants.padding),
                  child: Text(
                    switch (index) {
                      0 =>
                        'Boost your productivity or test your pages faster. Auto Clicker lets you perform automatic clicks anywhere on a webpage — hands-free and fully customizable.',
                      1 =>
                        'Set your click speed, choose single or double click, and fine-tune timing to match your needs. Everything happens right inside your browser view.',
                      2 =>
                        'Start your session, place your click points, and watch it go! You’re always in control — stop anytime with one tap.',
                      _ => '',
                    },
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 16,
                      fontFamily: AppFonts.w500,
                    ),
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
