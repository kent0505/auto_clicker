class Site {
  Site({
    required this.title,
    required this.url,
    required this.logo,
    this.asset = '',
  });

  final String title;
  final String url;
  final String logo;
  final String asset;
}
