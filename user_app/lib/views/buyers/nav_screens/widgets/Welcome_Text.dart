import 'package:flutter/material.dart';

class Welcome_Text extends StatelessWidget {
  const Welcome_Text({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "A person who never\nmade a mistake\nnever tried anything new.\n",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 36,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
