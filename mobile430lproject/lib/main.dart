import 'package:flutter/material.dart';
import 'package:mobile430lproject/login.dart';
import 'package:mobile430lproject/register.dart';

import 'package:mobile430lproject/wrapper.dart';

import 'home_screen.dart';
import 'landing_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

//added a comment
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // StreamProvider<CustomUser?>.value(
        //   value: AuthService().user,
        //   initialData: null,
        // child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/Home': (context) => const HomeScreen(),
        '/Landing': (context) => const LandingScreen(),
        '/SignIn': (context) => const SignIn(),
        '/Register': (context) => const SignUp(),
        // '/Insights': (context) => const WeeklyInsightsScreen(),
        // '/ItemInfo': (context) => const ItemInfoScreen(),
        // '/RecipeItemInfo': (context) => const RecipeItemInfoScreen(),
        // '/LoggingFood': (context) => const LoggingFoodScreen(),
        // '/NewRecipeSearch': (context) => const NewRecipeSearch(),
        // '/InputNewRecipe': (context) => const InputNewRecipe(),
        // '/DailyLogging': (context) => const DailyLogScreen(),
        // '/Settings': (context) => const SettingsForm(),
        // '/CameraScreen': (context) => const CameraScreen(),
        // '/Bolus': (context) => const Bolus(),
        // '/RecipeList': (context) => const RecipeList(),

        // '/SignUp': (context) => SignUp1(),
      },
    );
  }
}
