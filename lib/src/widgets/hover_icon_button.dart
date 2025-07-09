import 'package:flutter/material.dart';

/// A circular icon button that responds to hover and tap with scaling animation.
class HoverIconButton extends StatefulWidget {
  /// The icon to display inside the button.
  final IconData icon;

  /// The callback to execute when the icon is tapped.
  final VoidCallback onTap;

  const HoverIconButton({super.key, required this.icon, required this.onTap});

  @override
  State<HoverIconButton> createState() => _HoverIconButtonState();
}

class _HoverIconButtonState extends State<HoverIconButton> {
  bool _isHovered = false; // Tracks whether the icon is being hovered or tapped
  bool _isVisible = false; // Used to trigger fade-in effect on first build

  @override
  void initState() {
    super.initState();

    // Trigger initial fade-in after slight delay
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  // Updates the hover/tap visual state
  void _setHovered(bool val) {
    setState(() => _isHovered = val);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // Detects pointer entering/leaving the icon area (desktop/web)
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: GestureDetector(
        // Detects touch interactions (mobile)
        onTapDown: (_) => _setHovered(true),
        onTapUp: (_) => _setHovered(false),
        onTapCancel: () => _setHovered(false),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.1 : 1.0),
          builder: (context, scale, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: _isVisible ? 1.0 : 0.0, // Fade in on mount
              child: Transform.scale(
                scale: scale, // Grows slightly on hover/tap
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _isHovered
                            ? Colors.grey.shade300
                            : Colors.grey.shade200,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: widget.onTap,
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Icon(widget.icon, size: 20, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
