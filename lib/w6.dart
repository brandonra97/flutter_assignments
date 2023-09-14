import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lib/study_lib.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class W6 implements IWidgetTest {
  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W6Widget( key: key );
  }
}

class W6Widget extends StatefulWidget {
  const W6Widget({super.key});

  @override
  State<W6Widget> createState() => _W6WidgetState();
}

class _W6WidgetState extends State<W6Widget> with TickerProviderStateMixin {
  late AnimationController tiltController;
  late AnimationController rotateController;
  late Animation tiltAnimation;
  late Animation rotateAnimation;

  bool tilted = false;
  double z_perspective = 0.001;
  double? original_x;
  double? original_y;
  double? original_z;
  double? x;
  double? y;
  double? z;

  double prevTiltAnimationVal = 0;
  double deltaTilt = 0;
  double prevRotateAnimationVal = 0;
  double deltaRotate = 0;

  Matrix4 transformA = Matrix4.identity();
  Matrix4 transformB = Matrix4.identity();
  late vector.Vector4 coordinates;
  late vector.Vector4 altered;

  @override
  void initState() {
    super.initState();

    tiltController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    rotateController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    tiltAnimation = Tween<double>(begin: 0.0, end: -1.0).animate(tiltController);
    rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(rotateController);

    transformA.setEntry(3, 2, z_perspective);
    transformB.setEntry(3, 2, z_perspective);

    tiltController.addListener(() { 
      setState(() {
        deltaTilt = tiltAnimation.value - prevTiltAnimationVal;
        prevTiltAnimationVal = tiltAnimation.value;
        transformA.rotateX(deltaTilt);
        transformB.rotateX(deltaTilt);
        altered = vector.Vector4.copy(coordinates);
        transformA.transform(altered);
        print('new: $coordinates');
      });  
    });
    rotateController.addListener(() { 
      setState(() {
        deltaRotate = rotateAnimation.value - prevRotateAnimationVal;
        prevRotateAnimationVal = rotateAnimation.value;
        double? prev_x = original_x;
        double? prev_y = original_y;
        x = (prev_x! * cos(rotateAnimation.value)) - (prev_y! * sin(rotateAnimation.value));
        y = (prev_x * sin(rotateAnimation.value)) + (prev_y * cos(rotateAnimation.value)); 
        print('new1: $x , $y');
      });  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            if(tilted)
              Positioned(
                top: 30,
                child: Transform (
                  alignment: FractionalOffset.center,
                  transform: transformB
                    // ..rotateX(deltaTilt)
                    // ..rotateZ(deltaRotate)
                  ,
                  child: Container (
                    clipBehavior: Clip.hardEdge,
                    width: 300,
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow (
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 12),
                          spreadRadius: 5
                        )
                      ]
                    ),
                  )
                ),
              ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTapDown:(details) {
                  setState(() {
                    original_x = details.localPosition.dx;
                    original_y = details.localPosition.dy;
                    original_z = 0;
                    x = original_x;
                    y = original_y;
                    z = 0;
                    coordinates = vector.Vector4(original_x!, original_y!, 0, 1);
                    altered = vector.Vector4(original_x!, original_y!, 0, 1);
                    print('${details.localPosition.dx}, ${details.localPosition.dy}');
                  });
                },
                child: Transform (
                  alignment: FractionalOffset.center,
                  transform: transformA
                    // ..rotateX(deltaTilt)
                    // ..rotateZ(deltaRotate)
                  ,
                  child: Container (
                    clipBehavior: Clip.hardEdge,
                    width: 300,
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.network('https://pbs.twimg.com/profile_images/1688001061565628416/1QctHAo__400x400.jpg')
                  )
                ),
              ),
            ),
            if(original_x != null && original_y != null)
              Positioned (
                top: altered.y - 31,
                left: altered.x - 17,
                // top: 0 - 31,
                // left: 0 - 17,
                child: const Icon (
                  Icons.location_pin,
                  color: Colors.red,
                  size: 35
                )
              )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector (
                onTap: () {
                  setState((){
                    original_x = null;
                    original_y = null;
                  });
                },
                child: Container (
                  width: 200,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[200]
                  ),
                  child: const Center(
                    child: Text (
                      '포인트 리셋',
                      style: TextStyle (
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      )
                    ),
                  )
                )
              )
            ),
            if(original_x != null && original_y != null)
              MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector (
                onTap: () {
                  setState(() {
                    // tilted = !tilted;
                    if(!tilted){
                      tiltController.forward();
                      Timer(const Duration(milliseconds: 500), () {
                        // rotateController.repeat();
                      });
                    }
                    else {
                      tiltController.reverse();
                      prevRotateAnimationVal = rotateAnimation.value;
                      if(rotateAnimation.value > pi){
                        // rotateController.forward();
                      }
                      else {
                        deltaTilt = 0;
                        // rotateController.reverse();
                      }
                    }
                    tilted = !tilted;
                  });
                },
                child: Container (
                  width: 150,
                  height: 45,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[200]
                  ),
                  child: Center(
                    child: Text (
                      tilted ? '직교투영' : '원근투영',
                      style: const TextStyle (
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      )
                    ),
                  )
                )
              )
            ),
          ]
        )
      ]
    );
  }
}