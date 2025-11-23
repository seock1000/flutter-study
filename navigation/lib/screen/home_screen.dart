import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route1_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'HomeScreen',
      children: [
        OutlinedButton(
          onPressed: () async {
            // push 버튼 누르면 Route1Screen으로 이동
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Route1Screen(number: 20);
                },
              ),
            );

            print(result);
          },
          child: Text('push'),
        ),
        // pop하는 경우 라우트 스택에 아무것도 없으므로 앱이 죽음
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'),
        ),
        // maybePop하는 경우 라우트 스택에 아무것도 없으면 아무 동작도 하지 않음
        // 안전하게 pop하고 싶을 때 사용
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          child: Text('maybe pop'),
        ),
        // canPop: 현재 라우트 스택에 pop할 수 있는 화면이 있는지 여부 반환
        OutlinedButton(
          onPressed: () {
            print(Navigator.of(context).canPop());
          },
          child: Text('can pop'),
        ),
      ],
    );
  }
}
