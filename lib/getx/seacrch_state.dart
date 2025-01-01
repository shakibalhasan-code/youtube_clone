import 'package:get/get.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:my_tube/core/models/video_model.dart' as video;

class SearchState extends GetxController {
  RxList<video.Video> searchedVideos = <video.Video>[].obs;
  RxBool isLoading = false.obs;

  Future<void> searchVideos(String query) async {
    if (query.isEmpty) {
      Get.snackbar("Error", "Search query cannot be empty.");
      return;
    }

    final yt = YoutubeExplode();

    try {
      isLoading.value = true;

      // Perform the search
      final searchResults = await yt.search.getVideos(query);

      // Map the results to your Video model
      final videos = await Future.wait(searchResults.map((result) async {
        try {
          // Fetch additional details using the video ID
          final videoDetails = await yt.videos.get(result.id);

          return video.Video(
            id: result.id.value,
            title: result.title,
            thumbnailUrl: result.thumbnails.highResUrl,
            channelTitle: result.author,
            duration: video.Video.parseDuration(
                videoDetails.duration!.inSeconds.toString() ?? ''),
            viewCount: video.Video.formatNumber(
                videoDetails.engagement.viewCount.toString()),
            likeCount: video.Video.formatNumber(
                videoDetails.engagement.likeCount?.toString() ?? '0'),
          );
        } catch (e) {
          // Log errors for specific video fetching
          print("Failed to fetch details for video ID ${result.id.value}: $e");
          return null; // Skip this video
        }
      }));

      // Filter out null results
      searchedVideos.assignAll(videos.whereType<video.Video>().toList());
    } catch (e) {
      Get.snackbar("Error", "An error occurred during search: $e");
    } finally {
      // Ensure the YouTube Explode instance is closed
      yt.close();
      isLoading.value = false;
    }
  }
}
