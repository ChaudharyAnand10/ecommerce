import 'package:flutter/material.dart';

import 'clipper/custom_rounded_clipper.dart';

class URondedEdges extends StatelessWidget {
  const URondedEdges({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: UCustomRoundedEdges(),
         child: child,
    );
  }
}
