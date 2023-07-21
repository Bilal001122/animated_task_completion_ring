import 'package:animated_task_completion_ring/task_completion_ring.dart';
import 'package:flutter/material.dart';

class AnimatedTask extends StatefulWidget {
  const AnimatedTask({super.key});

  @override
  State<AnimatedTask> createState() => _AnimatedTaskState();
}

class _AnimatedTaskState extends State<AnimatedTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: SizedBox(
          height: 150,
          child: GestureDetector(
            onLongPressEnd: (details) {
              _animation.isCompleted
                  ? _controller.stop()
                  : _controller.reverse();
            },
            onLongPress: () {
              _controller.forward();
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => TaskCompletionRing(
                progress: _animation.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
