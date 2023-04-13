import 'package:flutter/material.dart';
import 'package:quizz/views/buyers/nav_screens/course_screen.dart';

class Category_Text extends StatefulWidget {
  @override
  _Category_TextState createState() => _Category_TextState();
}

class _Category_TextState extends State<Category_Text> {
  final List<String> _categoryTable = [
    'All courses',
    'Desktop development',
    'iOS development',
    'Web development',
    'Android development',
    'Game development'
  ];
  String _selectedCategory = 'All courses';

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
                          onPressed: () {
                            setState(() {
                              _selectedCategory = _categoryTable[index];
                            });
                          },
                          label: Center(
                            child: Text(
                              _categoryTable[index],
                              style: TextStyle(
                                color:
                                    _selectedCategory == _categoryTable[index]
                                        ? Colors.white
                                        : Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Selected category: $_selectedCategory',
          ),
        ],
      ),
    );
  }
}
