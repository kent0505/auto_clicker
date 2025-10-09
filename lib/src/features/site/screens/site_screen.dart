import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import '../bloc/site_bloc.dart';
import '../models/site.dart';
import '../../clicker/widgets/clicker_widget.dart';
import '../../clicker/widgets/control_panel.dart';

class SiteScreen extends StatefulWidget {
  const SiteScreen({super.key, required this.site});

  final Site site;

  static const routePath = '/SiteScreen';

  @override
  State<SiteScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  late final WebViewController controller;

  bool invalid = false;

  void onStart() async {
    // await controller?.runJavaScript(
    //   'window.scrollBy({ top: -200, behavior: "smooth" });',
    // );

    // await controller?.runJavaScript(
    //   'window.scrollBy({ left: 200, behavior: "smooth" });',
    // );

    // await controller?.runJavaScript(
    //   'window.scrollBy({ left: -200, behavior: "smooth" });',
    // );
    final state = context.read<ClickerBloc>().state;
    final x = state.x;
    final y = state.y;

    final js = """
      (function() {
        const el = document.elementFromPoint($x, $y);
        if (el) {
          el.click();
          console.log('Clicked element:', el);
          return 'Clicked at ($x, $y)';
        } else {
          console.log('No element found at ($x, $y)');
          return 'No element found at ($x, $y)';
        }
      })();
    """;

    await controller.runJavaScript(js);
  }

  void onDelete() {
    DialogWidget.show(
      context,
      confirm: true,
      title: 'Delete site?',
      onPressed: () {
        context.read<SiteBloc>().add(DeleteSite(site: widget.site));
        context.pop();
        context.pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    try {
      context.read<SiteBloc>().add(EditSite(site: widget.site));
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.prevent;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.site.url));
    } catch (e) {
      logger(e);
      setState(() {
        invalid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: widget.site.title,
        right: widget.site.isMy
            ? Button(
                onPressed: onDelete,
                child: const Icon(
                  Icons.delete,
                  size: 30,
                  color: AppColors.text,
                ),
              )
            : null,
      ),
      body: invalid
          ? const Center(
              child: Text(
                'Invalid url',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 16,
                  fontFamily: AppFonts.w500,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        right: -0.5, // чтобы убрать белую линию по краю
                        bottom: 0,
                        top: 0,
                        left: 0,
                        child: WebViewWidget(controller: controller),
                      ),
                      const ClickerWidget(),
                    ],
                  ),
                ),
                ControlPanel(onStart: onStart),
              ],
            ),
    );
  }
}
