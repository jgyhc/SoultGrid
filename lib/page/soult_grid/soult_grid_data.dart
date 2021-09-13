import 'package:canvas_demo/page/soult_grid/soult_grid_controller.dart';
import 'package:canvas_demo/page/soult_grid/soult_grid_model.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class SoultGridData extends ChangeNotifier {
  final int count;
  final _random = new Random();
  double value = 0;
  int currentIndex = -1;
  int nextNumber = 1;
  List<SoultGrid> list = [];
  int countdown = 3;

  SoultGridData({required this.count});

  int getClickIndex(Offset offset, double width) {
    double itemWidth = width / count;
    double x = offset.dx;
    double y = offset.dy;
    double currentWidth = itemWidth;
    double currentHeight = itemWidth;
    int horizontal = 0;
    int vertical = 0;
    while (currentWidth < x) {
      horizontal++;
      currentWidth = itemWidth * (horizontal + 1);
    }
    while (currentHeight < y) {
      vertical++;
      currentHeight = itemWidth * (vertical + 1);
    }
    int index = vertical * count + horizontal;
    currentIndex = index;
    return index;
  }

  void push(double p) {
    value = p;
    notifyListeners();
  }

  void updateCountdown(int value) {
    countdown = value;
    notifyListeners();
  }

  void didClickView(Offset offset, double width) {
    int index = getClickIndex(offset, width);
    if (index > list.length) {
      return;
    }
    SoultGrid obj = list[index];
    if (obj.isSelect) {
      return;
    }
    if (obj.index != nextNumber) {
      return;
    }

    obj.isSelect = true;
    if (nextNumber == count * count) {
      SoultGridController controller = Get.find<SoultGridController>();
      BuildContext context = Get.context!;
      controller.stopGame();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('恭喜完成游戏'),
              content: Text('成绩为：' + controller.timeString),
              actions: <Widget>[
                TextButton(
                  child: Text('确认'),
                  onPressed: () {
                    Navigator.of(context).pop('cancel');
                  },
                ),
              ],
            );
          });
      return;
    }
    nextNumber++;
  }

  List getModelList() {
    for (var i = 0; i < count * count; i++) {
      list.add(SoultGrid(string: (i + 1).toString(), index: i + 1));
    }
    return shuffle(list);
  }

  int next(int min, int max) {
//将 参数min + 取随机数（最大值范围：参数max -  参数min）的结果 赋值给变量 result;
    var result = min + _random.nextInt(max - min);
//返回变量 result 的值;
    return result;
  }

  List shuffle(arr) {
    int m = arr.length;
    for (var i = 0; i < m; i++) {
      var item = arr[i];
      int index = next(0, count * count); //交换的索引
      arr[i] = arr[index];
      arr[index] = item;
    }
    return arr;
  }
}
