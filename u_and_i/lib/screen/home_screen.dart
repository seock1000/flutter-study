import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // pink 계열의 연한 색상을 배경색으로 설정, default 500
      backgroundColor: Colors.pink[100],
      // SafeArea 위젯을 사용하여 기기의 노치, 상태바, 홈 인디케이터 등을 피함, top, bottom, left, right 속성을 따로 설정 가능, default true
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          // MediaQuery를 사용하여 실행중인 전체 화면의 가로 크기를 가져옴
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              /// 텍스트
              _Top(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              /// 이미지
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    // showDialog: 안드로이드 스타일의 다이얼로그 표시
    // showCupertinoDialog: iOS 스타일의 다이얼로그 표시
    // context: 다이얼로그를 표시할 컨텍스트

    showCupertinoDialog(
      context: context,
      // barrierDismissible: 다이얼로그 외부 영역 터치 시 다이얼로그 닫힘 여부 설정, default false
      barrierDismissible: true,
      builder: (BuildContext context){
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 300.0,
            // CupertinoDatePicker: iOS 스타일의 날짜 선택 위젯
            child: CupertinoDatePicker(
              // mode: 날짜 선택 모드 설정, date, time, dateAndTime 중 선택 가능
              mode: CupertinoDatePickerMode.date,
              // dateOrder: 날짜 선택 시 연, 월, 일의 순서 설정, ymd, mdy, dmy 중 선택 가능
              dateOrder: DatePickerDateOrder.ymd,
              // initialDateTime: 초기 선택 날짜 설정, 현재 selectedDate 값으로 설정
              initialDateTime: selectedDate,
              // maximumDate: 선택 가능한 최대 날짜 설정, 현재 날짜로 설정(오늘 이후로 선택 불가)
              maximumDate: DateTime.now(),
              // onDateTimeChanged: 날짜가 변경될 때 호출되는 콜백 함수
              onDateTimeChanged: (DateTime date){
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}

// underscore: 내부에서만 사용한다는 네이밍 룰
class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPressed;

  const _Top({
    required this.selectedDate,
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Container(
        child: Column(
          children: [
            Text(
              'U&I',
              style: textTheme.displayLarge,
              ),
            Text(
              '우리 처음 만난 날',
              style: textTheme.bodyLarge,
              ),
            Text(
              '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
              style: textTheme.bodyMedium,
              ),
            IconButton(
              iconSize: 60.0,
              color: Colors.red,
              onPressed: onPressed,
              icon: Icon(Icons.favorite),
            ),
            Text(
              // difference: 두 날짜의 차이를 Duration 객체로 반환
              // inDays: Duration 객체의 일 수를 정수로 반환
              'D+${now.difference(selectedDate).inDays + 1}',
              style: textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset('asset/img/middle_image.png'),
    );
  }
}


