import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UsernameField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const UsernameField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _UsernameFieldState createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
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
          hintText: "Username",
          border: InputBorder.none,
          icon: FaIcon(
            FontAwesomeIcons.at,
            color: Color.fromRGBO(29, 161, 242, 1),
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
