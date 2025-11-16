import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}

// StatelessWidget
// 상태가 없는 위젯, 변경 불가능한 속성을 가짐
// build 메서드 오버라이드 필요
// stless: 단축어(sout 같음)
class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // HEX 적용: #1A1A1A, 0xFF: 불투명도
      backgroundColor: Color(0xFF1A1A1A),
      // Column: children의 요소를 수직 정렬, logo 이미지와 로딩바를 세로로 배치해야 하므로
      body: Padding(
        // EdgeInsets: 위젯의 패딩을 설정
        // symmetric: 수평(좌, 우) 및 수직(상, 하) 패딩을 동일한 값으로 설정
        padding: EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 14.0,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image 생성자: asset(asset에서 로드), file(파일 시스템에서 로드), memory(메모리에서 로드), network(네트워크에서 로드)
              Image.asset('asset/img/logo.png'),
              // SizedBox: 고정된 크기의 박스 생성, 위젯 사이에 공간을 추가할 때 사용, padding과 유사한 역할이나 가독성 향상
              SizedBox(height: 28.0),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ]
        ),
      ),
    );
  }
}
