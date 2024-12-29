import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/getx/services/location_services.dart';
import 'package:my_tube/util/constant.dart';

class MusicState extends GetxController {
  var isLoading = false.obs;
  var musicVideos = <Video>[].obs;

  final LocationServices _locationServices = Get.put(LocationServices());

  @override
  void onInit() async {
    super.onInit();
    await _locationServices.getLocation();
  }

  Future<void> fetchMusicVideo(int maxResult) async {
    try {
      isLoading.value = true;
      final regionCode = _locationServices.country.value;

      String apiUrl =
          "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&chart=mostPopular&regionCode=${_locationServices.country.value}&videoCategoryId=10&maxResults=$maxResult&key=$apiKey";

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Video> fetchedVideos = [];

        for (var item in data['items']) {
          fetchedVideos.add(Video.fromJson(item));
        }

        musicVideos.value = fetchedVideos;
      } else {
        print("Failed to fetch music videos: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching music videos: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
