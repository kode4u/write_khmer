import 'package:dictionary/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class KIconCheckButton extends StatefulWidget {
  final String icon;
  final VoidCallback onPressed;
  final double height;

  const KIconCheckButton(this.icon, this.onPressed,
      {this.height = 64, super.key});

  @override
  KIconCheckButtonState createState() => KIconCheckButtonState();
}

class KIconCheckButtonState extends State<KIconCheckButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  bool isChecked = true;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Define the scale animation for zooming
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start the animation when the widget is first built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward().then((_) {
        _controller.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
            _controller.forward();
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
            _controller.reverse();
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
            _controller.reverse();
          });
        },
        onTap: () async {
          Get.find<AppState>().playTap();
          if (!_isPressed) {
            setState(() {
              isChecked = !isChecked;
            });
            await _controller.forward().orCancel;
            await _controller.reverse();
            widget.onPressed();
            _controller.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: SvgPicture.asset(
                isChecked ? 'assets/ui/ui_tick.svg' : 'assets/ui/ui-untick.svg',
                height: widget.height,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
