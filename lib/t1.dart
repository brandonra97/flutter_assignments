import 'package:lib/study_lib.dart';

class T1 implements ITextTest {

  @override
  String get authorName => "나상원";

  List<String> args = [];

  @override
  List<String> getOutput(Duration elapsed, Duration delta) {
    List<String> output = [];
    drawHeart(20, '❤️', output);
    return output;
  }

  @override
  void setInput(List<String> args) {
    this.args = args;
  }

  String drawHeart(int n, String hearts, List<String> output){
    if(n == 1){
      output.add(hearts);
      return '$hearts❤️';
    }
    String temp = drawHeart(n - 1, hearts, output);
    output.add(temp);
    return '$temp❤️';    
  }
}