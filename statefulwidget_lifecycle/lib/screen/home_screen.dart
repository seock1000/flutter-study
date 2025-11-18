import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key}) {
    print('1) HomeScreen - constructor');
  }

  @override
  State<HomeScreen> createState() {
    print('2) HomeScreen - createState');
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  Color color = Colors.red;

  @override
  void initState() {
    print('3) _HomeScreenState - initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('4) _HomeScreenState - didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('5) _HomeScreenState - build');
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // show가 true면 TestWidget을 보여주고, false면 숨깁니다.
            show? GestureDetector(
              onTap: () {
                setState(() {
                  color = color == Colors.red ? Colors.blue : Colors.red;
                });
              },
              child: TestWidget(
                color: color,
              ),
            )
            :
            SizedBox(
              width: 50.0,
              height: 50.0,
            ),
            SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
                onPressed: () {
                  // setState를 호출하여 show의 값을 반전시킵니다.
                  setState(() {
                    show = !show;
                  });
                  },
                child: Text(show ? '숨기기' : '보이기'),
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  void deactivate() {
    print('6) _HomeScreenState - deactivate');
    super.deactivate();
  }
  
  @override
  void dispose() {
    print('7) _HomeScreenState - dispose');
    super.dispose();
  }
}

class TestWidget extends StatefulWidget {
  final Color color;
  TestWidget({
    super.key,
    required this.color
  }) {
    print('A) TestWidget - constructor');
  }

  @override
  State<TestWidget> createState()  {
    print('B) TestWidget - createState');
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<TestWidget> {

  @override
  void initState() {
    print('C) _TestWidgetState - initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('D) _TestWidgetState - build');
    // GestureDetector: child 요소의 gesture를 감지합니다.
    // 여러가지 파라미터 존재
    // onTap: child 요소가 tap 되었을 때 호출되는 콜백 함수
    // return GestureDetector(
    //   onTap: () {
    //     setState(() {
    //       color = color == Colors.red ? Colors.blue : Colors.red;
    //     });
    //   },
    //   child: Container(
    //     color: color,
    //     width: 50.0,
    //     height: 50.0,
    //   ),
    // );
    return Container(
      // widget: State 클래스에서 widget 프로퍼티를 통해 상위 위젯에 접근 가능
      color: widget.color,
      width: 50.0,
      height: 50.0,
    );
  }

  @override
  void deactivate() {
    print('E) _TestWidgetState - deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('F) _TestWidgetState - dispose');
    super.dispose();
  }
}

