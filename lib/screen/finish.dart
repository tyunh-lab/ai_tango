//何問正解か表示させるUIです。
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:programing_contest/screen/top.dart';
import 'package:programing_contest/tool/color.dart';

// ignore: camel_case_types
class finishPage extends StatefulWidget {
  final int check;//正答数
  const finishPage({Key? key, required, required this.check}) : super(key: key);
  @override
  State<finishPage> createState() => _finishPageState();
}

// ignore: camel_case_types
class _finishPageState extends State<finishPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            color: setBackgroundColor(context),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  "8問中${widget.check}問正解",
                  style: TextStyle(color: setTextColor(context), fontSize: 30),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                CupertinoButton(
                  color: setPraimryBackgroundColor(context),
                  child: const Text("TOPに戻る"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const topPage()));
                  },
                ),
                const Spacer()
              ],
            )));
  }
}
