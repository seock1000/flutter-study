import 'package:flutter/material.dart';
import 'package:web_view/screen/home_screen.dart';

void main() {
  // Flutter 프레임워크가 실행 준비가 될때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      MaterialApp(
          home: HomeScreen(),
      ),
  );
}