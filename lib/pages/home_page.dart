import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:blueberry_app/componets/ticket_view.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'hotel_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> upcomingFlights = [
    {
      'from': {'code': "LLW", 'name': "Lilongwe"},
      'to': {'code': "BLZ", 'name': "Blantyre"},
      'flying_time': '0H 30M',
      'date': "1 MAY",
      'departure_time': "08:00 AM",
      'number': 23,
    },
    {
      'from': {'code': "BLZ", 'name': "Blantyre"},
      'to': {'code': "CPT", 'name': "Capetown"},
      'flying_time': '11H 30M',
      'date': "10 MAY",
      'departure_time': "10:00 AM",
      'number': 30,
    },
    {
      'from': {'code': "LLW", 'name': "Lilongwe"},
      'to': {'code': "KNY", 'name': "Kenya"},
      'flying_time': '11H 30M',
      'date': "10 MAY",
      'departure_time': "10:00 AM",
      'number': 30,
    },
    {
      'from': {'code': "LLW", 'name': "Lilongwe"},
      'to': {'code': "BLZ", 'name': "Blantyre"},
      'flying_time': '0H 30M',
      'date': "1 MAY",
      'departure_time': "08:00 AM",
      'number': 23,
    },
  ];

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
                    Text(
                      'Flights',
                    ),
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
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search flights',
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Upcoming Flights',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'View All',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          child: CarouselSlider.builder(
                            itemCount: upcomingFlights.length,
                            itemBuilder: (context, index, realIndex) {
                              final flight = upcomingFlights[index];
                              return TicketView(flight: flight);
                            },
                            options: CarouselOptions(
                              height: 200,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              initialPage: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  HotelPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
