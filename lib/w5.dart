import 'package:flutter/material.dart';
import 'package:lib/study_lib.dart';

// Ask about why the text goes downward slightly when going to the details page
// Ask about "Another exception was thrown: Expected a value of type 'ITickerState<State<StatefulWidget>>?', but got one of type '_W5WdigetState"
class W5 implements IWidgetTest {
  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W5Widget( key: key );
  }
}

class W5Widget extends StatefulWidget {
  W5Widget({super.key});

  final List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];
  final List<Color?> startColors = [
    Colors.red[100],
    Colors.orange[100],
    Colors.yellow[100],
    Colors.green[100],
    Colors.blue[100],
    Colors.indigo[100],
    Colors.purple[100]
  ];
  final List<Color?> endColors = [
    Colors.red[800],
    Colors.deepOrange[400],
    Colors.yellow[500],
    Colors.greenAccent[400],
    Colors.blue[800],
    Colors.indigo[500],
    Colors.purple[600]
  ];
  final List<int> indices = [0,1,2,3,4,5,6];

  @override
  State<W5Widget> createState() => _W5WidgetState();
}

class _W5WidgetState extends State<W5Widget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary:false,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20),
      children: widget.indices.map((index){
        return MouseRegion (
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => 
                  DetailWidget(startColor: widget.startColors[index], endColor: widget.endColors[index], weekDay: widget.weekdays[index])
                )
              );
            },
            child: Container (
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration (
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    widget.startColors[index]!,
                    widget.endColors[index]!
                  ]
                ), 
                borderRadius: BorderRadius.circular(15)
              ),
              child: Center(
                child: Text(
                  widget.weekdays[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 50
                  )
                )
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class DetailWidget extends StatelessWidget {
  final Color? startColor;
  final Color? endColor;
  final String weekDay;

  const DetailWidget({ 
    super.key, 
    required this.startColor,
    required this.endColor,
    required this.weekDay
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.black,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient (
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    startColor!,
                    endColor!
                  ],
                ),
                shape: BoxShape.circle
              ),
              child: Center(
                child: Text(
                  weekDay,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
              )
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container (
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }

}