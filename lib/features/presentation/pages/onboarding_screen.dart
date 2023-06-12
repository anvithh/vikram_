import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vikram/const.dart';
import 'package:vikram/features/presentation/pages/register.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final int _totalSlides = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          animationDuration: 150,
          pages: [
            // Email id?\nNah! Welcome to the future!
            PageViewModel(
              titleWidget: const Column(
                children: [
                  Text(
                    'Email id? Nah!\n Welcome to the future!',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      height:
                          20), // Add vertical spacing between title and body
                ],
              ),
              body:
                  'Create and own a Vikram Bot which interacts with the world on your behalf. Share your VBot id with others.',
              image: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "V.I.K.R.A.M",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF161A27),
                        // color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  buildImage('assets/slide2.jpg', 140),
                ],
              ),
              decoration: getPageDecoration().copyWith(
                imagePadding: const EdgeInsets.symmetric(
                    vertical: 24.0), // Adjust the image padding
                descriptionPadding: const EdgeInsets.only(
                    bottom: 16.0), // Adjust the bottom padding of the body text
              ),
            ),
            //slide_3.jpg
            PageViewModel(
              titleWidget: const Column(
                children: [
                  Text(
                    'Your Personal AI Assistant',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ), // Add vertical spacing between title and body
                ],
              ),
              body:
                  'Your VBot has the superpowers to surf the net, browse videos on youtube and much more!',
              image: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "V.I.K.R.A.M",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF161A27),
                        // color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  buildImage('assets/slide_3.jpg', 140),
                ],
              ),
              decoration: getPageDecoration().copyWith(
                imagePadding: const EdgeInsets.symmetric(
                    vertical: 24.0), // Adjust the image padding
                descriptionPadding: const EdgeInsets.only(
                    bottom: 16.0), // Adjust the bottom padding of the body text
              ),
            ),
            //slide_3.png
            //Teach your VBot to help others!
            PageViewModel(
              titleWidget: const Column(
                children: [
                  Text(
                    'Teach your VBot to help others!',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ), // Add vertical spacing between title and body
                ],
              ),
              body:
                  'You can feed instructions to your VBot and release it to the world. It will help people and earn for you!',
              // footer: ButtonWidget(
              //   text: 'Start Reading',
              //   onClicked: () => const Register(),
              // ),
              image: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "V.I.K.R.A.M",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF161A27),
                          // color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: buildImage('assets/slide_3.png', 220),
                  ),
                ],
              ),
              decoration: getPageDecoration().copyWith(
                imagePadding: const EdgeInsets.symmetric(
                    vertical: 24.0), // Adjust the image padding
                descriptionPadding: const EdgeInsets.only(
                    bottom: 16.0), // Adjust the bottom padding of the body text
              ),
            ),
          ],
          done: const Text('Register',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF161A27),
              )),
          onDone: () {
            Navigator.pushNamed(context, PageConstant.registerPage);
          },
          showSkipButton: true,
          skip: const Text(
            '',
            style: TextStyle(
                color: Color(0xFF161A27), fontWeight: FontWeight.bold),
          ),
          onSkip: () {
            _pageController.jumpToPage(_totalSlides - 1);
          },
          next: const IconTheme(
            data: IconThemeData(
              color: Color(0xFF161A27), // Set the color of the forward arrow
            ),
            child: Icon(Icons.arrow_forward),
          ),
          dotsDecorator: getDotDecoration(),
          //onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.white,
          nextFlex: 1,
        ),
      ),
    );
  }
}

Widget buildImage(String path, double width) =>
    Center(child: Image.asset(path, width: width));

DotsDecorator getDotDecoration() => DotsDecorator(
      color: const Color(0xFFBDBDBD),
      activeColor: const Color(0xFF161A27),
      size: const Size(10, 10),
      activeSize: const Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

PageDecoration getPageDecoration() => const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 15),
      //descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(14),
      pageColor: Colors.white,
    );
