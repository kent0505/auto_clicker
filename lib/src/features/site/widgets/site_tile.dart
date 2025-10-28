import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../site/screens/site_screen.dart';
import '../../site/models/site.dart';
import '../../vip/bloc/vip_bloc.dart';
import '../../vip/screens/vip_screen.dart';

class SiteTile extends StatelessWidget {
  const SiteTile({
    super.key,
    required this.site,
    this.vip = false,
  });

  final Site site;
  final bool vip;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: 84,
      width: MediaQuery.sizeOf(context).width / 3 - 16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.tile,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          if (vip) {
            if (!context.read<VipBloc>().state.isVip) {
              context.push(VipScreen.routePath);
              return;
            }
          }

          context.push(
            SiteScreen.routePath,
            extra: site,
          );
        },
        child: Column(
          children: [
            Expanded(
              child: site.asset.isEmpty
                  ? Image.network(
                      site.logo,
                      width: 50,
                      errorBuilder: errorBuilder,
                      frameBuilder: frameBuilder,
                    )
                  : Image.asset(
                      site.asset,
                      width: 50,
                      errorBuilder: errorBuilder,
                      frameBuilder: frameBuilder,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              site.title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.text,
                fontSize: 16,
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
