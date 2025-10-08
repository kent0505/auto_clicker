import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/button.dart';
import '../../../core/constants.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height:
            Constants.navBarHeight + MediaQuery.of(context).viewPadding.bottom,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(
          horizontal: Constants.padding,
        ).copyWith(bottom: Constants.padding),
        decoration: BoxDecoration(
          color: AppColors.tile,
          borderRadius: BorderRadius.circular(Constants.radius),
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                _NavBarButton(
                  index: 1,
                  title: 'Autoclicker',
                  icon: Icons.home,
                  active: state is HomeInitial,
                ),
                _NavBarButton(
                  index: 2,
                  title: 'Guides',
                  icon: Icons.info,
                  active: state is HomeGuides,
                ),
                _NavBarButton(
                  index: 3,
                  title: 'Settings',
                  icon: Icons.settings,
                  active: state is HomeSettings,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  const _NavBarButton({
    required this.index,
    required this.icon,
    required this.title,
    required this.active,
  });

  final String title;
  final IconData icon;
  final int index;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Button(
        onPressed: active
            ? null
            : () {
                context.read<HomeBloc>().add(ChangePage(index: index));
              },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: active ? AppColors.accent : null,
              size: 30,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 12,
                fontFamily: AppFonts.w500,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
