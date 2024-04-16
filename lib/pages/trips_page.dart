import 'package:flutter/material.dart';
import 'package:blueberry_app/componets/side_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: SideNavbar(),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Center(child: Text('My Trips')),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(text: 'Upcoming Flights'),
              Tab(text: 'Hotel check ins'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            currentUser == null
                ? Center(child: Text('No user signed in'))
                : FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('bookings')
                        .where('userEmail', isEqualTo: currentUser.email)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.data == null ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No bookings found'));
                      } else {
                        // Display bookings in a ListView
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final booking = snapshot.data!.docs[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              color: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(20),
                                leading: Icon(
                                  Icons.flight,
                                  color: Color.fromARGB(255, 237, 83, 36),
                                  size: 32,
                                ),
                                title: Text(
                                  'Flight Number ${booking['flightNumber']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 237, 83, 36),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey[600],
                                          size: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Departure: ${booking['departure']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey[600],
                                          size: 16,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Arrival: ${booking['arrival']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.grey[600],
                                          size: 14,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Date: ${booking['departureDate']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.grey[600],
                                          size: 14,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Time: ${booking['departureTime']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Cost: ${booking['price']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Confirm Cancellation"),
                                                  content: Text(
                                                      "Are you sure you want to cancel this booking?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false); // No
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(true); // Yes
                                                      },
                                                      child: Text("Yes"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ).then((confirmed) {
                                              if (confirmed ?? false) {
                                                // If confirmed is true (or null, defaulting to false), proceed with canceling the booking
                                                cancelBooking(
                                                    context,
                                                    booking[
                                                        'bookingReference']);
                                              }
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Color.fromARGB(
                                                255, 237, 83, 36),
                                          ),
                                          child: Text(
                                            'Cancel Booking',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('Hotel checkins...'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> cancelBooking(
    BuildContext context, String bookingReference) async {
  try {
    // Query the collection to find the document with the matching booking reference
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('bookingReference', isEqualTo: bookingReference)
        .get();

    // If there's a matching document, delete it
    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();

      // Update or delete related documents in other collections
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(bookingReference)
          .delete();

      await FirebaseFirestore.instance
          .collection('passebgers')
          .doc(bookingReference)
          .delete();

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking canceled successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // If no document found with the given booking reference, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (error) {
    print('Error canceling booking: $error');
    // Show error snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error canceling booking. Please try again.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
