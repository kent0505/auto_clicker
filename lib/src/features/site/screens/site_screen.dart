import 'package:auto_clicker/src/features/site/widgets/clicker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../bloc/site_bloc.dart';
import '../models/site.dart';

class SiteScreen extends StatefulWidget {
  const SiteScreen({super.key, required this.site});

  final Site site;

  static const routePath = '/SiteScreen';

  @override
  State<SiteScreen> createState() => _SiteScreenState();
}

class _SiteScreenState extends State<SiteScreen> {
  WebViewController? controller;
  late final Site site;

  double x = 100;
  double y = 200;

  void onStart() async {
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

    await controller?.runJavaScript(js);
  }

  void onDelete() {
    DialogWidget.show(
      context,
      confirm: true,
      title: 'Delete site?',
      onPressed: () {
        context.read<SiteBloc>().add(DeleteSite(site: site));
        context.pop();
        context.pop();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    site = widget.site;
    logger(site.logo);
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(site.url));
    } catch (e) {
      logger(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Appbar(
        title: site.title,
        right: site.isMy
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
      body: controller == null
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
                        right: -0.5,
                        bottom: 0,
                        top: 0,
                        left: 0,
                        child: WebViewWidget(controller: controller!),
                      ),

                      //
                      Positioned(
                        left: x,
                        top: y,
                        child: ClickerWidget(
                          onPanUpdate: (details) {
                            setState(() {
                              x += details.delta.dx;
                              y += details.delta.dy;

                              x = x.clamp(0, size.width - 60);
                              y = y.clamp(0, size.height - 60);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  color: AppColors.bg,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        onPressed: onStart,
                        child: const Text(
                          'Start',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: AppFonts.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
