import 'package:sqflite/sqflite.dart';
import 'package:favicon/favicon.dart';

import '../../../core/utils.dart';
import '../models/site.dart';

abstract interface class SiteRepository {
  const SiteRepository();

  Future<List<Site>> getSites();
  Future<void> addSite(Site site);
  Future<void> editSite(Site site);
  Future<void> deleteSite(Site site);
  Future<String> getLogo(String url);
}

final class SiteRepositoryImpl implements SiteRepository {
  SiteRepositoryImpl({required Database db}) : _db = db;

  final Database _db;

  @override
  Future<List<Site>> getSites() async {
    final maps = await _db.query(Site.table);
    return maps.map((map) => Site.fromMap(map)).toList();
  }

  @override
  Future<void> addSite(Site site) async {
    await _db.insert(
      Site.table,
      site.toMap(),
    );
  }

  @override
  Future<void> editSite(Site site) async {
    await _db.update(
      Site.table,
      site.toMap(),
      where: 'id = ?',
      whereArgs: [site.id],
    );
  }

  @override
  Future<void> deleteSite(Site site) async {
    await _db.delete(
      Site.table,
      where: 'id = ?',
      whereArgs: [site.id],
    );
  }

  @override
  Future<String> getLogo(String url) async {
    try {
      final logo = await FaviconFinder.getBest(url);
      return logo?.url ?? '';
    } catch (e) {
      logger(e);
      return '';
    }
  }
}
