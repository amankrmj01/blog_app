import 'package:blog_app/Features/Auth/Presentation/Pages/signup_page.dart';
import 'package:flutter/material.dart';

import '../../../../Components/custom_textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userName = TextEditingController();
  bool _userFilled = true;
  final TextEditingController _password = TextEditingController();
  bool _passwordFilled = true;
  // late FocusScopeNode currentFocus;

  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // currentFocus = FocusScope.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                alignment: Alignment.center,
                height: 60,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'SignUp',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GestureDetector(
                  // onTap
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        TextFieldCustom(
                          // focusNode: currentFocus,
                          controller: _userName,
                          icon: const Icon(Icons.person_outline),
                          text: 'User Name',
                          visible: true,
                        ),
                        onEmpty('username', _userFilled),
                        TextFieldCustom(
                          controller: _password,
                          icon: const Icon(Icons.lock_outline),
                          text: 'Password',
                          visible: false,
                        ),
                        onEmpty('password', _passwordFilled),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    // showDialogWithText('Hello');
                    checkIfEmpty(() => _userName.text.isNotEmpty,
                        (value) => _userFilled = value);
                    checkIfEmpty(() => _password.text.isNotEmpty,
                        (value) => _passwordFilled = value);
                  },
                  child: Text(
                    'Press me once',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',
                      style: TextStyle(color: Colors.black)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'SignUp',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void checkIfEmpty(
      bool Function() condition, void Function(bool) setStateCallback) {
    setState(() {
      setStateCallback(condition());
    });
  }

  Container onEmpty(String text, bool isEmpty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child: !isEmpty
          ? Text(
              'Fill the $text*',
              style: const TextStyle(color: Colors.red),
            )
          : const SizedBox(),
    );
  }

  showDialogWithText(String text) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }
}
