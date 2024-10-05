import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({
    super.key,
    required this.finalToken,
    required this.iframeId,
    required this.onFinished, required this.onError,
  });
  final String finalToken;
  final String iframeId;
  final VoidCallback onFinished;
  final VoidCallback onError;
  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {

  @override
  void initState() {
    super.initState();
    // Initialize the WebView controller if necessary
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..setNavigationDelegate(
                NavigationDelegate(
                  onNavigationRequest: (NavigationRequest request) {
                    // if (request.url.contains('success=true')) {
                    //   widget.onFinished();
                    // }
                    return NavigationDecision.navigate;
                  },
                  onPageFinished: (url) async {
                    if (!url.contains('iframes') &&
                        url.contains('success=true')) {
                      widget.onFinished();
                    }
                    if (url.contains("success=false")) {
 widget.onError();
                    }
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
              ..loadRequest(Uri.parse(
                  "https://accept.paymob.com/api/acceptance/iframes/${widget.iframeId}?payment_token=${widget.finalToken}"))),
      ),
    );
  }
}
