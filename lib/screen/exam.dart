//問題を出すUIです。
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:programing_contest/screen/finish.dart';
import 'package:programing_contest/screen/save.dart';
import 'package:programing_contest/screen/snow.dart';
import 'package:programing_contest/screen/top.dart';
import 'package:programing_contest/tool/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class examPage extends StatefulWidget {
  const examPage({Key? key, required}) : super(key: key);
  @override
  State<examPage> createState() => _examPageState();
}

// ignore: camel_case_types
class _examPageState extends State<examPage> {
  String examText = "問題文";//問題文
  List<String> an = ["回答1", "回答2", "回答3", "回答4"];//回答欄
  int answerId = 0;//答えのID 0~3
  int answerIndex = 0;//save.dart内にある配列の通し番号
  int eIndex = 1;//何問目かの記録
  List allEnglish = [];//すべての英語の単語
  List allJapanese = [];//すべての日本語の単語
  int i0 = 0; //問題のリストID
  int i1 = 0;
  int i2 = 0;
  String ja0 = ""; //日本語の答え間違えた時に表示される
  String ja1 = "";
  String ja2 = "";
  bool isTouch = true; //連打防止
  int right = 0; //正答数
  bool isFirst = true; //初めての回答かどうか

  @override
  void initState() {//初期化処理
    super.initState();
    setup();
    setTest();
    Future(() async {
      await tts.setSpeechRate(0.6);
    });
  }

