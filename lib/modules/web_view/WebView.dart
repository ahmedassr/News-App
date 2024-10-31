import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyWebView extends StatefulWidget{
  final String url;
   const MyWebView({super.key, required this.url});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}


class _MyWebViewState extends State<MyWebView> {

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
     controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: WebViewWidget(controller: controller),);
  }
  }