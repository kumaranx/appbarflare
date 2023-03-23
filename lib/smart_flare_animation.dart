import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  const SmartFlareAnimation({Key key}) : super(key: key);

  @override
  State<SmartFlareAnimation> createState() => _SmartFlareAnimationState();
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;

  // width & height from the artboard values in the animation
  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          setState(() {
            var localTouchPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(tapInfo.globalPosition);

            var topHalfTouched = localTouchPosition.dy < AnimationHeight / 2;

            var leftSideTouched = localTouchPosition.dx < AnimationWidth / 2;

            var rightSideTouched =
                localTouchPosition.dx > (AnimationWidth / 3) * 2;

            var middleTouched = !leftSideTouched && !rightSideTouched;

            if (leftSideTouched && topHalfTouched) {
              print('TopLeft');
            } else if (middleTouched && topHalfTouched) {
              print('TopMiddle');
            } else if (rightSideTouched && topHalfTouched) {
              print('TopRight');
            } else {
              if (isOpen) {
                print('Button Closed');
              } else {
                print('Button Opened');
              }

              isOpen = !isOpen;
            }
          });
        },
        child: FlareActor(
          'assets/button-animation.flr',
          animation: isOpen ? 'activate' : 'deactivate',
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay) {
    // switch (AnimationToPlay) {
    //   case:

    //     break;

    //   default:
    // }
  }
}
