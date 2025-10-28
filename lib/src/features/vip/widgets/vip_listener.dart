import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/vip_bloc.dart';

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
                !state.isVIP &&
                !state.loading &&
                state.init) {
              // context.push(VipScreen.routePath);
            }
          },
        );
      },
      child: child,
    );
  }
}
