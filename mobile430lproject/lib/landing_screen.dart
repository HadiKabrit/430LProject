import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile430lproject/constants.dart';

const mockupHeight = 896;
const mockupWidth = 414;
const String assetName = 'assets/images/landing.svg';
Widget LandingScreenPic = SvgPicture.asset(assetName);

class LandingScreen extends StatelessWidget {
  // final Function toggleSignIn;
  // final Function toggleSignUp;
  const LandingScreen({
    Key? key,
    // required this.toggleSignIn, required this.toggleSignUp
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final size = MediaQuery.of(context).size;
    final textScaleFactor = width / mockupWidth.toDouble();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0.075 * size.height,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Color(0xFF65AFC1),
          ),
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "X",
                style: TextStyle(fontSize: 48, color: primaryBlue),
              )),
        ),
        // backgroundColor: const Color.fromARGB(255, 255, 75, 58),
        body: SingleChildScrollView(
          child: Column(
              //
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0.123 * size.width, top: 0.032 * size.height),
                    child: Text(
                      '''Lebanese\nCurrency\nExchange?''',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      textScaleFactor: textScaleFactor,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 48.0,
                        fontFamily: 'Inria Serif',
                        fontWeight: FontWeight.w400,
                        color: darkBlue,

                        /* letterSpacing: -1.95, */
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.05 * size.height,
                ),
                // SizedBox(
                //   width: size.width,
                //   height: size.height * 0.475,
                //   child: Stack(
                //     children: [
                // Positioned(
                //   top: 0,
                //   left: 0.5 * size.width,
                //   child: Image.asset(
                //     "assets/images/buritto.png",
                //     height: 0.216 * size.height,
                //     width: 0.495 * size.width,
                //     // scale: scale,
                //   ),
                // ),
                //       Positioned(
                //         top: 0.1 * size.height,
                //         child: Image.asset(
                //           "assets/images/burger.png",
                //           height: 0.246 * size.height,
                //           width: 0.512 * size.width,
                //           // scale: scale,
                //         ),
                //       ),
                //       Positioned(
                //         top: 0.15 * size.height,
                //         left: 0.3 * size.width,
                //         child: Image.asset(
                //           "assets/images/pizza.png",
                //           height: 0.383 * size.height,
                //           width: 0.683 * size.width,
                //           // scale: scale,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // LandingScreenPic,
                Image.asset(
                  "assets/images/landing.png",
                  // height: 0.216 * size.height,
                  // width: 0.495 * size.width,
                  // scale: scale,
                ),
                SizedBox(
                  height: 0.1 * size.height,
                ),
                ElevatedButton(
                  onPressed: () {
                    // toggleSignUp();
                    Navigator.pushNamed(context, "/Register");
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(314, 70)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Get Started",
                    textScaleFactor: textScaleFactor,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      height: 0.8683594336876502,
                      fontSize: 24.0,
                      fontFamily: 'Inria Serif',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,

                      /* letterSpacing: -1.95, */
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/SignIn");
                  },
                  child: Text(
                    "Already have an Account? Log In Here",
                    textScaleFactor: textScaleFactor,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      height: 0.8683594336876502,
                      fontSize: 18.0,
                      fontFamily: 'Inria Serif',
                      fontWeight: FontWeight.w400,
                      color: primaryBlue,

                      /* letterSpacing: -1.95, */
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
