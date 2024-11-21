class UnsplashImage {
  final String id;
  final String imageUrl;
  final String altDescription;
  final double height;
  final double width;
  final String color;
  final String downloadUrl;

  UnsplashImage({
    required this.id,
    required this.imageUrl,
    required this.altDescription,
    required this.height,
    required this.width,
    required this.color,
    required this.downloadUrl,
  });

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      id: json['id'],
      imageUrl: json['urls']['regular'],
      altDescription: json['alt_description'] ?? 'No description available',
      height: json['height'].toDouble(),
      width: json['width'].toDouble(),
      color: json['color'],
      downloadUrl: json['links']['download'],
    );
  }
}
