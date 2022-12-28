import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:introduction_screen/introduction_screen.dart";




class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {
  bool firstOpen = true;
  _onIntroEnd(context) async {
    Navigator.of(context)
        .pushNamed("/Login");
  }
  _buildFullScreenImage(String img) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0,80,0,0),
      child: Image.asset(
        "images/logo.png",
        fit: BoxFit.contain,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topCenter,
      ),
    );
  }
  _buildImage(String assetName, [double width = 350]) {
    return Image.asset("images/$assetName", width: width);
  }
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 2000), () {
      if (!firstOpen) {
        _onIntroEnd(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      pageColor: Colors.blueGrey,
      imagePadding: EdgeInsets.zero,
    );
    return firstOpen
        ? IntroductionScreen(
      globalBackgroundColor: Colors.blueGrey,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage("logo.jpg", 50),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: 'Context Golobal ',
          body:
          'Votre Application permet aux gens de gérer leur programme de médicaments d\'une manière simple et facile',
          image: _buildFullScreenImage("logo.jpg"),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),

        PageViewModel(
          title: "soyez libre",
          body:
          "en utilisant cette application, vous serez libre en fait, vous n'avez pas à vous soucier de votre programme de médicaments ou de vos Fratrie aussi",
          image: _buildFullScreenImage("family1.jpg"),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),

        PageViewModel(
          title: "économisez votre temps",
          body:
          "ne perdez pas de temps maintenant quand vous devez tout organiser            "
              " Le premier bien est la santé, le deuxième la beauté, le troisième la richesse",

          image: _buildFullScreenImage("docotr.jpg"),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () =>
          _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      dotsFlex: 0,
      nextFlex: 0,
      skip: const Text(
        "Skip",
        style: TextStyle(color: Colors.white),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text("Done",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.white)),
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.all(4),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.blueGrey,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    )
        : WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "images/logo.jpg",
                  width: size.width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "images/logo.jpg",
                  width: size.width * 0.2,
                ),
              ),
              Center(
                child: Image.asset(
                  "images/logo.jpg",
                  width: size.width * 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}