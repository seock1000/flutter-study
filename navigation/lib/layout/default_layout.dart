import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  // children의 정의 형석: List<Widget>
  final List<Widget> children;
  final String title;

  const DefaultLayout({
    required this.children,
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar 사용시 Route Stack에 내역이 있으면 자동으로 back 버튼이 생성됨
      appBar: AppBar(
        title: Text(title),
      ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
            ),
        ),
    );
  }
}
