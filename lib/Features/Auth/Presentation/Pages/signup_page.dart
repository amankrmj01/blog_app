import 'package:blog_app/Components/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/Themes/theme_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _userName = TextEditingController();
  bool _userFilled = true;
  final TextEditingController _password = TextEditingController();
  bool _passwordFilled = true;
  final TextEditingController _email = TextEditingController();
  bool _emailFilled = true;
  final TextEditingController _age = TextEditingController();
  bool _ageFilled = true;
  final TextEditingController _confirmPassword = TextEditingController();
  bool _confirmFilled = true;
  bool _genderFilled = false;
  // late FocusScopeNode currentFocus;

  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _age.dispose();
    _confirmPassword.dispose();
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
                          controller: _email,
                          icon: const Icon(Icons.alternate_email_rounded),
                          text: 'Email',
                          visible: true,
                        ),
                        onEmpty('email', _emailFilled),
                        TextFieldCustom(
                          controller: _age,
                          icon: const Icon(Icons.numbers_outlined),
                          text: 'Age',
                          visible: true,
                        ),
                        onEmpty('age', _ageFilled),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: const MyDropdown(),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: _genderFilled
                              ? const Text(
                                  'choose the gender*',
                                  style: TextStyle(color: Colors.red),
                                )
                              : const SizedBox(),
                        ),
                        TextFieldCustom(
                          controller: _password,
                          icon: const Icon(Icons.lock_outline),
                          text: 'Password',
                          visible: false,
                        ),
                        onEmpty('password', _passwordFilled),
                        TextFieldCustom(
                          controller: _confirmPassword,
                          icon: const Icon(Icons.lock_outline),
                          text: 'Confirm Password',
                          visible: false,
                        ),
                        onEmpty('confirm password', _confirmFilled),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    if (_MyDropdownState.dropdownValue == 'Gender') {
                      setState(() {
                        _genderFilled = true;
                      });
                    } else {
                      setState(() {
                        _genderFilled = false;
                      });
                    }
                    // showDialogWithText('Hello');
                    checkIfEmpty(() => _userName.text.isNotEmpty,
                        (value) => _userFilled = value);
                    checkIfEmpty(() => _password.text.isNotEmpty,
                        (value) => _passwordFilled = value);
                    checkIfEmpty(() => _email.text.isNotEmpty,
                        (value) => _emailFilled = value);
                    checkIfEmpty(() => _confirmPassword.text.isNotEmpty,
                        (value) => _confirmFilled = value);
                    checkIfEmpty(() => _age.text.isNotEmpty,
                        (value) => _ageFilled = value);
                  },
                  child: Text(
                    'Press me once',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
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

class MyDropdown extends StatefulWidget {
  const MyDropdown({
    super.key,
  });

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  static String dropdownValue = 'Gender';

  @override
  Widget build(BuildContext context) {
    bool isDarkModeSystem = Provider.of<ThemeProvider>(context).isDarkMode;
    Color? border = isDarkModeSystem
        ? Color.lerp(Colors.black, Colors.white, 0.3)
        : Colors.black;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return <String>['Male', 'Female'].map((String value) {
            return PopupMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 20),
              ),
            );
          }).toList();
        },
        onSelected: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3, color: border!),
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints.expand(width: width - 20, height: 120),
        padding: const EdgeInsets.all(50),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: isDarkModeSystem
                  ? Color.lerp(Colors.black, Colors.white, 0.15)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: border, width: 3)),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                runSpacing: 10,
                spacing: 8,
                children: [
                  Icon(dropdownValue == 'Gender'
                      ? Icons.person_outline_rounded
                      : dropdownValue == 'Male'
                          ? Icons.male
                          : Icons.female),
                  Text(
                    dropdownValue, // Use the updated value here
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_drop_down,
                color: isDarkModeSystem ? Colors.white : Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
