import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Flight Booking'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Booking type selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('One Way')),
                ElevatedButton(onPressed: () {}, child: Text('Round Trip')),
                ElevatedButton(onPressed: () {}, child: Text('Multi City')),
              ],
            ),
            SizedBox(height: 20.0), // Spacer

            // Booking Form
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('From:'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your location',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('To:'),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your destination',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('Departure Date:'),
                    InkWell(
                      onTap: () {
                        // Implement calendar picker logic
                      },
                      child: Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text('Select Date'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Passengers
                        Text('Passengers:'),
                        DropdownButton<int>(
                          value: 1, // Default value
                          onChanged: (value) {},
                          items: [1, 2, 3, 4, 5]
                              .map((value) => DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  ))
                              .toList(),
                        ),
                        // Flight Class
                        Text('Flight Class:'),
                        DropdownButton<String>(
                          value: 'Economy', // Default value
                          onChanged: (value) {},
                          items: ['Economy', 'Business', 'First Class']
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Implement search button logic
                      },
                      child: Text('Search'),
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
}
