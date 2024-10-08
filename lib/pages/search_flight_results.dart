import 'package:blueberry_app/Methods/book_flight.dart';
import 'package:blueberry_app/Methods/search_flight.dart';
import 'package:blueberry_app/pages/passenger_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Flight> results;
  final currentUser = FirebaseAuth.instance.currentUser;

  SearchResultsPage({
    Key? key,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available flights Results'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final flight = results[index];

          return Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                // Upper Section (Departure, Icon, Arrival)
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        flight.departure,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                    const Icon(
                      Icons.flight_takeoff,
                      color: Color.fromARGB(255, 237, 83, 36),
                    ),
                    const SizedBox(
                        width: 28), // Adjust the width as needed for spacing
                    Expanded(
                      child: Text(
                        flight.arrival,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),

                // Flight Number, Departure Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Flight: ${flight.flightNumber}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${flight.departureDate}  ${flight.departureTime}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),

                // Lower Section (Status, Available Seats, Price, Button)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.flight_takeoff,
                                color: Colors.green),
                            Text('Status: ${flight.status}',
                                style: const TextStyle(fontSize: 15.0)),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            const Icon(Icons.airline_seat_recline_normal,
                                color: Colors.orange),
                            Text('Available Seats: ${flight.availableSeats}',
                                style: const TextStyle(fontSize: 15.0)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${int.parse(flight.price)}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(height: 8.0),
                        TextButton(
                          onPressed: () async {
                            try {
                              // Call the bookFlight method to create a new booking
                              String bookingReference =
                                  await BookingManager.bookFlight(
                                flight: flight,
                                userEmail: currentUser!.email!,
                              );
                              // If booking is successful, navigate to PassengerInformationPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PassengerInformationPage(
                                    bookingReference: bookingReference,
                                    price: flight.price,
                                  ),
                                ),
                              );
                            } catch (error) {
                              // Handle any errors that occur during the booking process
                              print('Error booking flight: $error');
                              // Show a snackbar with the error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'An error occurred while booking the flight: $error'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Book Flight',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
