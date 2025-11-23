import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // flutter에서 공식적으로 제공하는 버튼 위젯 3가지
            // 모두 클릭 시 기본적인 애니메이션 효과가 적용됨

            // 테두리 및 배경 색상이 있는 버튼
            // styleForm 메서드를 통해 스타일 커스터마이징 가능
            ElevatedButton(
              onPressed: () {},
              // 버튼 비활성화 상태: null 할당
              // onPressed: null,
              style: ElevatedButton.styleFrom(
                // 버튼 배경 색상
                backgroundColor: Colors.red,
                // 비활성화 상태의 버튼 배경 색상
                disabledBackgroundColor: Colors.grey,
                // 배경 위의 색상 - 글자, splash 효과 등
                foregroundColor: Colors.white,
                // 비활성화 상태의 버튼 글자 색상
                disabledForegroundColor: Colors.red,
                // 버튼 그림자 색상
                shadowColor: Colors.green,
                // 버튼 높이
                elevation: 10.0,
                // 글자 스타일 - text에 정의하는 것과 동일하나 직관적으로 보기위해 분리
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                // 버튼 내부 여백
                padding: EdgeInsets.all(32.0),
                // BorderSide: 버튼 테두리 스타일
                side: BorderSide(color: Colors.black, width: 12.0),
                // Size(width, height): 크기 지정
                // 최소 크기 지정
                minimumSize: Size(100, 50),
                // 최대 크기 지정
                maximumSize: Size(200, 100),
                // 고정 크기 지정
                fixedSize: Size(150, 75),
              ),
              child: const Text('Elevated Button'),
            ),
            // 테두리만 있는 버튼
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
              // style: OutlinedButton.styleFrom(
              //   backgroundColor: Colors.blue,
              //   foregroundColor: Colors.white,
              //   // OutlinedButton이어도 StyleFrom 메서드를 통해 elevation 적용 가능
              //   // 결국 모든 버튼의 기본 스타일이 지정된 것이지, 불가능한 것은 아님
              //   shadowColor: Colors.pink,
              //   elevation: 10.0,
              // ),
              style: ButtonStyle(
                // MaterialStateProperty를 통해 상태별 스타일 지정 가능
                // 기존 하던 방식으로 Colors.blue와 같이 직접 색상 지정 불가
                // backgroundColor: Colors.blue,
                //
                // Material State
                // hovered: 마우스 오버 상태 - 앱에서는 의미 없음, 웹 및 데스크탑에서 사용
                // focused: 포커스 상태(텍스트 필드)
                // pressed: 눌렀을때
                // dragged: 드래그 상태
                // selected: 선택된 상태(체크박스, 라디오 버튼)
                // scrolledUnder: 다른 컴포넌트 밑으로 스크롤링 됐을때
                // disabled: 비활성화 상태
                // error: 에러 상태

                // all: 모든 상태에 동일한 스타일 적용
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                minimumSize: MaterialStateProperty.all(Size(200, 150)),
              ),
            ),
            // 배경 및 테두리 없는 버튼
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
              // resolveWith 메서드를 통해 상태별 스타일 지정 가능
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((
                  Set<MaterialState> states,
                ) {
                  // 눌렸을 때는 회색, 그 외에는 검정색
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.grey;
                  } else {
                    return Colors.black;
                  }
                }),
                foregroundColor: MaterialStateProperty.resolveWith((
                  Set<MaterialState> states,
                ) {
                  // 눌렸을 때는 검정색, 그 외에는 흰색
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black;
                  } else {
                    return Colors.white;
                  }
                }),
                minimumSize: MaterialStateProperty.resolveWith((
                  Set<MaterialState> states,
                ) {
                  // 눌렸을 때는 크기 증가, 그 외에는 기본 크기
                  if (states.contains(MaterialState.pressed)) {
                    return Size(200, 150);
                  } else {
                    return Size(150, 75);
                  }
                }),
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('OutlinedButton Shape'),
              style: OutlinedButton.styleFrom(
                // shape: 버튼 모양 커스터마이징
                // StadiumBorder: 둥근 모서리 default
                // RoundedRectangleBorder: 직사각형 모서리
                // - borderRadius 속성을 통해 모서리 둥글기 조절 가능, borderRadius: BorderRadius.circular(10.0)
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // )
                // BeveledRectangleBorder: 모서리가 깎인 직사각형
                // - borderRadius 속성을 통해 모서리 깎기 조절 가능, borderRadius: BorderRadius.circular(10.0)
                // shape: BeveledRectangleBorder(
                //   borderRadius: BorderRadius.circular(10.0),
                // ),
                // ContinuousRectangleBorder: 부드럽게 곡선 처리된 직사각형
                // - borderRadius 속성을 통해 곡선 정도 조절 가능, borderRadius: BorderRadius.circular(10.0)
                // shape: ContinuousRectangleBorder(
                //   borderRadius: BorderRadius.circular(16.0),
                // ),
                // CircleBorder: 원형
                // - eccentricity 속성(0~1)을 통해 타원형 조절 가능, eccentricity: 0.5
                shape: CircleBorder(eccentricity: 0.75),
              ),
            ),
            // Icon이 포함된 ElevatedButton
            // OutlinedButton, TextButton도 동일하게 사용 가능
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.keyboard_alt_outlined),
              label: Text('Elevated Button Icon'),
            ),
          ],
        ),
      ),
    );
  }
}
