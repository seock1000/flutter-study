import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_to_image.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({
    required this.maxNumber,
    super.key
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  initState() {
    super.initState();
    // property 초기화 때 widget값 사용이 불가능하기 때문에 initState에서 초기화
    maxNumber = widget.maxNumber.toDouble();
  }

  onSliderChanged(double value) {
    setState(() {
      maxNumber = value;
    });
  }

  onButtonPressed() {
    // 현재 화면을 종료하고 이전 화면으로 돌아감
    // stack 구조에서 pop 역할
    // push한 곳에 result 값을 전달할 수 있음
    Navigator.of(context).pop(maxNumber.toInt());
  }

  @override
  Widget build(BuildContext context) {
    // 새로운 root sreen이기 때문에 Scaffold 위젯을 사용
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Number(maxNumber: maxNumber),
              _Slider(value: maxNumber, onChanged: onSliderChanged),
              _Button(onPressed: onButtonPressed),
            ],
          ),
        ),
      ),
    );
  }
}

class _Number extends StatelessWidget {
  final double maxNumber;

  const _Number({required this.maxNumber, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: NumberToImage(number: maxNumber.toInt()));
  }
}

class _Slider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const _Slider({required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      max: 100000,
      min: 1000,
      // 슬라이더를 사용할 수 있을 때의 색깔 지정
      activeColor: redColor,
      onChanged: onChanged,
    );
  }
}

class _Button extends StatelessWidget {
  final VoidCallback onPressed;

  const _Button({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('저장'),
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
