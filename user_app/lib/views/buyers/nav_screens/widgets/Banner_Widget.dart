import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Banner_Widget extends StatefulWidget {
  @override
  State<Banner_Widget> createState() => _Banner_WidgetState();
}

class _Banner_WidgetState extends State<Banner_Widget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List _bannerImage = [];
  final List _bannerText = [];

  getBanners() {
    return _firestore
        .collection('banners')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  _bannerImage.add(doc['image']);
                  _bannerText.add(doc['title']);
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
        child: Stack(
          children: [
            PageView.builder(
              itemCount: _bannerImage.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        _bannerImage[index],
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Text(
                          _bannerText[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            backgroundColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
