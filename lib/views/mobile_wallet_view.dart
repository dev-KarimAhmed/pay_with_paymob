
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MobileWalletScreen extends StatefulWidget {
  final String redirectUrl;
  final VoidCallback onSuccess;
  final VoidCallback onError;
  const MobileWalletScreen({
    super.key,
    required this.redirectUrl,
    required this.onSuccess, required this.onError,
  });

  @override
  State<MobileWalletScreen> createState() => _MobileWalletScreenState();
}

class _MobileWalletScreenState extends State<MobileWalletScreen> {


  @override
  void initState() {
    super.initState();
    // No need for platform check as the package handles it internally
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onNavigationRequest: (NavigationRequest request) async {
                    if (request.url.contains('success=true')) {
                      widget.onSuccess();
                    }
                    if (request.url.contains('success=false')) {
                      widget.onError();
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..addJavaScriptChannel(
                'Toaster',
                onMessageReceived: (JavaScriptMessage message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message.message)),
                  );
                },
              )
              ..loadRequest(Uri.parse(widget.redirectUrl))),
      ),
    );
  }
}
