import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route1_screen.dart';
import 'package:navigation/screen/route2_screen.dart';
import 'package:navigation/screen/route3_screen.dart';

/// Imperative vs Declarative Route
/// Imperative Route: 명력식 라우팅, 코드를 정의한 위치에서 직접 라우팅을 제어
/// Declarative Route: 선언식 라우팅, 미리 Route를 정의해두고 라우팅을 제어
void main() {
  runApp(MaterialApp(
    //home: HomeScreen(),
    // initialRoute: home route를 지정,
    initialRoute: '/',
    routes: {
      /// key: route 이름, value: builder, 이동하고 싶은 라우트
      /// push named 사용 가능: Navigator.of(context).pushNamed('/one');
      /// 해당 위치에 라우트 정보 중앙화 가능 (유지보수 용이)
      '/': (context) => HomeScreen(),
      '/one': (context) => Route1Screen(number: 100),
      '/two': (context) => Route2Screen(),
      '/three': (context) => Route3Screen(),
    },
  ));
}
