import 'package:lib/study_lib.dart';

class T0 implements ITextTest {
	@override
	String get authorName => '나상원';

	List<String> input = [];

	@override
	List<String> getOutput(Duration elapsed, Duration delta) {
		if(input.isEmpty) return ["No Input Given"];

		List<String> output = [];
		for(var val in input){
			int n = int.parse(val);
			for(int i = 1 ; i < 10; i++) {
				output.add('$n * $i = ${n * i}');
			}
			output.add('');
		}
		return output;
	}

	@override
	void setInput(List<String> args) {
		input = args;
	}
}