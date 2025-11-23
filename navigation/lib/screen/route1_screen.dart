import 'package:flutter/material.dart';
import 'package:navigation/layout/default_layout.dart';
import 'package:navigation/screen/route2_screen.dart';

class Route1Screen extends StatelessWidget {
  final int number;

  const Route1Screen({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // false로 설정하면 시스템 뒤로가기 버튼 / appBar의 back 버튼 모두 동작하지 않음 (default true)
      // 안드로이드에서 뒤로가기 버튼 막기 - homeScreen에서 pop 방지도 가능
      // 시스템 뒤로가기를 막아야 하는 경우에만 사용
      canPop: false,
      child: DefaultLayout(
        title: 'Route1Screen',
        children: [
          Text('argument:$number', textAlign: TextAlign.center),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(456);
            },
            child: Text('pop'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Route2Screen();
                  },
                  settings: RouteSettings(
                    arguments: 789,
                  )
                ),
              );
            },
            child: Text('push'),
          ),
          // homeScreen이 스택에 있기때문에 true 반환
          OutlinedButton(
            onPressed: () {
              print(Navigator.of(context).canPop());
            },
            child: Text('can pop'),
          ),
        ],
      ),
    );
  }
}
