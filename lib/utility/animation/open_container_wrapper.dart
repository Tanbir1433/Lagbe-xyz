import 'package:flutter/material.dart';
import 'package:animations/animations.dart';



class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.child,
    required this.nextScreen,
  });

  final Widget child;
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
      closedColor: const Color(0xFFE7E8E5),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 900),
      closedBuilder: (_, VoidCallback openContainer) {
        return InkWell(onTap: openContainer, child: child);
      },
      openBuilder: (_, __) => nextScreen,
    );
  }
}
