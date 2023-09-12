import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lib/study_lib.dart';

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

  @override
  void initState() {
    super.initState();

    tiltController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    rotateController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    tiltAnimation = Tween<double>(begin: 0.0, end: -1.0).animate(tiltController);
    rotateAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(rotateController);

    tiltController.addListener(() { 
      setState(() {
        var transform = Matrix4.identity()..setEntry(3,2,z_perspective)..rotateX(tiltAnimation.value);
      });  
    });
    rotateController.addListener(() { setState(() {});  });
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if(tilted)
              Positioned(
                top: 30,
                child: Transform (
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, z_perspective)
                    ..rotateX(tiltAnimation.value)
                    // ..rotateZ(rotateAnimation.value)
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
                    print('${details.localPosition.dx}, ${details.localPosition.dy}');
                  });
                },
                child: Transform (
                  alignment: FractionalOffset.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, z_perspective)
                    ..rotateX(tiltAnimation.value)
                    // ..rotateZ(rotateAnimation.value)
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
                top: original_y! - 31,
                left: original_x! - 17,
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
                    tilted = !tilted;
                    if(tilted){
                      tiltController.forward();
                      rotateController.repeat();
                    }
                    else {
                      tiltController.reverse();
                      if(rotateAnimation.value > pi){
                        rotateController.forward();
                      }
                      else {
                        rotateController.reverse();
                      }
                    }
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