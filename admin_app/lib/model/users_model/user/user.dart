import 'package:flutter/material.dart';
import 'update.dart';
import 'delete.dart';

class user extends StatefulWidget {
  static const String routeName = '\UsersScreen';

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  String? _selectedValue = 'update';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
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
      case 'update':
        return update();
      case 'delete':
        return delete();
      default:
        return SizedBox.shrink();
    }
  }
}
