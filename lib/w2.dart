import 'package:flutter/material.dart';
import 'package:lib/study_lib.dart';

class W2 extends IWidgetTest {
  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W2Widget( key: key );
  }

}

class W2Widget extends StatefulWidget {
  const W2Widget({ super.key });

  @override
  State<StatefulWidget> createState() {
    return _W2Widget();
  }
}

class _W2Widget extends State<W2Widget> {
  @override
  Widget build(BuildContext context) {
    return Container (
      width: MediaQuery.of(context).size.width / 2,
      height: 90,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 187, 236, 251),
        borderRadius: BorderRadius.circular(18)
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color.fromARGB(255, 0, 60, 255), width: 3),
            ),
            child: Container (
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 192, 225, 252)
              ),
            )
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '냥냥이',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800]
                  )
                ),
                const Text(
                  '냐옹이는 귀여워',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 109, 109, 109)
                  )
                )
              ]
            ),
          ),
          const Icon(
            Icons.arrow_forward,
            size: 25,
            color: Color.fromARGB(255, 0, 60, 255),
          )
        ],
      )
    );
  }

}