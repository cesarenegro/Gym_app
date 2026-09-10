import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ActionPill extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isFullWidth;
  final bool isSecondary;

  const ActionPill({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isFullWidth = true,
    this.isSecondary = false,
  });

  @override
  State<ActionPill> createState() => _ActionPillState();
}

class _ActionPillState extends State<ActionPill> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isSecondary ? AppColors.carbonSurface2 : AppColors.volt;
    final fgColor = widget.isSecondary ? AppColors.textPrimary : AppColors.onVolt;

    final content = AnimatedScale(
      scale: _isPressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(9999),
          border: widget.isSecondary ? Border.all(color: AppColors.hairline, width: 1) : null,
          boxShadow: widget.isSecondary
              ? null
              : [
                  BoxShadow(
                    color: AppColors.volt.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: widget.isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: AppTypography.tagUppercase.copyWith(
                color: fgColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: 8),
              Icon(widget.icon, size: 16, color: fgColor),
            ],
          ],
        ),
      ),
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: widget.isFullWidth ? SizedBox(width: double.infinity, child: content) : content,
    );
  }
}
