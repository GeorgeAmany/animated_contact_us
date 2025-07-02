import 'package:flutter/material.dart';

/// A reusable animation widget that combines fade-in and slide-up effects.
class AnimatedEntry extends StatelessWidget {
  /// Whether the child should be visible (triggering the animation).
  final bool visible;

  /// The widget to animate.
  final Widget child;

  /// Animation duration (defaults to 500ms).
  final Duration duration;

  /// The easing curve for both opacity and slide animations.
  final Curve curve;

  const AnimatedEntry({
    super.key,
    required this.visible,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // Fade in/out based on visibility
      opacity: visible ? 1.0 : 0.0,
      duration: duration,
      curve: curve,
      child: AnimatedSlide(
        // Slide up from bottom when invisible
        offset: visible ? Offset.zero : const Offset(0, 0.2),
        duration: duration,
        curve: curve,
        child: child,
      ),
    );
  }
}