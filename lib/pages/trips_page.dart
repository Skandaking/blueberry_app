import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:flutter/material.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideNavbar(),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('My Trips')),
          actions: [
            IconButton(icon: Icon(Icons.history), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Theme.of(context)
                  .primaryColor, // Color of the selected tab indicator
              labelColor: Theme.of(context).primaryColor,
              // Moving TabBar outside app bar
              tabs: [
                Tab(text: 'Past'), // Tab for One way
                Tab(text: 'Upcoming'), // Tab for Round trip
              ],
            ),
            Expanded(
              // Use Expanded to allow the TabBarView to take remaining space
              child: TabBarView(
                // Adding TabBarView to switch between tabs
                children: [
                  // Content of the first tab (One way)
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Past trips..'),
                    ),
                  ),
                  // Content of the second tab (Round trip)
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('Upcoming trips...'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
