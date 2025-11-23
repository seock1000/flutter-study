import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route3_screen.dart';

class Route2Screen extends StatelessWidget {
  const Route2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute를 통해 RouteSettings로 넘어온 argument 추출
    final arguments = ModalRoute.of(context)?.settings.arguments;
    return DefaultLayout(
      title: 'Route2Screen',
      children: [
        Text(arguments.toString(), textAlign: TextAlign.center),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'),
        ),
        OutlinedButton(
          onPressed: () {
            /// Declarative Navigation
            /// main.dart에 정의된 named route로 이동
            Navigator.of(context).pushNamed(
                '/three',
                /// RouteSettings를 통해 argument 편리하게 전달
                arguments: 999
            );
          },
          child: Text('push Route3'),
        ),
        // pushReplacement: 현재 화면을 없애고 새로운 화면으로 대체
        // push flow: Route1Screen -> Route2Screen -> Route3Screen -> pop -> Route2Screen
        // pushReplacement flow: Route1Screen -> Route2Screen -> Route3Screen -> pop -> Route1Screen
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Route3Screen();
                  },
                ),
              );
            },
            child: Text('Push Replacement')
        ),
        // pushReplacementNamed: pushReplacement의 named route 버전, 사용방법은 동일
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                '/three',
                arguments: 999,
              );
            },
            child: Text('Push Replacement Named')
        ),
        // pushNamedAndRemoveUntil: 특정 조건까지 쌓여있는 라우트를 모두 제거하고 새로운 라우트로 이동
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/three',
                (route) {
                  // Route Stack에서 삭제할거면 false, 남길거면 true 반환
                  // false로 두면 앱 터짐
                  // return false;
                  // home 말고 다 삭저하는 경우
                  // return route.settings.name == '/';
                  // return route.isFirst;

                  // /one route엔 적용 안됨, named route로 라우팅을 안했기 때문에 null이 나옴
                  return route.isFirst || route.settings.name == '/one';
                },
                arguments: 999,
              );
            },
            child: Text('Push Named And Remove Until')
        ),
      ],
    );
  }
}
