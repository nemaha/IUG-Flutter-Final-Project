import 'package:flutter/material.dart';

class SharedButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  Color color;
  SharedButton({super.key, required this.onPressed, required this.title,this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
