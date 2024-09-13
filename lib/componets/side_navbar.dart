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
                    style: const TextStyle(
                      color: Color.fromARGB(255, 237, 83, 36),
                      fontSize: 20,
                    ),
                  );
                }
              }

              return const Text(
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
            style: const TextStyle(
              color: Color.fromARGB(255, 237, 83, 36),
              fontSize: 20,
            ),
          ),
          /*currentAccountPicture: CircleAvatar(
            child: ClipOval(),
          ), */
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 237, 83, 36),
            image: DecorationImage(
              image: AssetImage('lib/images/bg1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.flight_takeoff),
          title: const Text('Flight Status'),
          onTap: () => {},
        ),
        ListTile(
          leading: const Icon(Icons.question_mark_rounded),
          title: const Text('FAQ'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FAQPage()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.feedback_outlined),
          title: const Text('Feedback'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewPage()),
            )
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notification'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            )
          },
        ),

        //conatct form
        ListTile(
          leading: const Icon(Icons.contact_phone),
          title: const Text('Contact Us'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactUsPage()),
            )
          },
        ),
        ListTile(
          leading: const Icon(Icons.more_horiz),
          title: const Text('About Us'),
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            )
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () => {},
        ),
      ],
    ));
  }
}
