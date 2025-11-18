import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TestWidget(),
    );
  }
}

/**
 * StatelessWidget의 생명주기
 * 생성자 -> build 순서로 실행
 */
class TestWidget extends StatelessWidget {
  TestWidget({super.key}) {
    print('TestWidget: Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('TestWidget: build');

    return Container(
      color: Colors.amber,
      width: 50.0,
      height: 50.0,
    );
  }
}

