import 'package:flutter/material.dart';

void main() => runApp(AnimateApp());

class AnimateApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AnimateAppState();
  }
}

class _AnimateAppState extends State<AnimateApp> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  bool status = false;

  @override
  void initState() {
    super.initState();
    // 创建 AnimationController 对象
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    // 通过 Tween 对象 创建 Animation 对象
    animation = Tween(begin: 50.0, end: 200.0).animate(controller)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AnimateApp',
        theme: ThemeData(
            primaryColor: Colors.redAccent
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('AnimateApp'),
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                  height: 100,
                  width: 100,
                  top: 100,
                  left: animation.value,
                  child: GestureDetector(
                    child: Container(
                      // 获取动画的值赋给 widget 的宽高
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.redAccent
                      ),
                    ),
                    onTap: () {
                      print(status);
                      if(status) {
                        // 执行动画
                        controller.reverse();
                        setState(() {
                          status = false;
                        });
                      } else {
                        // 执行动画

                        setState(() {
                          status = true;
                        });

                        controller.forward();
                      }

                      print(animation.value);
                    },
                  ),
                )
              ],
            )
        )
    );
  }

  @override
  void dispose() {
    // 资源释放
    controller.dispose();
    super.dispose();
  }
}