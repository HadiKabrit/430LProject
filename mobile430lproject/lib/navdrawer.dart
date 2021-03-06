import 'package:flutter/material.dart';
import 'package:mobile430lproject/constants.dart';
import 'package:mobile430lproject/login.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

String? token;

class _NavDrawerState extends State<NavDrawer> {
  void isSignedIn(var token) async {
    token = await storage.read(key: "token");
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromARGB(238, 238, 238, 238);
    String? pageRouteName = ModalRoute.of(context)?.settings.name;

    isSignedIn(token);

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [],
              ),
              decoration: BoxDecoration(color: primaryBlue),
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              title: const Text(
                'Log In/Register',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/Landing');
                // setState() => {token};
              },
              tileColor:
                  (pageRouteName == '/Landing') ? primaryBlue : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              // leading: const Icon(
              //   Icons.book,
              //   color: Colors.white,
              //   size: 28,
              // ),
              title: const Text(
                'Home',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () => {Navigator.pushReplacementNamed(context, '/Home')},
              tileColor:
                  (pageRouteName == '/Home') ? primaryBlue : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              // leading: const Icon(
              //   Icons.verified_user,
              //   color: Colors.white,
              //   size: 28,
              // ),
              title: const Text(
                'Transactions',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, '/Transactions')},
              tileColor: (pageRouteName == '/Transactions')
                  ? primaryBlue
                  : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              // leading: const Icon(
              //   Icons.settings,
              //   color: Colors.white,
              //   size: 28,
              // ),
              title: const Text(
                'Graphs',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () => {Navigator.pushReplacementNamed(context, '/Graphs')},
              tileColor:
                  (pageRouteName == '/Graphs') ? primaryBlue : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              // leading: const Icon(
              //   Icons.settings,
              //   color: Colors.white,
              //   size: 28,
              // ),
              title: const Text(
                'Offers',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () => {Navigator.pushReplacementNamed(context, '/Offers')},
              tileColor:
                  (pageRouteName == '/Offers') ? primaryBlue : Colors.white,
            ),
            const SizedBox(
              height: 8,
            ),
            ListTile(
              // leading: const Icon(
              //   Icons.exit_to_app,
              //   color: Colors.white,
              //   size: 28,
              // ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () async {
                print(token);
                await storage.write(key: 'token', value: "");
                setState(() {
                  token = "";
                });
                //  setState()
              }
              //  async {
              //   await _auth.signOut();

              //   await Navigator.pushReplacementNamed(context, '/');
              // }
              ,
            )
          ],
        ),
      );
    });
  }
}
