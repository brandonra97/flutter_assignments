import 'dart:math';

import 'package:lib/study_lib.dart';

class T3 implements ITextTest {
  @override
  String get authorName => '나상원';

  List<List<String>> matrix = List.generate(20, (i) => List.generate(60, (i) => '-', growable: false), growable: false);

  int horizontalDirection = 1;
  int heightOffset = 10;
  double degreePerMS = 180 / 750; // seconds to cover 1 degree
  double linePerMS = 60 / 750;
  double amplitude = 10;

  int prevHeight = 0;  
  int currentHeight = 0;
  int prevColumn = 0;
  int currentColumn = 0;
  
  @override
  List<String> getOutput(Duration elapsed, Duration delta) {
    final degreeDelta = degreePerMS * elapsed.inMilliseconds;
    currentHeight = (amplitude * sin(degreeDelta * ( pi / 180 ))).round() + heightOffset;

    var horizontalDelta = linePerMS * delta.inMilliseconds * horizontalDirection; 
    currentColumn = (currentColumn + horizontalDelta).round();
    if(currentColumn >= 59) {
      currentColumn = 59;
      horizontalDirection *= -1;
    }
    if(currentColumn <= 0){
      currentColumn = 0;
      horizontalDirection *= -1;
    }

    matrix[prevHeight][prevColumn] = '-';
    if(currentHeight < 20){
      matrix[currentHeight][currentColumn] = 'K';
      prevHeight = currentHeight;
      prevColumn = currentColumn;
    }
    return matrixToDrawing(matrix);
  }

  @override
  void setInput(List<String> args) {
  }

  List<String> matrixToDrawing(List<List<String>> matrix){
    List<String> result = [];
    for(int i = 0; i < matrix.length; i++){
      final buffer = StringBuffer('');
      for(int j = 0; j < matrix[i].length; j++){
        buffer.write(matrix[i][j]);
      }
      result.add(buffer.toString());
    }
    return result;
  }
}