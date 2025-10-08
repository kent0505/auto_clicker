import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/snack.dart';
import '../widgets/settings_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> launchURL(String uri) async {
      try {
        final url = Uri.parse(uri);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw Exception();
        }
      } catch (e) {
        logger(e);
        if (context.mounted) {
          Snack.show(
            context,
            isError: true,
            message: 'Something went wrong',
          );
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: [
        SettingsTile(
          title: 'Subscription',
          vip: true,
          onPressed: () {},
        ),
        SettingsTile(
          title: 'Privacy Policy',
          onPressed: () async {
            await launchURL('https://rezka.ag/');
          },
        ),
        SettingsTile(
          title: 'Terms of Use',
          onPressed: () async {
            await launchURL('https://instagram.com');
          },
        ),
        SettingsTile(
          title: 'Support',
          onPressed: () async {
            await launchURL('https://instagram.com');
          },
        ),
      ],
    );
  }
}
