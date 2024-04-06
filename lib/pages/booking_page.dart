import 'package:blueberry_app/Methods/search_flight.dart';
import 'package:blueberry_app/componets/my_button.dart';
import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:blueberry_app/pages/search_flight_results.dart';
import 'package:blueberry_app/pages/search_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? departureDate;
  DateTime? returnDate;
  String? fromCity;
  String? toCity;
  int? passengers;
  String? travelClass;
  double? totalPrice;

  final TextEditingController _fromCityController = TextEditingController();
  final TextEditingController _toCityController = TextEditingController();
  final TextEditingController _passengersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideNavbar(),
        appBar: AppBar(
          title: Center(child: Text('Flight Booking')),
          actions: [
            IconButton(
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchHistoryPage()),
                  );
                }),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'One way'),
              Tab(text: 'Round trip'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // One way content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search row for from and to
                    Container(
                      height: 115.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: _fromCityController,
                                    decoration: InputDecoration(
                                      hintText: 'Departure',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        fromCity = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz),
                            color: Color.fromARGB(255, 237, 83, 36),
                            onPressed: () {
                              // Implement functionality to swap from and to
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                TextField(
                                  controller: _toCityController,
                                  decoration: InputDecoration(
                                    hintText: 'Arrival',
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      toCity = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    // Departure date
                    Row(
                      children: [
                        Text(
                          'Departure Date:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            _selectDate(context, true);
                          },
                          child: Text(
                            departureDate == null
                                ? 'Select Date'
                                : '${departureDate!.day}/${departureDate!.month}/${departureDate!.year}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 237, 83, 36),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    // Passengers and class selection
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: DropdownButton<String>(
                              value: travelClass, // Update the value property
                              items: const [
                                DropdownMenuItem(
                                  value: 'Economy',
                                  child: Text('Economy'),
                                ),
                                DropdownMenuItem(
                                  value: 'Business',
                                  child: Text('Business'),
                                ),
                                DropdownMenuItem(
                                  value: 'First Class',
                                  child: Text('First Class'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  travelClass =
                                      value; // Update the travelClass variable
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 70.0),

                    // Search flights button
                    SizedBox(
                      width: double.infinity,
                      height: 70.0,
                      child: MyButton(
                        onTap: () {
                          if (fromCity == null ||
                              toCity == null ||
                              departureDate == null ||
                              returnDate == null ||
                              travelClass == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all the fields'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            // Save search history before searching for flights
                            saveSearchHistory(fromCity!, toCity!, travelClass!,
                                FirebaseAuth.instance.currentUser!.email!);

                            // Proceed with searching for flights
                            final searchResults =
                                searchFlightsByArrival(toCity!, travelClass!);
                            if (searchResults.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No search results found'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchResultsPage(results: searchResults),
                                ),
                              );
                            }
                          }
                        },
                        text: 'Search Flights',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Round trip content
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search row for from and to
                    Container(
                      height: 115.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                    controller: _fromCityController,
                                    decoration: InputDecoration(
                                      hintText: 'Departure',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        fromCity = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz_rounded),
                            color: Color.fromARGB(255, 237, 83, 36),
                            onPressed: () {
                              // Implement functionality to swap from and to
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: TextField(
                                    controller: _toCityController,
                                    decoration: InputDecoration(
                                      hintText: 'Arrival',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        toCity = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.0),
                    // Departure and return dates
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Departure date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Departure Date:',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            TextButton(
                              onPressed: () {
                                _selectDate(context, true);
                              },
                              child: Text(
                                departureDate == null
                                    ? 'Select Departure Date'
                                    : '${departureDate!.day}/${departureDate!.month}/${departureDate!.year}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 237, 83, 36),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Return date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Return Date:',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5.0),
                            TextButton(
                              onPressed: () {
                                _selectDate(context, false);
                              },
                              child: Text(
                                returnDate == null
                                    ? 'Select Return Date'
                                    : '${returnDate!.day}/${returnDate!.month}/${returnDate!.year}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 237, 83, 36),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    // Passengers and class selection
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: DropdownButton<String>(
                              value: travelClass, // Update the value property
                              items: const [
                                DropdownMenuItem(
                                  value: 'Economy',
                                  child: Text('Economy'),
                                ),
                                DropdownMenuItem(
                                  value: 'Business',
                                  child: Text('Business'),
                                ),
                                DropdownMenuItem(
                                  value: 'First Class',
                                  child: Text('First Class'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  travelClass =
                                      value; // Update the travelClass variable
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 70.0),
                    // Search flights button
                    SizedBox(
                      width: double.infinity,
                      height: 70.0,
                      child: MyButton(
                        onTap: () {
                          if (fromCity == null ||
                              toCity == null ||
                              departureDate == null ||
                              travelClass == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all the fields'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            // Save search history before searching for flights
                            saveSearchHistory(fromCity!, toCity!, travelClass!,
                                FirebaseAuth.instance.currentUser!.email!);

                            // Proceed with searching for flights
                            final searchResults =
                                searchFlightsByArrival(toCity!, travelClass!);
                            if (searchResults.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('No search results found'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SearchResultsPage(results: searchResults),
                                ),
                              );
                            }
                          }
                        },
                        text: 'Search Flights',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isDepartureDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isDepartureDate) {
          departureDate = pickedDate;
        } else {
          returnDate = pickedDate;
        }
      });
    }
  }
}

Future<void> saveSearchHistory(String fromCity, String toCity,
    String travelClass, String userEmail) async {
  FirebaseFirestore.instance.collection('searchHistory').add({
    'fromCity': fromCity,
    'toCity': toCity,
    'travelClass': travelClass,
    'userEmail': userEmail,
    'searchDate': FieldValue.serverTimestamp(),
  });
}
