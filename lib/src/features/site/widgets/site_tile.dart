import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../site/screens/site_screen.dart';
import '../../site/models/site.dart';

class SiteTile extends StatelessWidget {
  const SiteTile({super.key, required this.site});

  final Site site;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: MediaQuery.sizeOf(context).width / 3 - 16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.tile,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
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
              style: const TextStyle(
                color: AppColors.text,
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
