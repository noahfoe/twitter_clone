import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const EmailField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
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
        decoration: const InputDecoration(
          hintText: "Email",
          border: InputBorder.none,
          icon: Icon(
            Icons.email,
            color: Color.fromRGBO(29, 161, 242, 1),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
