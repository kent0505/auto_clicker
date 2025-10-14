import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../site/bloc/site_bloc.dart';
import '../../site/models/site.dart';
import '../../../core/widgets/add_button.dart';
import '../widgets/site_tile.dart';
import 'add_site_screen.dart';

class SitesScreen extends StatelessWidget {
  const SitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Site> defaultSites = [
      Site(
        title: 'YouTube',
        url: 'https://www.youtube.com/',
        asset: Assets.logo1,
        isMy: false,
      ),
      Site(
        title: 'Instagram',
        url: 'https://www.instagram.com/',
        asset: Assets.logo2,
        isMy: false,
      ),
      Site(
        title: 'Facebook',
        url: 'https://www.facebook.com/',
        asset: Assets.logo3,
        isMy: false,
      ),
      Site(
        title: 'X',
        url: 'https://x.com/',
        asset: Assets.logo4,
        isMy: false,
      ),
      Site(
        title: 'Reddit',
        url: 'https://reddit.com/',
        asset: Assets.logo5,
        isMy: false,
      ),
      Site(
        title: 'TikTok',
        url: 'https://tiktok.com/',
        asset: Assets.logo6,
        isMy: false,
      ),
      Site(
        title: 'Netflix',
        url: 'https://netflix.com/',
        asset: Assets.logo7,
        isMy: false,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(Constants.padding),
      children: [
        const _Title('Popular'),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            defaultSites.length,
            (index) {
              return SiteTile(site: defaultSites[index]);
            },
          ),
        ),
        const SizedBox(height: Constants.padding),
        BlocBuilder<SiteBloc, SiteState>(
          builder: (context, state) {
            if (state is SitesLoading) {
              return const LoadingWidget();
            }

            if (state is SitesLoaded) {
              final sites = state.sites;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (sites.isNotEmpty) ...[
                    const _Title('My sites'),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        sites.length,
                        (index) {
                          return SiteTile(site: sites[index]);
                        },
                      ),
                    ),
                  ],
                ],
              );
            }

            return const SizedBox();
          },
        ),
        const SizedBox(height: Constants.padding),
        AddButton(
          title: 'Add site',
          onPressed: () {
            context.push(AddSiteScreen.routePath);
          },
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 18,
        fontFamily: AppFonts.w500,
      ),
    );
  }
}
