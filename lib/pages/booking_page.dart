import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        drawer: SideNavbar(),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('Flight Booking')),
          actions: [
            IconButton(icon: Icon(Icons.history), onPressed: () {}),
          ],
          bottom: TabBar(
            // Adding TabBar below app bar
            tabs: [
              Tab(text: 'One way'), // Tab for One way
              Tab(text: 'Round trip'), // Tab for Round trip
            ],
          ),
        ),
        body: TabBarView(
          // Adding TabBarView to switch between tabs
          children: [
            // Content of the first tab (One way)
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('One way content goes here...'),
              ),
            ),
            // Content of the second tab (Round trip)
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('Round trip content goes here...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
