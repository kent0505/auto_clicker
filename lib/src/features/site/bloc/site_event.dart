part of 'site_bloc.dart';

@immutable
sealed class SiteEvent {}

final class GetSites extends SiteEvent {}

final class AddSite extends SiteEvent {
  AddSite({required this.site});

  final Site site;
}

final class EditSite extends SiteEvent {
  EditSite({required this.site});

  final Site site;
}

final class DeleteSite extends SiteEvent {
  DeleteSite({required this.site});

  final Site site;
}
