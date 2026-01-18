import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lotto/const/color.dart';
import 'package:lotto/const/scripts.dart';
import 'package:lotto/widgets/lotto_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> lottoNumbers = [0, 0, 0, 0, 0, 0];
  int scriptNumber = 0;

  void getLottoNumbers() {
    Random random = Random();
    setState(() {
      List<int> numbers = List.generate(45, (i) => i + 1)..shuffle();
      lottoNumbers = numbers.sublist(0, 6)..sort();
      scriptNumber = random.nextInt(josoangMessages.length);
    });
  }

  void resetNumbers() {
    setState(() {
      lottoNumbers = [0, 0, 0, 0, 0, 0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 이미지
            _Image(),
            SizedBox(height: 8),
            // 대사
            _Script(scriptNumber: scriptNumber),
            SizedBox(height: 8),
            // 번호들
            _Numbers(lottoNumbers: lottoNumbers),
            // 버튼
            Column(
              children: [
                LottoButton(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  onPressed: getLottoNumbers,
                  text: "번호받기",
                  textColor: Colors.white,
                ),
                SizedBox(
                  height: 12,
                ),
                LottoButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  onPressed: resetNumbers,
                  text: "초기화",
                  textColor: primaryColor,
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 64, bottom: 32),
        child: Image.asset(
          "assets/images/grandparents.png",
          width: 200,
        ),
      ),
    );
  }
}

class _Script extends StatelessWidget {
  const _Script({
    super.key,
    required this.scriptNumber,
  });

  final int scriptNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown, // 부모보다 클 때만 크기를 줄임
          child: Text(
            textAlign: TextAlign.center,
            josoangMessages[scriptNumber],
            style: TextStyle(
              fontSize: 32, // 이 크기가 최대값이 됨
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _Numbers extends StatelessWidget {
  const _Numbers({
    super.key,
    required this.lottoNumbers,
  });

  final List<int> lottoNumbers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        children: lottoNumbers.map(
          (e) {
            Color color = primaryColor;
            if (e / 10 >= 4) {
              color = fortiethColor;
            } else if (e / 10 >= 3) {
              color = thirtiethColor;
            } else if (e / 10 >= 2) {
              color = twentiethColor;
            } else if (e / 10 >= 1) {
              color = tenthColor;
            } else {
              color = primaryColor;
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                alignment: AlignmentGeometry.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  e.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
