import 'package:flutter/material.dart';

class AnimatedBottomSheet extends StatefulWidget {
  final VoidCallback onShow;
  final String description;
  const AnimatedBottomSheet({
    super.key,
    required this.onShow,
    required this.description,
  });

  @override
  State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _animation = Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(
        curve: const Interval(0, 0.5, curve: Curves.easeInOut),
        parent: _controller));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    late bool showed = false;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        if (_controller.value == 1) {
          Future.delayed(const Duration(milliseconds: 800)).then(
            (value) => _controller.reverse().then((value) {
              if (!showed) {
                widget.onShow();
                showed = true;
              }
            }),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.red[400],
              height: (100 * _controller.value),
              child: Center(
                  child: Text(
                widget.description,
                style: const TextStyle(fontSize: 18),
              )),
            )
          ],
        );
      },
    );
  }
}
