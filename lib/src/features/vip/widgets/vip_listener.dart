import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/vip_bloc.dart';
import '../screens/vip_screen.dart';

class VipListener extends StatelessWidget {
  const VipListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VipBloc, VipState>(
      listener: (context, state) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            if (context.mounted &&
                !state.isVip &&
                !state.loading &&
                state.init) {
              context.push(VipScreen.routePath);
            }
          },
        );
      },
      child: child,
    );
  }
}
