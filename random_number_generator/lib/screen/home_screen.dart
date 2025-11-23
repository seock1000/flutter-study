import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_to_image.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [123, 456, 789];
  int maxNumber = 1000;

  void generateRandomNumbers() {
    final rand = Random();
    final List<int> newNumbers = [];
    while(newNumbers.length < 3) {
      newNumbers.add(rand.nextInt(maxNumber));
    }

    setState(() {
      numbers = newNumbers;
    });
  }

  void onSettingIconPressed() async {
    // context는 전역적으로 접근 가능
    // await로 result 값을 받을 수 있음
    final result = await Navigator.of(context).push(
      // MaterialPageRoute: 새로운 화면으로 이동할 때 사용하는 위젯
      MaterialPageRoute(
        // builder 함수는 기본적으로 BuildContext를 인자로 받음
          builder: (BuildContext context) {
            return SettingScreen(maxNumber: maxNumber,);
          },
      ),
    );

    // 그냥 뒤로가기 했을 경우 null이 반환될 수 있기 때문에 null 처리
    maxNumber = result ?? maxNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(onPressed: onSettingIconPressed,),
              _Body(numbers: numbers,),
              _Footer(onPressed: generateRandomNumbers),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤 숫자 생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.settings, color: Colors.red),
        ),
      ],
    );
    ;
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;

  const _Body({
    required this.numbers,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers
            .map((e) => NumberToImage(number: e))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        // foregroundColor: background 위에 덮어지는 색깔 설정
        foregroundColor: Colors.white,
      ),
      child: Text('생성하기!'),
    );
  }
}