  void setup() async {//配列が空になるのを防止する
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("Issetuped") ?? false != true) {
      wordsSetup();
    }
  }

  void setTest() async {//問題の作成
    index0 = const Color.fromARGB(255, 44, 44, 45);
    index1 = const Color.fromARGB(255, 44, 44, 45);
    index2 = const Color.fromARGB(255, 44, 44, 45);
    index3 = const Color.fromARGB(255, 44, 44, 45);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      allEnglish = prefs.getStringList("english") ?? [];
      allJapanese = prefs.getStringList("japanese") ?? [];
      if (allEnglish.isNotEmpty) {
        answerId = randomIntWithRange(0, 3);
        answerIndex = randomIntWithRange(0, 505);
        setState(() {
          an[answerId] = allEnglish[answerIndex];
          examText = (prefs.getStringList("japanese")!.toList()[answerIndex]);
        });
        i0 = randomIntWithRange(0, 504);
        i1 = randomIntWithRange(0, 503);
        i2 = randomIntWithRange(0, 502);
        allEnglish.removeAt(answerIndex); //同じ単語のダブりを消すため.
        allJapanese.removeAt(answerIndex);

        switch (answerId) {
          case 0:
            setState(() {
              an[1] = allEnglish[i0];
              ja0 = allJapanese[i0];
              allEnglish.removeAt(i0);
              allJapanese.removeAt(i0);
              an[2] = allEnglish[i1];
              ja1 = allJapanese[i1];
              allEnglish.removeAt(i1);
              allJapanese.removeAt(i1);
              an[3] = allEnglish[i2];
              ja2 = allJapanese[i2];
            });
            break;
          case 1:
            setState(() {
              an[0] = allEnglish[i0];
              ja0 = allJapanese[i0];
              allEnglish.removeAt(i0);
              allJapanese.removeAt(i0);
              an[2] = allEnglish[i1];
              ja1 = allJapanese[i2];
              allEnglish.removeAt(i1);
              allJapanese.removeAt(i1);
              an[3] = allEnglish[i2];
              ja2 = allJapanese[i2];
            });
            break;
          case 2:
            setState(() {
              an[0] = allEnglish[i0];
              ja0 = allJapanese[i0];
              allEnglish.removeAt(i0);
              allJapanese.removeAt(i0);
              an[1] = allEnglish[i1];
              ja1 = allJapanese[i1];
              allEnglish.removeAt(i1);
              allJapanese.removeAt(i1);
              an[3] = allEnglish[i2];
              ja2 = allJapanese[i2];
            });
            break;
          case 3:
            setState(() {
              an[0] = allEnglish[i0];
              ja0 = allJapanese[i0];
              allEnglish.removeAt(i0);
              allJapanese.removeAt(i0);
              an[1] = allEnglish[i1];
              ja1 = allJapanese[i1];
              allEnglish.removeAt(i1);
              allJapanese.removeAt(i1);
              an[2] = allEnglish[i2];
              ja2 = allJapanese[i2];
            });
            break;
        }
      }
    });
  }

  int randomIntWithRange(int min, int max) {//乱数生成
    int value = math.Random().nextInt(max - min);
    return value + min;
  }

  final FlutterTts tts = FlutterTts();

  void nextAnimation() async {//次の問題までのアニメーションコントローラ
    await tts.speak(an[answerId]);
    if (isFirst) {
      right++;
    }
    isFirst = true;
    if (eIndex <= 8) {
      isTouch = false;  
      await Future.delayed(const Duration(seconds: 1));
      setTest();
      isTouch = true;
    } else {
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => finishPage(check: right)));
    }
  }

  Color index0 = const Color.fromARGB(255, 44, 44, 45);//回答欄の背景色
  Color index1 = const Color.fromARGB(255, 44, 44, 45);
  Color index2 = const Color.fromARGB(255, 44, 44, 45);
  Color index3 = const Color.fromARGB(255, 44, 44, 45);

  @override
  Widget build(BuildContext context) {//UI生成
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: setBackgroundColor(context),
        body: Stack(children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: SnowWidget(
              isRunning: true,
              totalSnow: 150,
              speed: 0.5,
            ),
          ),
          Container(
              height: size.height,
              width: size.width,
              //color: setBackgroundColor(context),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: setTextColor(context),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const topPage()));
                          },
                        )
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: size.width * 0.8),
                        child: Text(
                          "${eIndex.toString()}/8問",
                          style: TextStyle(
                              fontSize: 18, color: setTextColor(context)),
                        )),
                    const Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            color: setPraimryBackgroundColor(context),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        width: size.width / 2,
                        child: Center(
                            child: Text(examText,
                                style: TextStyle(
                                    color: setTextColor(context),
                                    fontSize: 32)))),
                    const Spacer(flex: 2),
                    AnimatedContainer(
                        height: 40,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            color: index0,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                setTextColor(context)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: !isTouch
                              ? null
                              : () async {
                                  if (answerId == 0) {
                                    setState(() {
                                      index0 = Colors.green;
                                      eIndex++;
                                    });
                                    nextAnimation();
                                  } else {
                                    await tts.speak(an[0]);
                                    isFirst = false;
                                    wordsSave(an[0], ja0);
                                    setState(() {
                                      index0 = Colors.red;
                                      an[0] = ja0;
                                    });
                                  }
                                },
                          child: Text(an[0],
                              style: TextStyle(
                                  color: setTextColor(context), fontSize: 22)),
                        )),
                    const Padding(padding: EdgeInsets.all(8)),
                    AnimatedContainer(
                        height: 40,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            color: index1,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                setTextColor(context)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: !isTouch
                              ? null
                              : () async {
                                  if (answerId == 1) {
                                    setState(() {
                                      index1 = Colors.green;
                                      eIndex++;
                                    });
                                    nextAnimation();
                                  } else {
                                    await tts.speak(an[1]);

                                    isFirst = false;
                                    setState(() {
                                      index1 = Colors.red;
                                    });
                                    if (answerId == 0) {
                                      wordsSave(an[1], ja0);
                                      setState(() {
                                        an[1] = ja0;
                                      });
                                    } else {
                                      wordsSave(an[1], ja1);
                                      setState(() {
                                        an[1] = ja1;
                                      });
                                    }
                                  }
                                },
                          child: Text(an[1],
                              style: TextStyle(
                                  color: setTextColor(context), fontSize: 22)),
                        )),
                    const Padding(padding: EdgeInsets.all(8)),
                    AnimatedContainer(
                        height: 40,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            color: index2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                setTextColor(context)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: !isTouch
                              ? null
                              : () async {
                                  if (answerId == 2) {
                                    setState(() {
                                      index2 = Colors.green;
                                      eIndex++;
                                    });
                                    nextAnimation();
                                  } else {
                                    await tts.speak(an[2]);

                                    isFirst = false;
                                    setState(() {
                                      index2 = Colors.red;
                                    });
                                    if (answerId == 0 || answerId == 1) {
                                      wordsSave(an[2], ja1);
                                      setState(() {
                                        an[2] = ja1;
                                      });
                                    } else {
                                      wordsSave(an[2], ja2);
                                      setState(() {
                                        an[2] = ja2;
                                      });
                                    }
                                  }
                                },
                          child: Text(an[2],
                              style: TextStyle(
                                  color: setTextColor(context), fontSize: 22)),
                        )),
                    const Padding(padding: EdgeInsets.all(8)),
                    AnimatedContainer(
                        height: 40,
                        width: size.width * 0.6,
                        decoration: BoxDecoration(
                            color: index3,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6))),
                        duration: const Duration(milliseconds: 500),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                setTextColor(context)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: !isTouch
                              ? null
                              : () async {
                                  if (answerId == 3) {
                                    setState(() {
                                      index3 = Colors.green;
                                      eIndex++;
                                    });
                                    nextAnimation();
                                  } else {
                                    await tts.speak(an[3]);

                                    isFirst = false;
                                    wordsSave(an[3], ja2);
                                    setState(() {
                                      index3 = Colors.red;
                                      an[3] = ja2;
                                    });
                                  }
                                },
                          child: Text(an[3],
                              style: TextStyle(
                                  color: setTextColor(context), fontSize: 22)),
                        )),
                    const Spacer(flex: 2),
                  ])),
        ]));
  }
}
