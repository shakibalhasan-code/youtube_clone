class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String duration;
  final String viewCount;
  final String likeCount;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.duration,
    required this.viewCount,
    required this.likeCount,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as String,
      title: json['snippet']['title'] as String,
      thumbnailUrl: (json['snippet']['thumbnails']['maxres'] ??
          json['snippet']['thumbnails']['high'])['url'] as String,
      channelTitle: json['snippet']['channelTitle'] as String,
      duration: parseDuration(json['contentDetails']['duration'] as String),
      viewCount: formatNumber(json['statistics']?['viewCount'] ?? '0'),
      likeCount: formatNumber(json['statistics']?['likeCount'] ?? '0'),
    );
  }

  static String parseDuration(String isoDuration) {
    final regex = RegExp(r'PT(\d+H)?(\d+M)?(\d+S)?');
    final match = regex.firstMatch(isoDuration);

    final hours = match?.group(1)?.replaceAll('H', '') ?? '0';
    final minutes = match?.group(2)?.replaceAll('M', '') ?? '0';
    final seconds = match?.group(3)?.replaceAll('S', '') ?? '0';

    if (hours != '0') {
      return '$hours:${minutes.padLeft(2, '0')}:${seconds.padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.padLeft(2, '0')}';
    }
  }

  static String formatNumber(String numberStr) {
    final number = int.tryParse(numberStr) ?? 0;
    if (number >= 1_000_000) {
      return '${(number / 1_000_000).toStringAsFixed(1)}M';
    } else if (number >= 1_000) {
      return '${(number / 1_000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }
}
