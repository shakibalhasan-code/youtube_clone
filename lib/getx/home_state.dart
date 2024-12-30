import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/getx/services/location_services.dart';
import 'package:my_tube/util/constant.dart';

class TrendState extends GetxController {
  var isLoading = false.obs;
  var trendVideos = <Video>[].obs;
  late final country;

  final LocationServices _locationServices = Get.put(LocationServices());

  @override
  void onInit() async {
    super.onInit();
    await _initializeLocationAndFetchVideos();
    country = _locationServices.country;
  }

  Future<void> _initializeLocationAndFetchVideos() async {
    await _locationServices.getLocation();

    // Ensure country is retrieved, then fetch videos.
    final regionCode = _locationServices.country.value;
    if (regionCode.isNotEmpty) {
      await fetchTrendVideo(10); // Adjust maxResult as needed.
    } else {
      print("Country code not available. Defaulting to 'US'.");
      await fetchTrendVideo(10); // Default region code.
    }
  }

  Future<void> fetchTrendVideo(int maxResult) async {
    try {
      isLoading.value = true;

      String apiUrl =
          "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&chart=mostPopular&regionCode=bd&maxResults=$maxResult&key=$apiKey";

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Video> fetchedVideos = [];

        for (var item in data['items']) {
          fetchedVideos.add(Video.fromJson(item));
        }

        trendVideos.value = fetchedVideos;
        print("Fetched ${fetchedVideos.length} trending videos.");
      } else {
        print("Failed to fetch trending videos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching trending videos: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
