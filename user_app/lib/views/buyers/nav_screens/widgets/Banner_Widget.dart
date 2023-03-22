import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner_Widget extends StatefulWidget {
  @override
  State<Banner_Widget> createState() => _Banner_WidgetState();
}

class _Banner_WidgetState extends State<Banner_Widget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImage = [];

  getBanners() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  _bannerImage.add(doc['image']);
                });
              })
            });
  }

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        child: PageView.builder(
          itemCount: _bannerImage.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                _bannerImage[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
