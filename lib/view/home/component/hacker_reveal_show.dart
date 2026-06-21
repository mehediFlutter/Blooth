import 'package:flutter/material.dart';

class HackerRevealTile extends StatefulWidget {
  final int index;
  final Widget child;

  const HackerRevealTile({super.key, required this.index, required this.child});

  @override
  State<HackerRevealTile> createState() => HackerRevealTileState();
}

class HackerRevealTileState extends State<HackerRevealTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      Future.delayed(Duration(milliseconds: widget.index * 80), () {
        if (mounted) {
          _controller.forward();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final progress = Curves.easeOutCubic.transform(_controller.value);
        final fade = progress.clamp(0.0, 1.0).toDouble();

        return RepaintBoundary(
          child: Transform.translate(
            offset: Offset(0, 16 * (1 - fade)),
            child: Opacity(
              opacity: fade,
              child: Stack(
                children: [
                  child!,
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.3 * (1 - fade),
                        child: CustomPaint(
                          painter: _HackerRevealPainter(progress: fade),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HackerRevealPainter extends CustomPainter {
  final double progress;

  _HackerRevealPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final glowPaint = Paint()
      ..color = const Color(0xFF44FF88).withValues(alpha: 0.10);
    final linePaint = Paint()
      ..color = const Color(0xFF8CFFB4).withValues(alpha: 0.12)
      ..strokeWidth = 1;

    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF44FF88).withValues(alpha: 0.15),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ).createShader(Offset.zero & size),
    );

    final sweepY = size.height * progress;
    canvas.drawRect(
      Rect.fromLTWH(0, (sweepY - 3).clamp(0.0, size.height), size.width, 6),
      glowPaint,
    );

    for (double y = 0; y < size.height; y += 14) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.08,
        size.height * 0.12,
        size.width * 0.28,
        1,
      ),
      glowPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.66,
        size.height * 0.82,
        size.width * 0.22,
        1,
      ),
      glowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HackerRevealPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
