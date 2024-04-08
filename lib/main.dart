import 'dart:io';

import 'package:blog_app/Features/Auth/Data/datasource/auth_remote_databse.dart';
import 'package:blog_app/Features/Auth/Data/repository/auth_repo_impl.dart';
import 'package:blog_app/Features/Auth/Domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Core/Secrets/appSecretsSupabase.dart';
import 'Core/Themes/theme_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Features/Auth/Presentation/Pages/login_page.dart';
import 'Features/Auth/Presentation/bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabse = await Supabase.initialize(
      url: SupaBase.supaBaseUrl, anonKey: SupaBase.supaBaseKey);
  // runApp(ChangeNotifierProvider(
  //   create: (context) => ThemeProvider(),
  //   child: const SplashScreen(),
  // ));
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              userSignUp: UserSignUp(
                AuthRepositoryImpl(
                  authRemoteDataSource:
                      AuthRemoteDataSourceImpl(supabaseClient: supabse.client),
                ),
              ),
            ),
          )
        ],
        child: const SplashScreen(),
      ),
    ),
  );
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
        body: LoginPage(),
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

class MyCameraApp extends StatefulWidget {
  const MyCameraApp({super.key});

  @override
  _MyCameraAppState createState() => _MyCameraAppState();
}

class _MyCameraAppState extends State<MyCameraApp> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _getImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null)
              Image.file(File(_image!.path))
            else
              const Text('No image selected'),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Capture Image from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
