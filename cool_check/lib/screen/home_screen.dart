import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Camera position: 원하는 위치 지정
  final CameraPosition initialPosition = CameraPosition(
    // latitude, longitude
    target: LatLng(37.5214, 126.9246),
    zoom: 17,
  );
  bool coolCheckDone = false;
  bool canCoolCheck = false;

  final double okDistance = 100;

  late final GoogleMapController googleMapController;

  @override
  initState() {
    super.initState();

    // getPositionStream(): 위치 변경을 listening하여 실시간으로 스트리밍
    Geolocator.getPositionStream().listen((event) {
      final start = LatLng(
        37.5214,
        126.9246,
      );
      final end = LatLng(
        event.latitude,
        event.longitude,
      );

      final distance = Geolocator.distanceBetween(start.latitude, start.longitude, end.latitude, end.longitude);
      setState(() {
        if(okDistance > distance) {
          canCoolCheck = true;
        } else {
          canCoolCheck = false;
        }
      });
    });
  }

  // 위치권한을 체크하는 메서드
  checkPermission() async {
    /// Geolocator.isLocationServiceEnabled(): 위치 서비스가 활성화되어 있는지 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw Exception('위치 기능을 활성화 해주세요.');
    }

    /// Geolocator.checkPermission(): 현재 위치 권한 상태 확인
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    /// LocationPermission
    /// - denied: 거부됨(최초 상태)
    /// - deniedForever: 영구 거부됨(설정에서 변경 필요, 아이폰/안드로이드 등에서 한번 거절하면 영구 거절로 설정, 사용자가 직접 설정에서 바꿔야함)
    /// - whileInUse: 앱 사용 중 허용
    /// - always: 항상 허용
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
    }

    if (checkedPermission != LocationPermission.always &&
        checkedPermission != LocationPermission.whileInUse) {
      throw Exception('위치 권한을 허가 해주세요.');
    }
  }

  myLocationPressed() async {
    // 현재 위치 가져오기
    final location = await Geolocator.getCurrentPosition();
    // 구글 맵 카메라를 현재 위치로 이동
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(location.latitude, location.longitude)),
    );
  }

  onCoolCheckPressed() async {
    final result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('출근하기'),
            content: Text('출근 하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: (){
                    // 다이어그램은 하나의 페이지로 처리 pop
                    Navigator.of(context).pop(true);
                  },
                  child: Text('승인'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: Text('취소'),
              ),
            ]
          );
        }
    );

    if(result) {
      setState(() {
        coolCheckDone = true;
      });
    }
  }

  onGoogleMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '오늘도 출근',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: myLocationPressed,
            icon: Icon(Icons.my_location),
          ),
        ],
      ),
      // futureBuilder: 비동기 작업의 상태에 따라 다른 위젯을 렌더링, async 메서드가 아닌 builder를 async하게 처리
      // future: 실행할 비동기 함수
      // builder: 비동기 작업의 상태에 따라 렌더링할 위젯을 정의
      body: FutureBuilder(
        // 실행할 비동기 함수
        future: checkPermission(),
        // 비동기 작업의 상태에 따라 렌더링할 위젯 정의
        // AsyncSnapshot: 비동기 작업의 현재 상태와 데이터를 포함
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 에러가 나면 에러 메시지 출력
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return Stack(
            children: [
              _GoogleMap(
                onMapCreated: onGoogleMapCreated,
                initialCameraPosition: initialPosition,
                radius: okDistance,
                canCoolCheck: canCoolCheck,
              ),
              _FloatingButton(
                  coolCheckDone: coolCheckDone,
                  canCoolCheck: canCoolCheck,
                  onCoolCheckPressed: onCoolCheckPressed
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GoogleMap extends StatelessWidget {
  final MapCreatedCallback onMapCreated;
  final CameraPosition initialCameraPosition;
  final double radius;
  final bool canCoolCheck;

  const _GoogleMap({
    required this.onMapCreated,
    required this.initialCameraPosition,
    required this.radius,
    required this.canCoolCheck,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      // 구글 맵이 생성되었을 때 호출되는 콜백
      onMapCreated: onMapCreated,
      initialCameraPosition: initialCameraPosition,
      // 지도 유형(기본, 위성 등) 설정
      mapType: MapType.normal,
      // 내 위치 표시
      myLocationEnabled: true,
      // 내 위치로 가기 버튼(기본이 못생겨서 생략)
      myLocationButtonEnabled: false,
      // 확대/축소 버튼
      zoomControlsEnabled: false,
      markers: {
        // 위치 표시 마커, 별도 디자인 추가 안하면 빨간색 기본 마커
        Marker(
          markerId: MarkerId('123'),
          position: LatLng(37.5214, 126.9246),
        ),
      },
      circles: {
        // 위치 표시 마커, 별도 디자인 추가 안하면 빨간색 기본 마커
        Circle(
          circleId: CircleId('isDistance'),
          center: LatLng(37.5214, 126.9246),
          radius: radius,
          // 미터 단위
          fillColor: canCoolCheck ? Colors.blue.withOpacity(0.5) : Colors.red.withOpacity(0.5),
          strokeColor: canCoolCheck ? Colors.blue : Colors.red,
          strokeWidth: 1,
        ),
      },
    );
  }
}

class _FloatingButton extends StatelessWidget {
  final bool coolCheckDone;
  final bool canCoolCheck;
  final VoidCallback onCoolCheckPressed;

  const _FloatingButton({
    required this.coolCheckDone,
    required this.canCoolCheck,
    required this.onCoolCheckPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      left: 0,
      bottom: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              coolCheckDone? Icons.check : Icons.timelapse_outlined,
              color: coolCheckDone ? Colors.green : Colors.blue,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (!coolCheckDone && canCoolCheck) ? onCoolCheckPressed : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('출근하기'),
            ),
          ],
        ),
      ),
    );
  }
}


