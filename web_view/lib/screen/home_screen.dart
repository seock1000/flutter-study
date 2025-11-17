import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Add this import for WebView

/**
 * WebViewWidget
 * - 웹 뷰를 표시하는 위젯
 * - controller: WebViewController 인스턴스를 전달받아 웹 페이지를 로드하고 표시, 필수 파라미터
 */
final homeUrl = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  // web view controller 인스턴스화
  // controller: 입력된 위젯을 제어하는 역할
  // ..: .은 함수를 실행한 결과를 반환하는 반면, 함수를 실행한 후에 다시 controller 객체를 반환
  // controller = WebViewController(); controller.loadRequest(homeUrl); 와 동일
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted) // setJavaScriptMode: 자바스크립트 실행 모드 설정, 안드로이드는 기본적으로 자바스크립트 비활성화
    ..loadRequest(homeUrl); // loadRequest: 지정된 URL로 웹 페이지를 로드

  HomeScreen({super.key});

  /**
   * appBar
   * - 앱의 상단 바를 정의
   * - actions: 앱 바의 오른쪽에 표시되는 위젯 목록
   *    - IconButton: 아이콘 버튼 위젯
   *      - onPressed: 버튼이 눌렸을 때 실행되는 콜백 함수
   *      - icon: 버튼에 표시되는 아이콘(Icons: Flutter에서 제공하는 아이콘 모음)
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Web View App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                print('pressed');
                controller.loadRequest(homeUrl); // 홈 아이콘 클릭 시 홈 URL 로드
              },
              icon: Icon(
                Icons.home,
              ),
          )
        ]
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
