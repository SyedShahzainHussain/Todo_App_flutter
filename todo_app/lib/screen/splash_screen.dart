import 'package:flutter/material.dart';
import 'package:todo_app/screen/todo_app.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const TodoApp()),
            (route) => false));

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            FadeTransition(
              opacity: opacityAnimation,
              child: Image.asset(
                'asset/pngwing.com.png',
                width: MediaQuery.sizeOf(context).width * .6,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Todo App",
              softWrap: true,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: SpinKitWave(
                color: Colors.purple,
                type: SpinKitWaveType.center,
                size: MediaQuery.sizeOf(context).width * .05,
              ),
            ),
          ]),
    );
  }
}
