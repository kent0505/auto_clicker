import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/site_repository.dart';
import '../models/site.dart';

part 'site_event.dart';
part 'site_state.dart';

class SiteBloc extends Bloc<SiteEvent, SiteState> {
  final SiteRepository _repository;

  SiteBloc({required SiteRepository repository})
      : _repository = repository,
        super(SitesLoaded(sites: const [])) {
    on<SiteEvent>(
      (event, emit) => switch (event) {
        GetSites() => _getSites(event, emit),
        AddSite() => _addSite(event, emit),
        DeleteSite() => _deleteSite(event, emit),
      },
    );
  }

  void _getSites(
    GetSites event,
    Emitter<SiteState> emit,
  ) async {
    try {
      final sites = await _repository.getSites();

      emit(SitesLoaded(sites: sites));
    } catch (e) {
      logger(e);
      emit(SitesLoaded(sites: const []));
    }
  }

  void _addSite(
    AddSite event,
    Emitter<SiteState> emit,
  ) async {
    emit(SitesLoading());
    try {
      final site = event.site;
      final uri = Uri.parse(site.url);
      if (uri.hasScheme && uri.hasAuthority) {
        site.logo = await _repository.getLogo(site.url);
        await _repository.addSite(site);
        emit(SiteAdded());
      } else {
        emit(SiteError(error: 'Invalid URL'));
      }
      add(GetSites());
    } catch (e) {
      logger(e);
    }
  }

  void _deleteSite(
    DeleteSite event,
    Emitter<SiteState> emit,
  ) async {
    emit(SitesLoading());
    try {
      await _repository.deleteSite(event.site);
      add(GetSites());
    } catch (e) {
      logger(e);
    }
  }
}
