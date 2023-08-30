import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healtyfy/src/widgets/AppBarBackWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EdukasiDetailView extends ConsumerStatefulWidget {
  String url;

  EdukasiDetailView({
    super.key,
    required this.url
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EdukasiDetailViewState();
}

class _EdukasiDetailViewState extends ConsumerState<EdukasiDetailView> {

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController = WebViewController();

    return Scaffold(
      body: Column(children: [
        const AppBarBackWidget(),
        Expanded(
          child: WebViewWidget(
            controller: webViewController..loadRequest(Uri.parse(widget.url)),
          ),
        )
      ],),
    );
  }
}