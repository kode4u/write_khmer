import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

class DarkOverlay extends StatefulWidget {
  final bool showOverlay;
  final int numStars;
  final VoidCallback onClose;

  const DarkOverlay({super.key, 
    required this.showOverlay,
    required this.numStars,
    required this.onClose,
  });

  @override
  _DarkOverlayState createState() => _DarkOverlayState();
}

class _DarkOverlayState extends State<DarkOverlay> {
  late List<int> _starSequence;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _starSequence = List.generate(widget.numStars, (index) => index);
    _startStarAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startStarAnimation() {
    int index = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (index < widget.numStars) {
        setState(() {});
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showOverlay) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/tick.json', width: 100),
            const SizedBox(height: 20),
            const Text("អបអរសាទរ", style: TextStyle(color: Colors.white, fontFamily: "Sr", fontSize: 28),),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(widget.numStars, (index) {
                
                return Visibility(
                  visible: index < _starSequence.length,
                  child: AnimatedOpacity(
                    opacity: _starSequence.contains(index) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Lottie.asset('assets/star.json', width: 96),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onClose,
              child: const Text("Close"),
            ),
          ],
        ),
      ),
    );
  }
}
