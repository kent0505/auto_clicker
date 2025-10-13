import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../bloc/home_bloc.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(Constants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).viewPadding.top;
    final state = context.watch<HomeBloc>().state;

    return Container(
      height: Constants.appBarHeight + top,
      padding: EdgeInsets.only(top: top),
      child: Row(
        children: [
          const SizedBox(width: Constants.padding),
          Text(
            switch (state) {
              1 => 'Guides',
              2 => 'Settings',
              _ => 'Autoclicker',
            },
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 24,
              fontFamily: AppFonts.w600,
            ),
          ),
        ],
      ),
    );
  }
}
