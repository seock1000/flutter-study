import 'package:flutter/material.dart';

// flutter package에서 material.dart 파일을 import
// material.dart 파일은 Flutter에서 제공하는 다양한 UI 컴포넌트와 테마를 포함하고 있음, 대부분의 Flutter 소스에서 사용됨

// main.dart: 앱의 진입점(entry point) 역할을 하는 파일
// main() 함수: Dart 프로그램의 시작점
void main() {
  // runApp() 함수: Flutter 프레임워크에 앱의 루트 위젯을 전달하여 앱 실행을 시작
  // 루트 위젯: 앱의 최상위 위젯, 일반적으로 MaterialApp 또는 CupertinoApp 위젯
  runApp(
    // MetrialApp은 항상 최상위에 위치, (Metrial Design 스타일을 따르는 앱을 만들기 위해 사용)
    // Scaffold는 MaterialApp 다음에 위치, (앱의 기본적인 시각적 레이아웃 구조를 제공)
    // Widget: 앱의 UI를 구성하는 기본 단위, MetrialApp, Scaffold는 StatefulWidget을 상속 --> 화면에 뭔가를 보여주는 것은 모두 Widget
    MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Hello, world!',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
