import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/loading.dart';

// import '../../custom/loading.dart';
// import '../../services/auth.dart';

class SignIn extends StatefulWidget {
  // final Function toggleLanding;
  const SignIn({
    Key? key,
    // required this.toggleLanding
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';

  void onChangedEmail(val) {
    email = val;
  }

  void onChangedPass(val) {
    password = val;
  }

  String? passwordValidator(val) {
    return val!.length < 6 ? 'Enter a password 6+ chars long' : null;
  }

  String? emailValidator(val) {
    return val!.isEmpty ? 'Enter an email' : null;
  }

  // void signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() => loading = true);
  //     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
  //     if (result == null) {
  //       setState(() {
  //         loading = false;
  //         error = 'Could not sign in with those credentials';
  //       });
  //     }
  //   }
  // }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const Loading()
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                toolbarHeight: 0.075 * size.height,
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: const IconThemeData(
                  color: Color(0xFF65AFC1),
                ),
                leading: IconButton(
                    iconSize: 50,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.123 * size.width, top: 0.032 * size.height),
                        child: Text(
                          '''Log In''',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          // textScaleFactor: textScaleFactor,
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
                      height: 0.075 * size.height,
                    ),
                    SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0.123 * size.width, top: 0.032 * size.height),
                        child: Text(
                          '''Lebanese\nCurrency\nExchange?''',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          // textScaleFactor: textScaleFactor,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 60),
                            child: TextFormField(
                              validator: (val) => emailValidator(val),
                              onChanged: (val) => onChangedEmail(val),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 50),
                            child: TextFormField(
                              validator: (val) => passwordValidator(val),
                              onChanged: (val) => onChangedPass(val),
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40, top: 60),
                            child: ElevatedButton(
                              onPressed: () {},
                              // => signIn(),
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(314, 70)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryBlue),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Log In",
                                // textScaleFactor: textScaleFactor,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  height: 0.8683594336876502,
                                  fontSize: 24.0,
                                  fontFamily: 'Inria Serif',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,

                                  /* letterSpacing: -1.95, */
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}