import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../models/site.dart';
import '../widgets/home_tile.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Site> sites = [
      Site(
        title: 'YouTube',
        url: 'https://www.youtube.com',
        logo: '',
        asset: Assets.logo1,
      ),
      Site(
        title: 'Instagram',
        url: 'https://www.instagram.com',
        logo: '',
        asset: Assets.logo2,
      ),
      Site(
        title: 'Facebook',
        url: 'https://www.facebook.com',
        logo: '',
        asset: Assets.logo3,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            sites.length,
            (index) {
              return HomeTile(site: sites[index]);
            },
          ),
        ),
      ],
    );
  }
}
