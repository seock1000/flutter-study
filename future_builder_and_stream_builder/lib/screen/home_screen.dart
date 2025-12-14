import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AsyncSnapshot(future)의 상태가 변경될 때마다 builder가 재실행 된다.
      /// connectionState에 따라 로딩중, 완료, 에러 등을 처리할 수 있다.
      /// ConnectionState.none : Future 또는 Stream이 입력되지 않은 상태
      /// ConnectionState.waiting : 실행중, Future 또는 Stream이 완료되지 않았을 때
      /// ConnectionState.active : Stream에만 존재, Stream이 아직 실행 중일 때
      /// ConnectionState.done : Future 또는 Stream이 완료되었을 때
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder(
            future: getNumber(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              /// error 확인
              if (snapshot.hasError) {
                return Center(child: Text('에러가 발생했습니다: ${snapshot.error}'));
              }

              // future 대기중 일때 로딩 효과
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }

              /// 데이터 존재 확인
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Center(child: Text(data.toString()));
              }

              /// 데이터가 없으면 데이터가 없습니다 표시
              return Center(child: Text('데이터가 없습니다.'));
            },
          ),
          SizedBox(height: 50.0),
          StreamBuilder(
            stream: streamNumbers(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              /// error 확인
              if (snapshot.hasError) {
                return Center(child: Text('에러가 발생했습니다: ${snapshot.error}'));
              }

              // stream이 열려있고 데이터가 있을때 로딩 효과
              if (snapshot.connectionState == ConnectionState.active) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16.0),
                    Text(snapshot.data.toString()),
                  ],
                );
              }

              /// 데이터 존재 확인
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Center(child: Text(data.toString()));
              }

              /// 데이터가 없으면 데이터가 없습니다 표시
              return Center(child: Text('데이터가 없습니다.'));
            },
          ),
        ],
      ),
    );
  }

  // FutureBuilder 사용을 위해 Future를 반환하는 함수 생성
  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 3));

    final random = Random();

    // throw '에러!!!!!!!!!';
    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }
}
