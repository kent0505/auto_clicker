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
    this.icon,
    this.vip = false,
    required this.onPressed,
  });

  final String title;
  final IconData? icon;
  final bool vip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 56,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      decoration: BoxDecoration(
        color: colors.tile,
        borderRadius: BorderRadius.circular(Constants.radius),
      ),
      child: Button(
        onPressed: onPressed,
        child: Row(
          children: [
            if (icon != null) ...[
              IconWidget(icon!),
              const SizedBox(width: 10),
            ],
            Text(
              title,
              style: TextStyle(
                color: colors.text,
                fontSize: 16,
                fontFamily: AppFonts.w500,
              ),
            ),
            const Spacer(),
            vip
                ? BlocBuilder<VipBloc, VipState>(
                    builder: (context, state) {
                      return Text(
                        state.isVIP ? 'VIP' : 'Free',
                        style: TextStyle(
                          color: colors.text,
                          fontSize: 16,
                          fontFamily: AppFonts.w500,
                        ),
                      );
                    },
                  )
                : const IconWidget(MyIcons.chevronRight),
          ],
        ),
      ),
    );
  }
}
