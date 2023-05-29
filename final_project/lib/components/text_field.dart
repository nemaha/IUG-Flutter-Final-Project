import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SharedTextField extends StatelessWidget {
  TextEditingController? controller;
  TextInputType type;
  bool isPassword;
  bool readOnly;
  String? hint;
  String? Function(String?)? validate;
  void Function()? onTap;
  int? maxLines;

  SharedTextField({
    super.key,
    required this.controller,
    required this.validate,
    this.type = TextInputType.text,
    this.isPassword = false,
    this.readOnly = false,
    this.hint,
    this.maxLines,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint ?? ''),
        SizedBox(
          height: 10,
        ),
        Container(
          //height: 50,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            onTap: onTap,
            keyboardType: type,
            obscureText: isPassword,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: maxLines,
            readOnly: readOnly,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              counterText: '',
              hintText: hint,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.normal),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none),
            ),
            validator: validate,
          ),
        ),
      ],
    );
  }
}
