import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controller/generalController.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:portfolio/view/about/about.dart';
import 'package:portfolio/view/experience/experience.dart';
import 'package:portfolio/view/intro/intro.dart';
import 'package:portfolio/view/widget/appBar.dart';
import 'package:portfolio/view/widget/leftPane.dart';
import 'package:portfolio/view/widget/rightPane.dart';
import 'package:portfolio/view/work/work.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'contact/contact.dart';

late AnimationController pointerSizeController;

class RootScreen extends ConsumerStatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends ConsumerState<RootScreen> with SingleTickerProviderStateMixin {
  final mScrollController = AutoScrollController();
    Offset pointerOffset = Offset.zero;
  
  late Animation<double> pointerAnimation;

  @override
  void initState() {
    super.initState();
     pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent: Tween<double>(begin: 0, end: 1).animate(pointerSizeController));
  }

   

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              ref.read(scrollControlProvider.notifier).state = false;
            } else if (direction == ScrollDirection.forward) {
              ref.read(scrollControlProvider.notifier).state = true;
            }
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                  Color(0xff112240),
                  Color(0xff0a192f),
                  Color(0xff020c1b)
                ])),
            height: AppClass().getMqHeight(context),
            child: MouseRegion(
               opaque: false,
        cursor: SystemMouseCursors.none,
        onHover: (e) => setState(() => pointerOffset = e.localPosition),
        onExit: (e) => setState(() => pointerOffset = Offset.zero),

              child: Stack(
                children: [
                  Column(
                    children: [
                      Consumer(builder: (context, ref, child) {
                        var isScrollingUp = ref.watch(scrollControlProvider);
                        return AnimatedOpacity(
                          opacity: isScrollingUp ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: ActionBar(mScrollController),
                        );
                      }),
                      Expanded(
                        child: () {
                          ScreenType scrType = AppClass().getScreenType(context);
                          return Row(
                            children: [
                              scrType == ScreenType.mobile ? SizedBox() : LeftPane(),
                              Expanded(
                                  flex: 8,
                                  child: ListView(
                                    controller: mScrollController,
                                    children: [
                                      
                                      VisibilityDetector(
                                          key: ValueKey(0),
                                        onVisibilityChanged: (VisibilityInfo info) {
                                          if(info.visibleFraction > 0){
                                            ref.read(currentMenuIndexProvider.notifier).state = -1;
                                          } 
                                        },
                                        child: AutoScrollTag(
                                            key: ValueKey(0),
                                            controller: mScrollController,
                                            index: 0,
                                            child: IntroContent(mScrollController)),
                                      ),
                                      VisibilityDetector(
                                         key: ValueKey(1),
                                        onVisibilityChanged: (VisibilityInfo info) {
                                          if(info.visibleFraction > 0){
                                            
                                            ref.read(currentMenuIndexProvider.notifier).state = 0;
                                          } 
                                        },
                                        child: AutoScrollTag(
                                            key: ValueKey(1),
                                            controller: mScrollController,
                                            index: 1,
                                            child: About()),
                                      ),
                                      VisibilityDetector(
                                          key: ValueKey(2),
                                        onVisibilityChanged: (VisibilityInfo info) {
                                          if(info.visibleFraction > 0){
                                            ref.read(currentMenuIndexProvider.notifier).state = 1;
                                          } 
                                        },
                                        child: AutoScrollTag(
                                            key: ValueKey(2),
                                            controller: mScrollController,
                                            index: 2,
                                            child: Experience()),
                                      ),
                                      VisibilityDetector(
                                          key: ValueKey(3),
                                        onVisibilityChanged: (VisibilityInfo info) {
                                          if(info.visibleFraction > 0){
                                            ref.read(currentMenuIndexProvider.notifier).state = 2;
                                          } 
                                        },
                                        child: AutoScrollTag(
                                            key: ValueKey(3),
                                            controller: mScrollController,
                                            index: 3,
                                            child: Work()),
                                      ),
                                      VisibilityDetector(
                                          key: ValueKey(4),
                                        onVisibilityChanged: (VisibilityInfo info) {
                                          if(info.visibleFraction > 0){
                                            
                                            ref.read(currentMenuIndexProvider.notifier).state = 3;
                                          } 
                                        },
                                        child: AutoScrollTag(
                                            key: ValueKey(4),
                                            controller: mScrollController,
                                            index: 4,
                                            child: Contact()),
                                      )
                                    ],
                                  )),
                              scrType == ScreenType.mobile ? SizedBox() : RightPane(),
                            ],
                          );
                        }(),
                      ),
                    ],
                  ),

                  if (pointerOffset != null) ...[
              AnimatedBuilder(
                  animation: pointerSizeController,
                  builder: (context, snapshot) {
                    return AnimatedPointer(
                      pointerOffset: pointerOffset,
                      radius: 45 + 100 * pointerAnimation.value,
                    );
                  }),
              AnimatedPointer(
                pointerOffset: pointerOffset,
                movementDuration: const Duration(milliseconds: 200),
                radius: 10,
              )
            ] 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



 void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController.forward();
    } else
      pointerSizeController.reverse();
  }


class AnimatedPointer extends StatelessWidget {
  const AnimatedPointer({
    Key? key,
    this.movementDuration = const Duration(milliseconds: 700),
    this.radius = 30,
    required this.pointerOffset,
  }) : super(key: key);
  final Duration movementDuration;
  final Offset pointerOffset;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: movementDuration,
      curve: Curves.easeOutExpo,
      top: pointerOffset.dy,
      left: pointerOffset.dx,
      child: CustomPaint(
        painter: Pointer(radius),
      ),
    );
  }
}

 
class Pointer extends CustomPainter {
  final double radius;

  Pointer(this.radius);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(0, 0),
      radius,
      Paint()
        ..color = AppColors().neonColor
        ..blendMode = BlendMode.difference,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}