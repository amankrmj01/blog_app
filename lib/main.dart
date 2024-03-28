import 'package:blog_app/Features/Auth/Presentation/Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Core/Themes/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isDarkModeSystem =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      if (isDarkModeSystem) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      // themeAnimationDuration: Duration(milliseconds: 100),
      themeAnimationCurve: Curves.elasticOut,
      // themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('testing'),
          actions: [
            Container(
              child: SwitchMode(),
            )
          ],
        ),
        body: SignUpPage(),
      ),
    );
  }
}

class SwitchMode extends StatelessWidget {
  const SwitchMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ThemeProvider>(context)
          .isDarkMode, // A boolean variable representing the switch state.
      onChanged: (newValue) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
      trackOutlineColor: MaterialStateProperty.resolveWith(
        (Set<MaterialState> states) {
          if (Provider.of<ThemeProvider>(context).isDarkMode) {
            // Return a custom icon (e.g., a close icon) when the switch is disabled
            return Color.lerp(Colors.white, Colors.black, 0.8);
          }
          return Colors.amber;
        },
      ),
      thumbColor: MaterialStateProperty.resolveWith(
        (Set<MaterialState> states) {
          if (Provider.of<ThemeProvider>(context).isDarkMode) {
            // Return a custom icon (e.g., a close icon) when the switch is disabled
            return Colors.black;
          }
          return Colors.amber;
        },
      ),
      thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
          if (Provider.of<ThemeProvider>(context).isDarkMode) {
            // Return a custom icon (e.g., a close icon) when the switch is disabled
            return const Icon(
              Icons.dark_mode_rounded,
              color: Colors.white,
            );
          }
          return const Icon(
            Icons.light_mode_rounded,
            color: Colors.white,
          );
        },
      ),
    );
  }
}
