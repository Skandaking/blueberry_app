import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:flutter/material.dart';
import 'hotel_page.dart'; // Import the HotelPage

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideNavbar(),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('Home')),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flight),
                    SizedBox(width: 5),
                    Text('Flights'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.hotel),
                    SizedBox(width: 5),
                    Text('Hotels'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Flights content')),
            // Replace 'Hotels content' with navigating to HotelPage
            HotelPage(),
          ],
        ),
      ),
    );
  }
}
