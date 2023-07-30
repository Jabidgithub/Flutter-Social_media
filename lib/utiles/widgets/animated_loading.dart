import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AnimatedLoader extends StatelessWidget {
  const AnimatedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          LoadingAnimationWidget.hexagonDots(color: Colors.redAccent, size: 40),
    );
  }
}
