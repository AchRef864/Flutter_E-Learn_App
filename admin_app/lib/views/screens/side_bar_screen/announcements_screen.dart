import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatelessWidget {
  static const String routeName = '\AnnouncementsScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Announcements',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white70 // Background color
                      ),
                  onPressed: () {},
                  child: Container(
                    height: 140,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Center(
                      child: Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: () {}, child: Text('Save')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
