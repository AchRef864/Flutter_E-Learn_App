import 'package:flutter/material.dart';

class Welcome_Text extends StatelessWidget {
  const Welcome_Text({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color.fromARGB(193, 255, 255, 255),
                fontSize: 50,
                fontWeight: FontWeight.bold,
                fontFamily: "Courier",
              ),
              text: "Work",
              children: [
                TextSpan(
                  style: TextStyle(
                    color: Color(0xffB40026),
                  ),
                  text: " Hard",
                ),
                TextSpan(
                  text: ",",
                ),
                TextSpan(
                  text: "\nDream",
                ),
                TextSpan(
                  style: TextStyle(
                    color: Color(0xffB40026),
                  ),
                  text: " Big",
                ),
                TextSpan(
                  text: ".",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
