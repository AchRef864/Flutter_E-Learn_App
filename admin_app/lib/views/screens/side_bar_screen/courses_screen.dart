import 'package:flutter/material.dart';
import '../../../model/courses_model/create.dart';
import '../../../model/courses_model/delete.dart';
import '../../../model/courses_model/update.dart';

class CoursesScreen extends StatefulWidget {
  static const String routeName = '\CoursesScreen';

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String? _selectedValue = 'create';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200,
                      child: RadioListTile<String>(
                        title: Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: 'create',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: RadioListTile<String>(
                        title: Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: 'update',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: RadioListTile<String>(
                        title: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: 'delete',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_selectedValue != null)
              Expanded(
                child: Center(
                  child: getText() ?? Container(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget getText() {
    switch (_selectedValue) {
      case 'create':
        return create();
      case 'update':
        return update();
      case 'delete':
        return delete();
      default:
        return SizedBox.shrink();
    }
  }
}
