import 'dart:math';

import 'package:lib/study_lib.dart';

class T3 implements ITextTest {
  @override
  String get authorName => '나상원';

  List<List<String>> matrix = List.generate(20, (i) => List.generate(40, (i) => '-', growable: false), growable: false);

  int lastLine = 0;
  double verticalTime = 0;
  double horizontalTime = 0;
  int horizontalOffset = 1;

  double secondsPerDegree = 750 / 180; // seconds to cover 1 degree
  double numRows = 20;
  int currentDegree = 0;
  double currentHeight = 0;
  double heightOffset = -10;

  double horiSecondPerLine = 750 / 20;
  double currentColumn = 0;
  
  @override
  List<String> getOutput(Duration elapsed, Duration delta) {
    verticalTime += delta.inMilliseconds;
    horizontalTime += delta.inMilliseconds;
    if(verticalTime > secondsPerDegree){ 
      verticalTime = 0;
      currentDegree++;
      currentHeight = (numRows * sin(currentDegree * ( pi / 180 ))) + heightOffset;
      
    }

    if(horizontalTime > horiSecondPerLine){
      horizontalTime = 0;
      currentColumn += horizontalOffset;
      if(currentColumn >= 19 || currentColumn <= 0) horizontalOffset *= -1;

    }
    return matrixToDrawing(matrix);
  }

  @override
  void setInput(List<String> args) {
  }

  List<String> matrixToDrawing(List<List<String>> matrix){

    return [];
  }
}