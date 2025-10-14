import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/icon_widget.dart';
import '../../clicker/bloc/clicker_bloc.dart';
import '../bloc/site_bloc.dart';
import '../../clicker/models/click.dart';
import '../models/site.dart';
import '../widgets/click_widget.dart';
import '../widgets/control_panel.dart';
import '../widgets/web_widget.dart';

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
  bool started = false;

  Future<void> runJS(Click click, {bool swipeMode = false}) async {
    final x = click.x + 10;
    final y = click.y + 10;

    final js = swipeMode
        ? '''
        (function() {
        const el = document.elementFromPoint($x, $y);
        if (el) {
          el.scrollIntoView({ behavior: 'smooth', block: 'center', inline: 'center' });
        }
      })();
        '''
        : '''
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
    ''';
    await controller.runJavaScript(js);
  }

  void onStart() async {
    logger('START');
    final bloc = context.read<ClickerBloc>();

    final milliseconds = bloc.state.interval;
    final doubleClick = bloc.state.doubleClick;
    final swipeMode = bloc.state.swipeMode;
    int repeat = bloc.state.repeat;
    started = true;

    do {
      for (final click in bloc.state.clicks) {
        if (!started) break;

        setState(() {
          click.clicked = true;
        });
        await runJS(click, swipeMode: swipeMode);
        await Future.delayed(const Duration(milliseconds: 200));
        if (doubleClick && !swipeMode) await runJS(click);
        setState(() {
          click.clicked = false;
        });

        await Future.delayed(Duration(milliseconds: milliseconds - 200));
      }

      repeat--;
    } while (mounted && started && repeat > 0);

    if (mounted) {
      setState(() {
        started = false;
        logger('FINISH');
      });
    }
  }

  void onStop() {
    setState(() {
      started = false;
    });
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

  void onSave() async {
    final url = await controller.currentUrl() ?? '';
    url.replaceAll('https://', '');

    if (mounted) {
      DialogWidget.show(
        context,
        title: 'Save url $url?',
        confirm: true,
        onPressed: () {
          final site = Site(
            title: url,
            url: url,
          );
          context.read<SiteBloc>().add(AddSite(site: site));
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) async {
              final url = request.url;

              if (url.startsWith('intent://applink.instagram.com')) {
                await launchUrl(
                  Uri.parse('https://instagram.com'),
                  mode: LaunchMode.externalApplication,
                );
                return NavigationDecision.prevent;
              } else if (url
                  .startsWith('intent://www_link?url=www.facebook.com')) {
                await launchUrl(
                  Uri.parse('https://facebook.com'),
                  mode: LaunchMode.externalApplication,
                );
                return NavigationDecision.prevent;
              }

              if (url.startsWith('tg://') ||
                  url.startsWith('whatsapp://') ||
                  url.startsWith('mailto:') ||
                  url.startsWith('tel:')) {
                try {
                  await launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  logger('Error opening $url: $e');
                }
                return NavigationDecision.prevent;
              }

              if (url.startsWith('http') || url.startsWith('https')) {
                return NavigationDecision.navigate;
              }

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
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        onStop();
      },
      child: Scaffold(
        appBar: Appbar(
          title: widget.site.title,
          right: widget.site.isMy
              ? Button(
                  onPressed: onDelete,
                  child: const IconWidget(Icons.delete),
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
            : Stack(
                children: [
                  WebWidget(controller: controller),
                  BlocBuilder<ClickerBloc, ClickerState>(
                    builder: (context, state) {
                      return Stack(
                        children: List.generate(
                          state.clicks.length,
                          (index) {
                            return ClickWidget(
                              index: index,
                              click: state.clicks[index],
                            );
                          },
                        ),
                      );
                    },
                  ),
                  ControlPanel(
                    started: started,
                    controller: controller,
                    onStart: onStart,
                    onStop: onStop,
                  ),
                ],
              ),
      ),
    );
  }
}

// await controller?.runJavaScript(
    //   'window.scrollBy({ top: -200, behavior: "smooth" });',
    // );

    // await controller?.runJavaScript(
    //   'window.scrollBy({ left: 200, behavior: "smooth" });',
    // );

    // await controller?.runJavaScript(
    //   'window.scrollBy({ left: -200, behavior: "smooth" });',
    // );