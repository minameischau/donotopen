import 'package:flutter/material.dart';
import 'package:panow/ui/home/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:panow/models/onboard.dart';
import 'package:panow/ui/control_screen.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthManager>(
        builder: (ctx, authManager, child) => SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .75,
                      color: white,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            currentScreen = value;
                          });
                        },
                        itemCount: onBoardData.length,
                        itemBuilder: (context, index) => OnBoardContent(
                          onBoard: onBoardData[index],
                        ),
                      ),
                    ),

                    // Điều hướng trang
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => authManager.isAuth
                                  ? const HomePageScreen()
                                  : FutureBuilder(
                                      future: authManager.tryAutoLogin(),
                                      builder: (context, snapshot) {
                                        return snapshot.connectionState ==
                                                ConnectionState.waiting
                                            ? const SplashScreen()
                                            : const LoginScreen();
                                      },
                                    ),
                            ),
                            (route) => false);
                      },
                      // Buttom
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .6,
                        decoration: BoxDecoration(
                            color: primaryCorlor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  color: textCorlor,
                                  spreadRadius: 0,
                                  blurRadius: 5)
                            ]),
                        child: Center(
                          child: Text(
                            currentScreen == onBoardData.length - 1
                                ? 'Bắt đầu'
                                : 'Tiếp tục',
                            style: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Bar current
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          onBoardData.length,
                          (index) => indicator(index: index),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }

  AnimatedContainer indicator({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: currentScreen == index ? 20 : 6,
      height: 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: currentScreen == index ? orange : black.withOpacity(.6),
      ),
    );
  }
}

class OnBoardContent extends StatelessWidget {
  final OnBoards onBoard;
  const OnBoardContent({Key? key, required this.onBoard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width - 40,
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 40,
                    color: orange200,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 28,
                          height: 273,
                          child: SvgPicture.asset(
                            "assets/panow.svg",
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                child: Image.asset(
                  onBoard.image,
                  height: 500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text(
          onBoard.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 1.5,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textCorlor,
          ),
        ),
      ],
    );
  }
}
