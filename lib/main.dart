import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const ClaudeRtlApp());

class ClaudeRtlApp extends StatelessWidget {
  const ClaudeRtlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Claude (RTL Fix)',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const ClaudeWebViewPage(),
    );
  }
}

class ClaudeWebViewPage extends StatefulWidget {
  const ClaudeWebViewPage({super.key});

  @override
  State<ClaudeWebViewPage> createState() => _ClaudeWebViewPageState();
}

class _ClaudeWebViewPageState extends State<ClaudeWebViewPage> {
  late final WebViewController _controller;
  bool _loading = true;

  // این اسکریپت هر بلوک متن رو dir="auto" می‌کنه تا جهت راست‌به‌چپ
  // خودکار تشخیص داده بشه، و کد/انگلیسی رو چپ‌چین نگه می‌داره.
  // با MutationObserver هم روی پیام‌های استریم‌شده (در حال تایپ) اعمال می‌شه.
  static const String _rtlFixJs = r'''
    (function () {
      function applyFix(root) {
        root.querySelectorAll(
          'p, li, span, div, h1, h2, h3, h4, h5, h6, td, th, blockquote'
        ).forEach(function (el) {
          if (el.closest('pre') || el.closest('code')) return;
          if (el.getAttribute('dir') !== 'auto') el.setAttribute('dir', 'auto');
        });
        root.querySelectorAll('pre, code, kbd, samp').forEach(function (el) {
          if (el.getAttribute('dir') !== 'ltr') el.setAttribute('dir', 'ltr');
        });
      }

      applyFix(document.body);

      if (window.__rtlFixObserverInstalled) return;
      window.__rtlFixObserverInstalled = true;

      const observer = new MutationObserver(function (mutations) {
        for (const m of mutations) {
          if (m.type === 'childList' || m.type === 'characterData') {
            applyFix(document.body);
            break;
          }
        }
      });
      observer.observe(document.body, {
        childList: true,
        subtree: true,
        characterData: true,
      });
    })();
  ''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            await _controller.runJavaScript(_rtlFixJs);
            if (mounted) setState(() => _loading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://claude.ai'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_loading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
