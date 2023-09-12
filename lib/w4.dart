import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lib/study_lib.dart';

class W4 implements IWidgetTest {

  @override
  String get authorName => '나상원';

  @override
  StatefulWidget createWidget(BuildContext context, Key key) {
    return W4Widget( key : key );
  }
}

class W4Widget extends StatefulWidget {
  const W4Widget({super.key});

  @override
  State<W4Widget> createState() => _W4WidgetState();
}

class _W4WidgetState extends State<W4Widget> {
  int imgIndex = 0;
  List<String> urls = [
    'https://pbs.twimg.com/media/EaZKblhXkAAQXlv?format=jpg&name=large',
    'https://staticg.sportskeeda.com/editor/2022/09/2d7d0-16629611792986.png?w=840',
    'https://qph.cf2.quoracdn.net/main-qimg-66c4e9c6a4c584eed08d14c588e045d4-lq',
    'https://static1.cbrimages.com/wordpress/wp-content/uploads/2021/04/Luffy-Activates-Gear-Fourth.jpg',
    'https://i0.wp.com/www.spielanime.com/wp-content/uploads/2023/08/Do-Joyboy-or-Sun-God-Nika-take-over-Luffys-body-and-mind-when-he-is-using-Gear-5.png',
  ];
  List<String> names = [
    'Normal',
    'Gear 2',
    'Gear 3',
    'Gear 4',
    'Gear 5'
  ];

  @override
  Widget build(BuildContext context) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2,
          margin: const EdgeInsets.only(bottom: 20),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds:  500),
            child: 
              Image.network(
                urls[imgIndex],
                key: ValueKey<String>(urls[imgIndex]),
                fit: BoxFit.fill,
              )
          ),
        ),
        Text(
          names[imgIndex],
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                imgIndex = imgIndex >= urls.length - 1 ? 0 : imgIndex + 1;
              });
            },
            child: Container (
              // width: MediaQuery.of(context).size.width / 4,
              // height: 50,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              decoration: BoxDecoration (
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(
                '각성',
                style: TextStyle( color: Colors.white, fontWeight: FontWeight.w200)
              )
            ),
            
          ),
        )
      ]
    );
  }
}