import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/layout/home_layout.dart';
import 'package:to_do/my_provider.dart';
import 'package:to_do/screens/login/login.dart';
import 'package:to_do/screens/signup/signup.dart';
import 'package:to_do/screens/splach_screen.dart';
import 'package:to_do/screens/tasks/edit_task_buttom_sheet.dart';
import 'package:to_do/shared/styles/theming/my_them.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // locale: Locale(provider.language),
      supportedLocales: [
        Locale('en'), // English
        Locale('ar', 'eg'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      // provider.firebaseUser!=null?HomeLayout.routeName
      //     :LoginScreen.routeName,

      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeLayout.routeName: (context) => HomeLayout(),
        EditTaskButtomSheet.routeName: (context) => EditTaskButtomSheet(),
      },
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
    );
  }
}
