import 'package:lib/study_lib.dart';

class T4 implements ITextTest {

  @override
  String get authorName => '나상원';

  List<String> args = [];

  @override
  List<String> getOutput(Duration elapsed, Duration delta) {
    if(args.isEmpty) return ['No value given.'];

    args.sort();
    args.sort((a, b) => a.length.compareTo(b.length));
    return args;
  }

  @override
  void setInput(List<String> args) {
    this.args = args;
  }
}