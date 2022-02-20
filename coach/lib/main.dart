import 'package:coach/models/UserModel.dart';
import 'package:coach/screens/HomeScreen.dart';
import 'package:coach/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() async {
  UserModel userModel = UserModel();
  await userModel.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.dark));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => userModel),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  bool checkFirstTime(BuildContext context) {
    return Provider.of<UserModel>(context, listen: false).name == "" ||
        Provider.of<UserModel>(context, listen: false).phone == "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exsy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        if (checkFirstTime(context)) {
          return MaterialWithModalsPageRoute(
            settings: settings,
            builder: (context) => const Material(child: RegisterScreen()),
          );
        } else {
          return MaterialWithModalsPageRoute(
            settings: settings,
            builder: ((context) => const Material(child: HomeScreen())),
          );
        }
      },
    );
  }
}
