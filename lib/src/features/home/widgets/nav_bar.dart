import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/button.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/icon_widget.dart';
import '../bloc/home_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Constants.navBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(
          horizontal: Constants.padding,
        ).copyWith(bottom: Constants.padding),
        decoration: BoxDecoration(
          color: AppColors.tile,
          borderRadius: BorderRadius.circular(Constants.radius * 2),
        ),
        child: BlocBuilder<HomeBloc, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 16,
              children: [
                _NavBarButton(
                  index: 0,
                  title: 'Autoclicker',
                  icon: Icons.home_rounded,
                  active: state == 0,
                ),
                _NavBarButton(
                  index: 1,
                  title: 'Guides',
                  icon: Icons.info_rounded,
                  active: state == 1,
                ),
                _NavBarButton(
                  index: 2,
                  title: 'Settings',
                  icon: Icons.settings_rounded,
                  active: state == 2,
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
    required this.title,
    required this.icon,
    required this.active,
  });

  final int index;
  final String title;
  final IconData icon;
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
            IconWidget(
              icon,
              color: active ? AppColors.accent : AppColors.text,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: active ? AppColors.accent : AppColors.text,
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
