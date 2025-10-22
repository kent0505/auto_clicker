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
    final colors = Theme.of(context).extension<MyColors>()!;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: pageController,
            onPageChanged: onPageChanged,
            children: [
              Container(
                color: const Color(0xfffff9ee),
                child: Center(
                  child: Image.asset(Assets.onb1),
                ),
              ),
              Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset(Assets.onb2),
                ),
              ),
              Container(
                color: const Color(0xfffafafb),
                child: Center(
                  child: Image.asset(Assets.onb3),
                ),
              ),
            ],
          ),
          Container(
            height: 260,
            color: colors.tile,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ScaleEffect(
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 10,
                      scale: 1.5,
                      dotColor: colors.text,
                      activeDotColor: colors.accent,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  switch (index) {
                    0 => 'Automate Your Clicks Effortlessly',
                    1 => 'Add Multiple Click Points',
                    2 => 'Ready to Click?',
                    _ => '',
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.text,
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
                        'Create and manage several click areas on the screen. Perfect for automating repeated taps anywhere you need.',
                      2 =>
                        'Start your session, place your click points, and watch it go! You’re always in control — stop anytime with one tap.',
                      _ => '',
                    },
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.text2,
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
