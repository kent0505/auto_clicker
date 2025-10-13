import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../vip/bloc/vip_bloc.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.title,
    this.vip = false,
    required this.onPressed,
  });

  final String title;
  final bool vip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      decoration: BoxDecoration(
        color: AppColors.tile,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: AppFonts.w500,
              ),
            ),
            const Spacer(),
            vip
                ? BlocBuilder<VipBloc, bool>(
                    builder: (context, isVip) {
                      return Text(
                        isVip ? 'VIP' : 'Free',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: AppFonts.w500,
                        ),
                      );
                    },
                  )
                : const IconWidget(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
