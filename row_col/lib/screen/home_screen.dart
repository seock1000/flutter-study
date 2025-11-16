import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:row_col/const/colors.dart';

/**
 * MainAxisAlignment: 주축 정렬, Column의 경우 수직축, Row의 경우 수평축
 * - start: 시작부터 정렬(default)
 * - end: 끝부터 정렬
 * - center: 가운데 정렬
 * - spaceBetween: 위젯들 사이에 동일한 간격 부여, 양 끝은 제외
 * - spaceAround: 위젯들 주위에 동일한 간격 부여, 양 끝에도 간격 존재, 따라서 위젯이 만나는 구간은 끝에 비해 2배의 간격
 * - spaceEvenly: 위젯들 사이와 양 끝에 동일한 간격 부여
 * MainAxisSize: 주축에서의 크기
 * - max: 가능한 최대 크기(default)
 * - min: 가능한 최소 크기
 * CrossAxisAlignment: 교차축 정렬, Column의 경우 수평축, Row의 경우 수직축
 * - start: 시작부터 정렬
 * - end: 끝부터 정렬
 * - center: 가운데 정렬(default)
 * - stretch: 교차축을 꽉 채움
 * - baseline: 텍스트의 기준선에 맞춤
 */
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SafeArea: 화면의 안전한 영역을 잡아주는 위젯(베젤에 가리지 않도록), 일반적으로 Scaffold의 body에 사용
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: double.infinity,
          child: Column(
            // children: colors
            //     .map((e) => Container(height: 50.0, width: 50.0, color: e))
            //     .toList(),
            // children: [
            //   // Expanded: 남은 공간을 모두 차지하는 위젯, 자식 위젯에게까지 영향을 미침
            //   Expanded(
            //       // flex: 2: 기본값은 1, flex 값이 클수록 더 많은 공간을 차지(남는 공간을 차지하는 비율)
            //       flex: 2,
            //       child: Container(height: 50.0, width: 50.0, color: Colors.red)
            //   ),
            //   Expanded(
            //       flex: 3,
            //       child: Container(height: 50.0, width: 50.0, color: Colors.orange)
            //   ),
            //   Expanded(
            //       flex: 1,
            //       child: Container(height: 50.0, width: 50.0, color: Colors.yellow)
            //   ),
            // ],
            children: [
              // Expanded: 남은 공간을 모두 차지하는 위젯, 자식 위젯에게까지 영향을 미침
              Flexible(
                  // fit: 자식 공간이 남는공간을 차지하는 형식
                  // FlexFit.loose: 자식 위젯이 원하는 크기만큼만 차지
                  // FlexFit.tight: 남는 공간을 모두 차지, Expanded와 동일
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(height: 50.0, width: 50.0, color: Colors.red)
              ),
              Expanded(
                  flex: 3,
                  child: Container(height: 50.0, width: 50.0, color: Colors.orange)
              ),
              Expanded(
                  flex: 1,
                  child: Container(height: 50.0, width: 50.0, color: Colors.yellow)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
