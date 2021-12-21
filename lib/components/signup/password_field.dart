import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const PasswordField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15.0, 0, 3.0, 0),
      width: 300,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        obscureText: _isObscure,
        decoration: InputDecoration(
          hintText: "Password",
          border: InputBorder.none,
          icon: const Icon(
            Icons.person_outline_rounded,
            color: Color.fromRGBO(29, 161, 242, 1),
          ),
          suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
