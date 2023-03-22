import 'package:flutter/material.dart';

class Search_Bar extends StatelessWidget {
  const Search_Bar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Search For Products",
        hintStyle: TextStyle(
          color: Colors.white70,
        ),
        suffixIcon: Icon(
          Icons.search_outlined,
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }
}
