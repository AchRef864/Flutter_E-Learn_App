import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class delete extends StatefulWidget {
  const delete({super.key});

  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {
  String? fileName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? SelectedAdmin;

  uploadToFirebaseStore() async {
    EasyLoading.show(status: 'Deleting ...');
    if (SelectedAdmin != null) {
      String? choix = SelectedAdmin;
      SelectedAdmin = null;
      await _firestore
          .collection("accounts")
          .doc("account")
          .collection("admins")
          .doc(choix)
          .delete()
          .whenComplete(() {
        EasyLoading.showSuccess('Data Deleted!');
        setState(() {});
      });
    } else {
      EasyLoading.showError('Failed with Error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Warning"),
            content: Text("Fill required fields"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Add this line
                    children: [
                      Text(
                        'Admin to be deleted:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("accounts")
                            .doc("account")
                            .collection("admins")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return DropdownButton<String>(
                              items: [],
                              onChanged: null,
                            );
                          }
                          List<String> adminsNames = [];
                          for (final documentSnapshot in snapshot.data!.docs) {
                            final documentName = documentSnapshot.id;
                            adminsNames.add(documentName);
                          }
                          return DropdownButton<String>(
                              value: SelectedAdmin,
                              dropdownColor: Colors.black,
                              items: adminsNames
                                  .map((adminName) => DropdownMenuItem(
                                        value: adminName,
                                        child: Text(
                                          adminName,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (adminName) async {
                                setState(() => SelectedAdmin = adminName);
                              });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: SizedBox(
                    width: 150,
                    height: 50, // set desired width here
                    child: ElevatedButton(
                      onPressed: () {
                        uploadToFirebaseStore();
                      },
                      child: Text(
                        'Delete Admin',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
