// class SearchVideo {
//   final String id;
//   final String title;
//   final String thumbnailUrl;
//   final String channelTitle;

//   SearchVideo({
//     required this.id,
//     required this.title,
//     required this.thumbnailUrl,
//     required this.channelTitle,
//   });

//   factory SearchVideo.fromJson(Map<String, dynamic> json) {
//     return SearchVideo(
//       id: json['id']['videoId'] as String,
//       title: json['snippet']['title'] as String,
//       thumbnailUrl: (json['snippet']['thumbnails']['high'] ??
//           json['snippet']['thumbnails']['default'])['url'] as String,
//       channelTitle: json['snippet']['channelTitle'] as String,
//     );
//   }
// }
