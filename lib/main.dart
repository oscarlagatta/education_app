import 'package:education_app/core/resources/colours.dart';
import 'package:education_app/core/resources/fonts.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/services/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education Application',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(accentColor: Colours.primaryColour),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.poppins,

      ),
      onGenerateRoute: generateRoute,
    );


  }
}
