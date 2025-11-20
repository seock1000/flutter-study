import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /**
   * 자식 요소는 부모 요소의 제약 조건을 따릅니다.
   * Container 위젯은 기본적으로 가능한 최대 크기를 차지하려고 합니다.
   * 따라서 Container의 높이와 너비를 200.0으로 설정해도
   * 부모 요소가 허용하는 크기 내에서만 적용됩니다.
   * Scaffold 위젯은 화면 전체를 차지하므로, Container는 200x200 크기로 표시됩니다.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200.0,
          width: 200.0,
          color: Colors.red,
          /**
           * 자식 위젯이 어디에 정렬되어야 하는지 명확히 지정되지 않으면, 자식 위젯의 크기는 무시된다.(어따 두라고...?)
           * 따라서, 아래의 경우에는 부모 위젯의 전체가 파란색으로 채워지게 된다.
           */
          // child: Container(
          //   height: 50.0,
          //   width: 50.0,
          //   color: Colors.blue,
          // ),
          /**
           * Column, Row, Center 등 정렬 위젯을 사용하여 자식 위젯의 위치를 지정할 수 있다.
           * 위치를 명확히 지정하면 자식 위젯의 크기가 올바르게 적용된다.
           */
          // child: Center(
          //   child: Container(
          //     height: 50.0,
          //     width: 50.0,
          //     color: Colors.blue,
          //   ),
          // ),
          // Align 위젯을 사용하여 자식 위젯의 위치를 지정할 수도 있다.
          // Alignment: center, topLeft, bottomRight 등 다양한 위치 지정이 가능하다.
          // Alignment(x, y): x와 y는 -1.0에서 1.0 사이의 값으로 지정할 수 있다. 세부적으로 조정 가능.
          child: Align(
            alignment: Alignment(0.5, -0.5), // topLeft
            child: Container(
              height: 50.0,
              width: 50.0,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
