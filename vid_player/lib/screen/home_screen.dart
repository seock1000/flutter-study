import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// plugin 이름이 video_player이므로 중복을 피하기 위해 프로젝트 vid_player로 지정

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showVideoPlayer = false;
  XFile? video;

  onLogoTap() async {
    // ImageSource 선택 가능 (camera, gallery)
    // camera: 카메라로 사진/동영상 촬영
    // gallery: 갤러리에서 사진/동영상 선택
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);

    setState(() {
      this.video = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // Gradient를 주기 위해서는 Container 위젯을 사용 필요
      body: video != null
          ? _VideoPlayer(
          video: video!,
          onAnotherVideoPicked: onLogoTap,
      )
          : _VideoSelector(onLogoTap: onLogoTap),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset('asset/img/logo.png'),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  final textStyle = const TextStyle(color: Colors.white, fontSize: 32.0);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('VIDEO', style: textStyle.copyWith(fontWeight: FontWeight.w300)),
        Text(
          'PLAYER',
          // copyWith를 사용하여 textStyle의 속성을 복사한 후 필요한 속성만 변경
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  final VoidCallback onAnotherVideoPicked;

  const _VideoPlayer({
    required this.video,
    required this.onAnotherVideoPicked,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  // late: null safety에서 변수를 나중에 초기화할 때 사용
  late VideoPlayerController videoPlayerController;
  bool showIcons = true;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  @override
  didUpdateWidget(covariant _VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // video가 oldWidget의 video와 다르면 컨트롤러 초기화
    if(oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  initializeController() async {

    try {
      await videoPlayerController.dispose(); // 이전 컨트롤러 해제
    } catch (e) {
      // 처음 실행 시에는 dispose할 컨트롤러가 없으므로 예외 발생
      // 예외 무시
    }

    // VideoPlayerController.file: 파일로부터 비디오를 재생할 수 있는 컨트롤러 생성
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path, // XFile의 path: video file의 경로
      ),
    );

    await videoPlayerController.initialize(); // 비디오 초기화
    // 비디오 컨트롤러의 상태가 변경될 때마다 호출되는 리스너 등록
    videoPlayerController.addListener(() {
      setState(() {}); // 상태 변경 시 화면 갱신
    });

    setState(() {}); // rebuild, 비디오 초기화 후 화면 갱신
  }

  onReversePressed() {
    final currentPosition =
        videoPlayerController.value.position;
    Duration position = Duration();

    if (currentPosition > Duration(seconds: 3)) {
      position = currentPosition - Duration(seconds: 3);
    } else {
      position = Duration(seconds: 0);
    }

    videoPlayerController.seekTo(position);
  }

  onPlayPressed() {
    setState(() {
      // 비디오 재생 중이면 일시정지, 일시정지 상태면 재생
      if (videoPlayerController.value.isPlaying) {
        videoPlayerController.pause();
      } else {
        videoPlayerController.play();
      }
    });
  }

  onForwardPressed() {
    final currentPosition =
        videoPlayerController.value.position;
    final maxPosition = videoPlayerController.value.duration;
    Duration position = Duration();

    if (currentPosition + Duration(seconds: 3) >
        maxPosition) {
      position = maxPosition;
    } else {
      position = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController.seekTo(position);
  }

  onSliderChanged(double val) {
    final position = Duration(seconds: val.toInt());
    videoPlayerController.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showIcons = !showIcons;
        });
      },
      child: Center(
        // AspectRatio: 자식 위젯의 가로 세로 비율을 지정
        child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          // Stack: 여러 위젯을 겹쳐서 배치, 넣은 순서대로 쌓임
          // 위치 지정하지 않을 시 기본 위치는 좌측 상단
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              // 아이콘 잘보이게하는 용도
              if(showIcons)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
              if(showIcons)
              _PlayButton(
                onReversePressed: onReversePressed,
                onPlayPressed: onPlayPressed,
                onForwardPressed: onForwardPressed,
                isPlaying: videoPlayerController.value.isPlaying,
              ),
              _Bottom(
                  position: videoPlayerController.value.position,
                  maxPosition: videoPlayerController.value.duration,
                  onSliderChanged: onSliderChanged,
                  useOpacity: !showIcons,
              ),
              if(showIcons)
              _AnotherVideo(
                  onPressed: widget.onAnotherVideoPicked,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;

  const _VideoSelector({required this.onLogoTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // RadialGradient: 원형 그라데이션
        // gradient: RadialGradient(
        //     // colors: 어느 색에서 어느 색으로 변할지 지정
        //     colors: [
        //       Colors.red,
        //       Colors.green,
        //     ],
        //     // radius: 그라데이션의 반지름 크기 지정, default 값은 0.5
        //     radius: 1.0,
        //     // center: 그라데이션의 중심 위치 지정, default 값은 Alignment.center
        //     center: Alignment.center,
        // )
        // LinearGradient: 선형 그라데이션
        gradient: LinearGradient(
          // colors: 어느 색에서 어느 색으로 변할지 지정
          colors: [Color(0xFF2A3A7C), Color(0xFF000118)],
          // default 그라데이션 방향은 왼쪽에서 오른쪽
          // begin: 그라데이션의 시작 위치 지정, default 값은 Alignment.centerLeft
          begin: Alignment.topCenter,
          // end: 그라데이션의 끝 위치 지정, default 값은 Alignment.centerRight
          end: Alignment.bottomCenter,
          // stops: 각 색이 어디서부터 어디까지 적용될지 지정, 0.0 ~ 1.0 사이의 값 지정 (생략 시 균등 분포), colors와 길이가 같아야 함
          // 없는게 자연스러움 사실
          //stops: [0.0, 0.7],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTap: onLogoTap),
          SizedBox(height: 28.0),
          _Title(),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _PlayButton({
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.isPlaying,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: onReversePressed,
            icon: Icon(Icons.rotate_left),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onPlayPressed,
            icon: Icon(
              isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onForwardPressed,
            icon: Icon(Icons.rotate_right),
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final Duration position;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;
  final bool useOpacity;

  const _Bottom({
    required this.position,
    required this.maxPosition,
    required this.onSliderChanged,
    required this.useOpacity,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    //Positioned: Stack 내에서 위치를 지정할 때 유용
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Opacity(
        opacity: useOpacity ? 0.67 : 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Text(
                // padLeft: 문자열의 길이가 지정한 값보다 작을 경우 왼쪽에 지정한 문자로 채움
                '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  // value: 현재 비디오 재생 위치
                  value: position.inSeconds
                      .toDouble(),
                  // duration: 비디오의 전체 길이
                  // inSeconds: Duration을 초 단위의 정수로 변환
                  max: maxPosition.inSeconds
                      .toDouble(),
                  onChanged: onSliderChanged,
                ),
              ),
              Text(
                '${maxPosition.inMinutes.toString().padLeft(2, '0')}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _AnotherVideo({
    required this.onPressed,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0.0,
      child: IconButton(
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(Icons.photo_camera_back),
      ),
    );
  }
}



