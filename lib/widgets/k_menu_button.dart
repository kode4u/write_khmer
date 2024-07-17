import 'package:dictionary/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dictionary/widgets/k_text.dart';
import 'package:get/get.dart';

class KMenuButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const KMenuButton(this.text, this.onPressed, {super.key});

  @override
  KMenuButtonState createState() => KMenuButtonState();
}

class KMenuButtonState extends State<KMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
                  SvgPicture.asset(
                    'assets/ui/ui_button_gold.svg',
                    width: 128,
                    height: 64,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 10,
                    child: Row(
                      children: [
                        KText(widget.text),
                      ],
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
