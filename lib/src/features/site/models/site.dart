class Site {
  Site({
    this.id = 0,
    required this.title,
    required this.url,
    this.logo = '',
    this.asset = '',
    this.isMy = true,
  });

  int id;
  String title;
  String url;
  String logo;
  final String asset;
  final bool isMy;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'logo': logo,
    };
  }

  factory Site.fromMap(Map<String, dynamic> map) {
    return Site(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      logo: map['logo'],
    );
  }

  static const table = 'sites';
  static const create = '''
    CREATE TABLE IF NOT EXISTS $table (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      url TEXT,
      logo TEXT 
    )
    ''';
}
