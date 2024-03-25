import 'package:blueberry_app/Extras/faq.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideNavbar extends StatelessWidget {
  const SideNavbar({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            'Skanda Kaunda',
            style: TextStyle(
                color: Color.fromARGB(255, 237, 83, 36), fontSize: 20),
          ),
          accountEmail: Text(
            'skandakunda@gmail.com',
            style: TextStyle(
                color: Color.fromARGB(255, 237, 83, 36), fontSize: 20),
          ),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(),
          ),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 237, 83, 36),
              image: DecorationImage(
                image: AssetImage('lib/images/bg1.jpg'),
              )),
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
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notification'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.calculate_outlined),
          title: Text('Miles Calculator'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.compare_arrows),
          title: Text('COVID-19 Updates'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.contact_phone),
          title: Text('Contact_Us'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.more_horiz),
          title: Text('About Us'),
          onTap: () => {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.logout_rounded),
          title: Text('Logout'),
          onTap: () {
            // Show a confirmation dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Are you sure you want to logout?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Dismiss the dialog and cancel the logout
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Dismiss the dialog and proceed with the logout
                        Navigator.of(context).pop();

                        signUserOut();
                      },
                      child: Text('Logout'),
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    ));
  }
}
