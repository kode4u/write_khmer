import 'package:dictionary/states/app_state.dart';
import 'package:dictionary/widgets/k_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dictionary/widgets/k_text.dart';
import 'package:get/get.dart';

class KButton2 extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  double width;
  double height;
  double marginTop;
  double size;

  KButton2(this.text, this.onPressed,
      {this.width = 32,
      this.height = 64,
      this.marginTop = 10,
      super.key,
      this.size = 14});

  @override
  KButton2State createState() => KButton2State();
}

class KButton2State extends State<KButton2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: widget.height,
                    width: widget.width,
                    child: KContainer(),
                  ),
                  Positioned(
                    top: widget.marginTop,
                    child: KText(
                      widget.text,
                      size: widget.size,
                    ),
                  ),
                ],
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
