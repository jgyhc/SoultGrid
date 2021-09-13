import 'dart:async';

import 'package:canvas_demo/page/soult_grid/soult_grid_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SoultGridController extends GetxController
    with SingleGetTickerProviderMixin {
  int count = 3;
  List? list;
  AnimationController? ctrl;
  SoultGridData? data;
  Animation<double>? sequenceAnim;
  Timer? _timer;
  Timer? _countdownTimer;
  int _interval = 0;
  int countdown = 3;
  String timeString = "00:00";
  @override
  void onInit() {
    super.onInit();
    count = Get.arguments;
    data = SoultGridData(count: count);
    list = data!.getModelList();
    ctrl = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1,
        duration: Duration(milliseconds: 300))
      ..addListener(_startAnimation);

    sequenceAnim = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 1), weight: 50),
      TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 50)
    ]).animate(ctrl!);
  }

  void restart() {
    _interval = 0;
    data!.nextNumber = 1;
    data!.currentIndex = 0;
    data!.list.clear();
    list = data!.getModelList();
    update();
  }

  void startTime() async {
    _timer = Timer.periodic(Duration(seconds: 1), (time) {
      _interval = _interval + 1;
      timeString = intervalToString(_interval);
      update();
    });
  }

  void stopGame() {
    _timer!.cancel();
  }

  String intervalToString(int interval) {
    int minutes = _interval ~/ 60;
    int seconds = _interval % 60;
    String minutesString = minutes.toString();
    String secondsString = seconds.toString();
    if (minutesString.length == 1) {
      minutesString = "0" + minutesString;
    }
    if (secondsString.length == 1) {
      secondsString = "0" + secondsString;
    }
    return minutesString + ":" + secondsString;
  }

  _startAnimation() {
    data!.push(sequenceAnim!.value);
  }

  @override
  void onReady() async {
    update();
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (time) {
      countdown--;
      data!.updateCountdown(countdown);
      if (countdown <= 0) {
        _countdownTimer!.cancel();
        startTime();
      }
    });
  }

  @override
  void onClose() {
    ctrl!.dispose();
  }
}
