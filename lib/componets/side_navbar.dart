import 'package:blueberry_app/Extras/about.dart';
import 'package:blueberry_app/Extras/contact.dart';
import 'package:blueberry_app/Extras/faq.dart';
import 'package:blueberry_app/Extras/review.dart';
import 'package:blueberry_app/pages/notification_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideNavbar extends StatelessWidget {
  SideNavbar({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Users')
                .doc(currentUser.email)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic>? data =
                    snapshot.data!.data() as Map<String, dynamic>?;

                if (data != null) {
                  return Text(
                    "${data['Firstname']} ${data['Lastname']}",
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 83, 36),
                      fontSize: 20,
                    ),
                  );
                }
              }

              return Text(
                "Loading...",
                style: TextStyle(
                  color: Color.fromARGB(255, 237, 83, 36),
                  fontSize: 20,
                ),
              );
            },
          ),
          accountEmail: Text(
            currentUser.email!,
            style: TextStyle(
              color: Color.fromARGB(255, 237, 83, 36),
              fontSize: 20,
            ),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(),
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 237, 83, 36),
            image: DecorationImage(
              image: AssetImage('lib/images/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.flight_takeoff),
          title: Text('Flight Status'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.question_mark_rounded),
          title: Text('FAQ'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FAQPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.feedback_outlined),
          title: Text('Feedback'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReviewPage()),
            )
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notification'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            )
          },
        ),

        //conatct form
        ListTile(
          leading: Icon(Icons.contact_phone),
          title: Text('Contact Us'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactUsPage()),
            )
          },
        ),
        ListTile(
          leading: Icon(Icons.more_horiz),
          title: Text('About Us'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            )
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => {},
        ),
      ],
    ));
  }
}
