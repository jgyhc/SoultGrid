import 'package:canvas_demo/router/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.INITIAL, //初始路由
      getPages: AppPages.routes, //路由
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                  child: Text(
                    '请选择游戏难度：',
                  )),
              Container(
                padding: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawChip(
                      label: Text('3*3', style: TextStyle(color: Colors.white)),
                      selected: count == 3,
                      onSelected: (v) {
                        setState(() {
                          count = 3;
                        });
                      },
                      selectedColor: Colors.blue,
                      selectedShadowColor: Colors.red,
                    ),
                    RawChip(
                      label: Text('4*4', style: TextStyle(color: Colors.white)),
                      selected: count == 4,
                      onSelected: (v) {
                        setState(() {
                          count = 4;
                        });
                      },
                      selectedColor: Colors.blue,
                      selectedShadowColor: Colors.red,
                    ),
                    RawChip(
                      label: Text(
                        '5*5',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: count == 5,
                      onSelected: (v) {
                        setState(() {
                          count = 5;
                        });
                      },
                      selectedColor: Colors.blue,
                      selectedShadowColor: Colors.red,
                    ),
                    RawChip(
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text('6*6'),
                      selected: count == 6,
                      onSelected: (v) {
                        setState(() {
                          count = 6;
                        });
                      },
                      selectedColor: Colors.blue,
                      selectedShadowColor: Colors.red,
                    )
                  ],
                ),
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
                      Get.toNamed("/soult", arguments: count);
                    },
                    child: Text(
                      "开始游戏",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }
}
