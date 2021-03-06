import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/loading.dart';
import 'package:http/http.dart' as http;
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/models/user.dart';
// import '../../custom/loading.dart';
// import '../../services/auth.dart';

class SignUp extends StatefulWidget {
  // final Function toggleLanding;
  const SignUp({
    Key? key,
    // required this.toggleLanding
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

Future<void> registerUser(UserForSignUp user) async {
  try {
    var response = await http.post(Uri.parse('$apiURL/user'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_name': user.username,
          'password': user.password,
          "phone": user.phone
        }));

    if (response.body.isNotEmpty) {
      var data = json.decode(response.body);
      print(data.toString());
      // print(data['token'].toString());
      await storage.write(key: 'token', value: data['token']);
    }
  } catch (error) {
    print(error.toString());
  }
}

class _SignUpState extends State<SignUp> {
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String username = '';
  String password = '';
  String phone = '';
  void onChangedUsername(val) {
    username = val;
  }

  void onChangedPass(val) {
    password = val;
  }

  void onChangedPhone(val) {
    phone = val;
  }

  // String? passwordValidator(val) {
  //   return val!.length < 6 ? 'Enter a password 6+ chars long' : null;
  // }

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
                          '''Register''',
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
                    // SizedBox(
                    //   height: 0.01 * size.height,
                    // ),
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
                                left: 50, right: 50, top: 30),
                            child: TextFormField(
                              validator: (val) => emailValidator(val),
                              onChanged: (val) => onChangedUsername(val),
                              decoration: const InputDecoration(
                                labelText: 'User Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 30),
                            child: TextFormField(
                              // validator: (val) => (val),
                              onChanged: (val) => onChangedPhone(val),
                              decoration: const InputDecoration(
                                labelText: 'Phone Number',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 30),
                            child: TextFormField(
                              // validator: (val) => passwordValidator(val),
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
                              onPressed: () async {
                                UserForSignUp user = UserForSignUp(
                                    username: username,
                                    password: password,
                                    phone: phone);
                                await registerUser(user);
                                var token = await storage.read(key: "token");
                                if (token != "") {
                                  Navigator.popAndPushNamed(context, '/Home');
                                }
                                print(token.toString());
                              },
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
                                "Register",
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
