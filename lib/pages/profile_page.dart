import 'dart:typed_data';

import 'package:blueberry_app/Methods/image_get.dart';
import 'package:blueberry_app/componets/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  // all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // Selected values
  DateTime? selectedDate;
  String? selectedGender;
  String? selectedCountryCode;

  //select image
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

//edit field
  Future<void> editField(String field) async {
    String newValue = "";
    if (field == 'Date of Birth') {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != selectedDate) {
        newValue = DateFormat('yyyy-MM-dd').format(picked);
      }
    } else if (field == 'Gender') {
      newValue = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "Select Gender",
            style: TextStyle(color: Colors.white),
          ),
          content: DropdownButton<String>(
            value: selectedGender ?? 'Male',
            onChanged: (String? value) {
              newValue = value!;
              Navigator.of(context).pop(newValue);
            },
            style: const TextStyle(
                color: Colors.white), // Style for the selected value
            dropdownColor:
                Colors.grey[900], // Background color of the dropdown list
            iconEnabledColor: Colors.white,
            items: [
              'Male',
              'Female',
            ]
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
          ),
          actions: [
            //cancel button
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      newValue = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            "Edit $field",
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.amber),
            decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: const TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            //cancel button
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            //save button
            TextButton(
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop(newValue),
            ),
          ],
        ),
      );
    }

    // update in firestore
    if (newValue.trim().isNotEmpty) {
      //update only when there is value in text filed
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Profile page",
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Dismiss the dialog and cancel the logout
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Dismiss the dialog and proceed with the logout
                            Navigator.of(context).pop();

                            signUserOut();
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),

        //  backgroundColor: Colors.grey[900],

        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Users")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            //get user data  from firestore
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(children: [
                const SizedBox(height: 25),

                //profile picture
                Center(
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(
                                  'https://th.bing.com/th/id/OIP.TpqSE-tsrMBbQurUw2Su-AHaHk?w=159&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                            ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                //email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(height: 25),

                // My details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'My Details',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                // First name
                MyTextBox(
                  text: userData['Firstname'],
                  sectionName: 'Firstname',
                  onPressed: () => editField('Firstname'),
                ),

                // Last name
                MyTextBox(
                  text: userData['Lastname'],
                  sectionName: 'Lastname',
                  onPressed: () => editField('Lastname'),
                ),
                // Date of birth
                MyTextBox(
                  text: userData['Date of Birth'],
                  sectionName: 'Date of Birth',
                  onPressed: () => editField('Date of Birth'),
                ),
                // Gender
                MyTextBox(
                  text: userData['Gender'],
                  sectionName: 'Gender',
                  onPressed: () => editField('Gender'),
                ),
                // phone number
                MyTextBox(
                  text: userData['Phone Number'],
                  sectionName: 'phone number',
                  onPressed: () => editField('Phone Number'),
                ),
              ]);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          },
        ));
  }
}
