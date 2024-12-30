// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewYouTube extends StatefulWidget {
//   final String videoId;

//   WebViewYouTube({required this.videoId});

//   @override
//   State<WebViewYouTube> createState() => _WebViewYouTubeState();
// }

// class _WebViewYouTubeState extends State<WebViewYouTube> {
//   late final WebViewController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//     controller.loadRequest(
//         Uri.parse('https://www.youtube.com/embed/${widget.videoId}'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("YouTube Player")),
//         body: WebViewWidget(controller: controller));
//   }
// }
