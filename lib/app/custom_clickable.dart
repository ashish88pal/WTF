import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ClickableWidget extends StatefulWidget {
  final double? onPressZoomPer;
  final Widget widget;

  final Callback onTap;

  const ClickableWidget({
    super.key,
    required this.widget,
    required this.onTap,
    this.onPressZoomPer,
  });

  @override
  State<ClickableWidget> createState() => _ClickableWidgetState();
}

class _ClickableWidgetState extends State<ClickableWidget> {
  bool _toggle = false;
  void _tapDown(TapDownDetails details) {
    HapticFeedback.selectionClick();
    setState(() {
      _toggle = !_toggle;
    });
  }

  void _tapUp(TapUpDetails details) {
    HapticFeedback.selectionClick();

    setState(() {
      _toggle = !_toggle;
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      widget.onTap.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onDoubleTap: () {
      //   widget.onTap.call();
      // },

      onTapDown: _tapDown,
      onTapUp: _tapUp,

      // onTap: () {
      //   setState(() {
      //     _toggle = !_toggle;
      //   });
      // },
      child: widget.widget.animate(target: _toggle ? 1 : 0).scale(
              end: Offset(
            widget.onPressZoomPer != null
                ? (1.0 + (0.01 * widget.onPressZoomPer!))
                : 0.95,
            widget.onPressZoomPer != null
                ? (1.0 + (0.01 * widget.onPressZoomPer!))
                : 0.95,
          )),
    );
  }
}
