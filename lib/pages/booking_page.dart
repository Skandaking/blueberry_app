import 'package:blueberry_app/componets/my_button.dart';
import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? departureDate;
  DateTime? returnDate;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideNavbar(),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('Flight Booking')),
          actions: [
            IconButton(icon: Icon(Icons.history), onPressed: () {}),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context)
                .primaryColor, // Color of the selected tab indicator
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
                      height: 115.0, // Increased height for the row
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[100],
                      ),
                      child: Row(
                        children: [
                          const Expanded(
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
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter origin',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz),
                            color: Color.fromARGB(255, 237, 83, 36),
                            onPressed:
                                () {}, // Implement functionality to swap from and to
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
                                  decoration: InputDecoration(
                                    hintText: 'Enter destination',
                                    border: InputBorder.none,
                                  ),
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
                              fontSize: 18.0, color: Colors.grey[600]),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            _selectDate(
                                context, true); // Call function to pick a date
                          },
                          child: Text(
                            'Select Date',
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
                        Text(
                          'Passengers:',
                          style: TextStyle(
                              fontSize: 17.0, color: Colors.grey[600]),
                        ),
                        SizedBox(width: 10.0),
                        DropdownButton<int>(
                          value: 1, // Initial value (1 passenger)
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('1'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('2'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('3'),
                            ),
                            // Add more options as needed
                          ],
                          onChanged:
                              (value) {}, // Implement functionality to handle passenger selection
                        ),
                        Spacer(),
                        DropdownButton<String>(
                          value: 'Economy', // Initial value
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
                          onChanged:
                              (value) {}, // Implement functionality to handle class selection
                        ),
                      ],
                    ),
                    SizedBox(height: 70.0),
                    // Search flights button
                    SizedBox(
                        width: double.infinity,
                        height: 70.0,
                        child: MyButton(
                          text: 'Search Flights',
                          onTap: () {},
                        ))
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
                      height: 115.0, // Increased height for the row
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
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter origin',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.swap_horiz_rounded),
                            color: Color.fromARGB(255, 237, 83, 36),
                            onPressed:
                                () {}, // Implement functionality to swap from and to
                          ),
                          const Expanded(
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
                                  decoration: InputDecoration(
                                    hintText: 'Enter destination',
                                    border: InputBorder.none,
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
                                _selectDate(
                                    context, true); // Select departure date
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
                                _selectDate(
                                    context, false); // Select return date
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
                        Text(
                          'Passengers:',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        DropdownButton<int>(
                          value: 1, // Initial value (1 passenger)
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('1'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('2'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('3'),
                            ),
                            // Add more options as needed
                          ],
                          onChanged:
                              (value) {}, // Implement functionality to handle passenger selection
                        ),
                        Spacer(),
                        DropdownButton<String>(
                          value: 'Economy', // Initial value
                          items: [
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
                          onChanged:
                              (value) {}, // Implement functionality to handle class selection
                        ),
                      ],
                    ),
                    SizedBox(height: 70.0),
                    // Search flights button
                    SizedBox(
                      width: double.infinity,
                      height: 70.0,
                      child: MyButton(
                        text: 'Search Flights',
                        onTap: () {},
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
