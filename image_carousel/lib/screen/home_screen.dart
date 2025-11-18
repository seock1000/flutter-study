import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 3),
        (timer) {
          // 현재 페이지 번호 가져오기
          int curPage = controller.page!.toInt();
          // 다음 페이지
          int nextPage = curPage == 4 ? 0 : curPage + 1;
          // 다음 페이지로 이동
          controller.animateToPage(
            nextPage,
            // duration: 페이지가 움직이는 속도
            duration: Duration(milliseconds: 500),
            // curve: 애니메이션 효과, Curves 클래스에서 다양한 효과 제공, linear은 일정한 속도로 이동
            curve: Curves.linear,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PageView: 자식요소를 page로 넘어가도록 구성하는 위젯
      body: PageView(
        children: [1, 2, 3, 4, 5]
            // fit: BoxFit.cover -> 이미지가 위젯의 크기에 맞게 꽉 차도록 설정, 넘치는 부분은 잘림
            .map((e) => Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover))
            .toList(),
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    // 앱이 종료될 때, 컨트롤러 삭제 및 타이머 해제
    // dispose를 제대로 안하면 메모리 누수가 발생하여 앱 다운 등 문제가 발생할 수 있음
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }
}
