import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NameField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const NameField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _NameFieldState createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
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
          hintText: "Full Name",
          border: InputBorder.none,
          icon: FaIcon(
            FontAwesomeIcons.userCircle,
            color: Color.fromRGBO(29, 161, 242, 1),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
