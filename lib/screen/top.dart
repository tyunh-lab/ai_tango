//トップ画面のUIです。
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programing_contest/screen/exam.dart';
import 'package:programing_contest/screen/snow.dart';
import 'package:programing_contest/tool/color.dart';

// ignore: camel_case_types
class topPage extends StatefulWidget {
  const topPage({super.key});
  @override
  State<topPage> createState() => _topPageState();
}

// ignore: camel_case_types
class _topPageState extends State<topPage> {
  bool isSnow = false;
  @override
  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 200)),
                    Text("単語アプリ",
                        style: TextStyle(
                            color: setTextColor(context), fontSize: 28)),
                    const Padding(padding: EdgeInsets.only(top: 200)),
                    SizedBox(
                      width: size.width * 0.8,
                      child: CupertinoButton(
                        color: setPraimryBackgroundColor(context),
                        child: const Text("始める"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const examPage()));
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    /*  Container(
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: setPraimryBackgroundColor(context),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                setTextColor(context)),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                          ),
                          onPressed: () async {
                            Future() {
                              wordsSetup();
                              const Duration(milliseconds: 250);
                            }

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const reexamPage()));
                          },
                          child: Text(
                            "おすすめの問題を始める",
                            style: TextStyle(color: setTextColor(context)),
                          )),
                    ),
                    TextButton(
                      child: const Text("リセット"),
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        SharedPreferences.setMockInitialValues({});
                      },
                    )*/
                  ])),
        ]));
  }
}
