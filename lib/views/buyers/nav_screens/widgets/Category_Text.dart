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
            '\nCategories',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ActionChip(
                            backgroundColor: Colors.black26,
                            onPressed: () {},
                            label: Center(
                              child: Text(
                                _categoryTable[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            )),
                      );
                    }),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
