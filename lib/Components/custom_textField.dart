import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Core/Themes/theme_provider.dart';

class TextFieldCustom extends StatefulWidget {
  final String text;
  final Icon icon;
  final TextEditingController controller;
  final bool visible;
  final FocusNode? focusNode;

  const TextFieldCustom(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.visible,
      this.focusNode});

  @override
  _TextFieldCustomState createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  late bool _obscureText;

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  void initState() {
    _obscureText = !widget.visible;
    super.initState();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkModeSystem = Provider.of<ThemeProvider>(context).isDarkMode;
    Color? border = isDarkModeSystem
        ? Color.lerp(Colors.black, Colors.white, 0.3)
        : Colors.black;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        style: TextStyle(color: isDarkModeSystem ? Colors.white : Colors.black),
        focusNode: widget.focusNode,
        // onTapOutside: (event) {
        //   FocusManager.instance.primaryFocus?.unfocus();
        // },
        cursorColor: Colors.black,
        controller: widget.controller,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintFadeDuration: const Duration(milliseconds: 100),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: border!),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amber.withRed(250)),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.text,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: isDarkModeSystem
              ? Color.lerp(Colors.black, Colors.white, 0.15)
              : Colors.white,
          prefixIcon: widget.icon,
          // prefixIconColor: Colors.black,
          suffixIcon: widget.text.contains('Password')
              ? GestureDetector(
                  onTap: _toggleObscureText,
                  child: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                )
              : null,
        ),
      ),
    );
  }
}
