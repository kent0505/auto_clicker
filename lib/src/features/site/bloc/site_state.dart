part of 'site_bloc.dart';

@immutable
sealed class SiteState {}

final class SitesLoading extends SiteState {}

final class SitesLoaded extends SiteState {
  SitesLoaded({required this.sites});

  final List<Site> sites;
}

final class SiteError extends SiteState {
  SiteError({required this.error});

  final String error;
}

final class SiteAdded extends SiteState {}
