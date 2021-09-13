import 'package:canvas_demo/page/soult_grid/soult_grid_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'soult_grid_controller.dart';

class SoultGridPage extends GetView<SoultGridController> {
  const SoultGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder<SoultGridController>(builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffeddd9e),
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    child:
                        Text("下一个：" + controller.data!.nextNumber.toString()),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffc0d6cb),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    width: 100,
                    height: 40,
                    child: Text(controller.timeString),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(50),
              color: Color(0xfffef3c9),
              child: GestureDetector(
                onTapUp: (TapUpDetails tapUpDetails) {
                  controller.data!.didClickView(tapUpDetails.localPosition,
                      MediaQuery.of(context).size.width - 110);
                  // _ctrl?.forward();
                  controller.ctrl?.forward(from: 0);
                  controller.update();
                  // _ctrl?.repeat(
                  // reverse: true, period: Duration(milliseconds: 300));
                },
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width - 110,
                      MediaQuery.of(context).size.width - 110),
                  painter: SoultGridPainter(
                      width: MediaQuery.of(context).size.width - 110,
                      list: controller.list!,
                      count: controller.count,
                      data: controller.data!),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffdad6ab),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child:
                            Text("返回", style: TextStyle(color: Colors.white))),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff777bce),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                        onPressed: () {
                          controller.restart();
                        },
                        child: Text(
                          "重新开始",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )
          ],
        );
      })),
    );
  }
}
