import 'package:flutter/material.dart';

/**
 * Padding: Container 내부 여백을 추가
 * EdgeInsets: 여백의 크기와 방향 설정
 * - all: 모든 방향에 동일한 여백 적용
 * - symmetric: 대칭, 수평(좌-우) 및 수직(위-아래) 방향에 대해 별도의 여백 설정
 *    - horizontal: 좌우 여백 설정
 *    - vertical: 상하 여백 설정
 * - only: 특정 방향에만 여백 설정
 * 예) left, top, right, bottom
 * - fromLTRB: left, top, right, bottom 순서로 여백 설정, 모든 값 전부 입력 필요
 */
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Container(
              color: Colors.red,
              child: Padding(
                // padding: EdgeInsets.all(
                //   20.0
                // ),
                // padding: EdgeInsets.symmetric(
                //   horizontal: 50.0,
                //   vertical: 10.0
                // ),
                // padding: EdgeInsets.only(
                //   left: 30.0,
                //   top: 10.0,
                //   right: 5.0,
                //   bottom: 50.0
                // ),
                padding: EdgeInsets.fromLTRB(
                  30.0,
                  10.0,
                  5.0,
                  50.0
                ),
                child: Container(
                  color: Colors.blue,
                  width: 50.0,
                  height: 50.0,
                ),
              ),
            ),
          )
      ),
    );
  }
}
