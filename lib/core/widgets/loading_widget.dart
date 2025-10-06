import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: Theme.of(context).colorScheme.primary,
        rightDotColor: Theme.of(context).colorScheme.secondary,
        size: 200,
      ),
    );
  }
}
