import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lib/study_lib.dart';

class W1 extends IWidgetTest {
  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W1Widget(key : key);
  }
}

class W1Widget extends StatefulWidget {
  const W1Widget({ super.key });

  @override
  State<W1Widget> createState() => _W1Widget();
}

class _W1Widget extends State<W1Widget> {
  Color? buttonColor = Colors.pink[100];

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: buttonColor,
      ),
      child: GestureDetector (
        onTap: () {
          setState(() {
            buttonColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];
          });
        },
      )
    );
  }
}