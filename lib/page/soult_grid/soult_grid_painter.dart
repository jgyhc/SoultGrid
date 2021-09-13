import 'package:canvas_demo/page/soult_grid/soult_grid_data.dart';
import 'package:canvas_demo/page/soult_grid/soult_grid_model.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class SoultGridPainter extends CustomPainter {
  // final Animation<double> factor;
  final int count;
  final double width;
  // final double height = 0.0;
  final double spacing = 5.0;

  final List list;
  final SoultGridData data;
  const SoultGridPainter(
      {required this.width,
      required this.list,
      required this.count,
      required this.data})
      : super(repaint: data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    if (data.countdown > 0) {
      drawCountdown(canvas);
      return;
    }
    for (var i = 0; i < list.length; i++) {
      SoultGrid model = list[i];
      Color color;
      if (model.isSelect) {
        paint.color = Color(0xfff9e459);
        color = Colors.white;
      } else {
        paint.color = Color(0xffec9433);
        color = Colors.black;
      }
      RRect pRect = getRRectWithIdx(i);
      if (i == data.currentIndex) {
        double value = data.value * 3;
        RRect newRect = RRect.fromLTRBR(pRect.left - value, pRect.top - value,
            pRect.right + value, pRect.bottom + value, Radius.circular(10));
        canvas.drawRRect(newRect, paint);
      } else {
        canvas.drawRRect(pRect, paint);
      }

      drawText(pRect, model.string!, canvas, color);
    }
  }

  @override
  bool shouldRepaint(covariant SoultGridPainter oldDelegate) {
    return false;
  }

  void drawCountdown(Canvas canvas) {
    final paragraphStyle = ui.ParagraphStyle(
        // 字体方向，有些国家语言是从右往左排版的
        textDirection: TextDirection.ltr,
        // 字体对齐方式
        textAlign: TextAlign.center,
        fontSize: 120,
        maxLines: 1,
        // 字体超出大小时显示的提示
        ellipsis: '...',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        // height: itemWidth,
        // 当我们设置[TextStyle.height]时 这个高度是否应用到字体顶部和底部
        textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: true, applyHeightToLastDescent: true));
    //
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(color: Color(0xffc69c57)));
    paragraphBuilder.addText(data.countdown.toString());
    var paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: width));
    canvas.drawParagraph(
        paragraph, Offset(0, width / 2 - (paragraph.height / 2.0)));
  }

  RRect getRRectWithIdx(int idx) {
    double itemWidth = (width - (spacing * (count + 1))) / count; //算出每一个按钮的宽度
    double left = spacing;
    double top = spacing;

    int row = idx % count; //列
    int line = (idx ~/ count).toInt();
    // print("i:" + line.toString());
    // print("width:" + itemWidth.toString());
    left = (spacing + itemWidth) * row + spacing;
    top = (spacing + itemWidth) * line + spacing;
    // print("i:" + idx.toString());
    // print("itemWidth" + itemWidth.toString());
    // print("left:" + left.toString() + "top:" + top.toString());
    return RRect.fromLTRBR(
        left, top, left + itemWidth, top + itemWidth, Radius.circular(10));
  }

  void drawText(RRect pRect, String string, Canvas canvas, Color color) {
    final double itemWidth = pRect.right - pRect.left;
    final paragraphStyle = ui.ParagraphStyle(
        // 字体方向，有些国家语言是从右往左排版的
        textDirection: TextDirection.ltr,
        // 字体对齐方式
        textAlign: TextAlign.center,
        fontSize: 30,
        maxLines: 1,
        // 字体超出大小时显示的提示
        ellipsis: '...',
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        // height: itemWidth,
        // 当我们设置[TextStyle.height]时 这个高度是否应用到字体顶部和底部
        textHeightBehavior: TextHeightBehavior(
            applyHeightToFirstAscent: true, applyHeightToLastDescent: true));
    //
    final paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(ui.TextStyle(color: color));
    paragraphBuilder.addText(string);
    var paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: itemWidth));
    canvas.drawParagraph(
        paragraph,
        Offset(pRect.left,
            pRect.top + (itemWidth / 2.0) - (paragraph.height / 2.0)));
  }
}
