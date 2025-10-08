part of 'site_bloc.dart';

@immutable
sealed class SiteState {}

final class SitesLoading extends SiteState {}

final class SitesLoaded extends SiteState {
  SitesLoaded({required this.sites});

  final List<Site> sites;
}
