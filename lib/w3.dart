import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lib/study_lib.dart';

class W3 extends IWidgetTest {

  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W3Widget( key : key );
  }

}

class W3Widget extends StatefulWidget {
  const W3Widget({ super.key });

  @override
  State<StatefulWidget> createState() {
    return _W3Widget();
  }

}

class _W3Widget extends State<W3Widget> {
  double _sliderVal = 0.0;

  void onChanged(double sliderVal) {
    setState(() => _sliderVal = sliderVal);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                                  clipBehavior: Clip.hardEdge,
        
                  decoration: BoxDecoration(
                    color: Colors.grey[200]
                  ),
                )
              ),
              Positioned(
                width: (MediaQuery.of(context).size.width / 2) * (_sliderVal / 100),
                height: 50,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                )
              ),
              Positioned (
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: Center (
                  child: Text ( '${_sliderVal.round()}%')
                )
              )
            ],
          ),
        ),
        Container (
          width: MediaQuery.of(context).size.width / 2,
          height: 60,
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Slider(
            value: _sliderVal,
            max: 100,
            onChanged: onChanged
          )
        )
        
      ],
    );
  }

}