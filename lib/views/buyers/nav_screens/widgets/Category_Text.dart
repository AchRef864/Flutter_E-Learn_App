import 'package:flutter/material.dart';

class Category_Text extends StatelessWidget {
  final List<String> _categoryTable = [
    'Procedural languages',
    'Object-oriented languages',
    'Scripting languages',
    'Web development languages',
    'Mobile app development languages',
    'Game development languages'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '\ncategories\n',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryTable.length,
                    itemBuilder: ((context, index) {
                      return ActionChip(label: Text(_categoryTable[index]));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
