import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/**
 * 일반적인 flutter State Naming Rule
 * 1. StatefulWidget 이름과 동일하게 작성
 * 2. StatefulWidget 이름 + State
 * ex) HomeScreen -> HomeScreenState
 * 3. 언더스코어(_) 추가 -> _HomeScreenState
 */
class _HomeScreenState extends State<HomeScreen> {
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    print('build 실행');

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if(color == Colors.blue) {
                  color = Colors.red;
                } else {
                  color = Colors.blue;
                }
                print('색상변경 : $color');
                // setState: 화면을 다시 그려라! 라는 의미, build 메서드를 다시 실행
                setState((){});
              },
              child: Text(
                  '색상변경!',
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              width: 50.0,
              height: 50.0,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
