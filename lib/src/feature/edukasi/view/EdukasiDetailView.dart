import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EdukasiDetailView extends ConsumerStatefulWidget {
  String url;

  EdukasiDetailView({super.key, required this.url});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EdukasiDetailViewState();
}

class _EdukasiDetailViewState extends ConsumerState<EdukasiDetailView> {
  late WebViewController webViewController;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarBackWidget(),
          Expanded(
            child: WebViewWidget(
              controller: webViewController,
            ),
          )
        ],
      ),
    );
  }
}
