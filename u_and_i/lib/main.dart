import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      // 자주 사용하는 스타일 테마 적용
      // textTheme: 텍스트의 기본 스타일 지정
      theme: ThemeData(
        // 기본 폰트 설정
        fontFamily: 'sunflower',
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 80.0,
            fontFamily: 'parisienne',
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 50.0,
            fontWeight: FontWeight.w700,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          )
        )
      ),
      home: HomeScreen(),
    )
  );
}