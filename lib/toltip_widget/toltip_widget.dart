// A tooltip with text, action buttons, and an arrow pointing to the target.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_component/toltip_widget/arrow_widget.dart';

class ToltipWidget extends StatefulWidget {
  final Widget content;
  final GlobalKey? targetGlobalKey;
  final Duration? delay;
  final Widget? child;
  final Color arrowColor;

  const ToltipWidget({
    super.key,
    required this.content,
    this.targetGlobalKey,
    this.delay,
    this.child,
    this.arrowColor = Colors.white,
  }) : assert(child != null || targetGlobalKey != null);

  @override
  State<StatefulWidget> createState() => ToltipWidgetState();
}

class ToltipWidgetState extends State<ToltipWidget>
    with SingleTickerProviderStateMixin {
  late bool isMounted;
  late double? _tooltipTop;
  late double? _tooltipBottom;
  late Alignment _tooltipAlignment;
  late Alignment _transitionAlignment;
  late Alignment _arrowAlignment;
  bool _isInverted = false;
  Timer? _delayTimer;

  final Size _arrowSize = const Size(16.0, 8.0);
  final double _tooltipMinimumHeight = 140;

  final _overlayController = OverlayPortalController();
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  void _toggle() {
    if (isMounted) {
      _delayTimer?.cancel();
      _animationController.stop();
      if (_overlayController.isShowing) {
        _animationController.reverse().then((_) {
          _overlayController.hide();
        });
      } else {
        _updatePosition();
        _overlayController.show();
        _animationController.forward();
      }
    }
  }

  void _updatePosition() {
    final Size contextSize = MediaQuery.of(context).size;
    final BuildContext? targetContext = widget.targetGlobalKey != null
        ? widget.targetGlobalKey!.currentContext
        : context;
    final targetRenderBox = targetContext?.findRenderObject() as RenderBox;
    final targetOffset = targetRenderBox.localToGlobal(Offset.zero);
    final targetSize = targetRenderBox.size;
    // Try to position the tooltip above the target,
    // otherwise try to position it below or in the center of the target.
    final bool tooltipFitsAboveTarget =
        targetOffset.dy - _tooltipMinimumHeight >= 0;
    final bool tooltipFitsBelowTarget =
        targetOffset.dy + targetSize.height + _tooltipMinimumHeight <=
            contextSize.height;

    _tooltipTop = tooltipFitsAboveTarget
        ? null
        : tooltipFitsBelowTarget
            ? targetOffset.dy + targetSize.height
            : null;

    _tooltipBottom = tooltipFitsAboveTarget
        ? contextSize.height - targetOffset.dy
        : tooltipFitsBelowTarget
            ? null
            : targetOffset.dy + targetSize.height / 2;

    // If the tooltip is below the target, invert the arrow.
    _isInverted = _tooltipTop != null;
    // Align the tooltip horizontally relative to the target.
    _tooltipAlignment = Alignment(
      (targetOffset.dx) / (contextSize.width - targetSize.width) * 2 - 1.0,
      _isInverted ? 1.0 : -1.0,
    );
    // Make the tooltip appear from the target.
    _transitionAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) / contextSize.width * 2 - 1.0,
      _isInverted ? -1.0 : 1.0,
    );
    // Center the arrow horizontally on the target.
    _arrowAlignment = Alignment(
      (targetOffset.dx + targetSize.width / 2) /
              (contextSize.width - _arrowSize.width) *
              2 -
          1.0,
      _isInverted ? 1.0 : -1.0,
    );
  }

  @override
  void initState() {
    isMounted = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // If the tooltip is delayed, start a timer to show it.
      if (widget.delay != null) {
        _delayTimer = Timer(widget.delay!, _toggle);
      }
    });
  }

  @override
  void dispose() {
    isMounted = false;
    _delayTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => child!,
      child: OverlayPortal.targetsRootOverlay(
        controller: _overlayController,
        child: widget.child != null
            ? GestureDetector(onTap: _toggle, child: widget.child)
            : null,
        overlayChildBuilder: (overlaycontext) {
          return Positioned(
            top: _tooltipTop,
            bottom: _tooltipBottom,
            // Provide a transition alignment to make the tooltip appear from the target.
            child: ScaleTransition(
              alignment: _transitionAlignment,
              scale: _scaleAnimation,
              // TapRegion allows the tooltip to be dismissed by tapping outside of it.
              child: TapRegion(
                onTapOutside: (PointerDownEvent event) {
                  if (isMounted) {
                    _toggle();
                  }
                },
                // If no theme is provided, a theme with inverted brightness is used.
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isInverted)
                        Align(
                          alignment: _arrowAlignment,
                          child: ArrowWidget(
                            size: _arrowSize,
                            isInverted: true,
                            color: widget.arrowColor,
                          ),
                        ),
                      Align(
                        alignment: _tooltipAlignment,
                        child: IntrinsicWidth(
                          child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(8.0),
                            child: widget.content,
                          ),
                        ),
                      ),
                      if (!_isInverted)
                        Align(
                          alignment: _arrowAlignment,
                          child: ArrowWidget(
                            size: _arrowSize,
                            isInverted: false,
                            color: widget.arrowColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
