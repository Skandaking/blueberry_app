import 'package:blueberry_app/Methods/search_flight.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingManager {
  static Future<String> bookFlight({
    required Flight flight,
    required String userEmail,
  }) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("No user signed in.");
      }

      int nextBookingNumber = await _getBookingNumber();

      // Create a new Booking document in Firestore with booking status as "pending"
      String bookingReference = _generateBookingReference(nextBookingNumber);
      await FirebaseFirestore.instance.collection('bookings').add({
        'departure': flight.departure,
        'arrival': flight.arrival,
        'flightNumber': flight.flightNumber,
        'departureDate': flight.departureDate,
        'departureTime': flight.departureTime,
        'status': flight.status,
        'availableSeats': flight.availableSeats,
        'price': flight.price,
        'bookingDatetime': DateTime.now(),
        'bookingReference': bookingReference,
        'userEmail': currentUser.email!,
        'bookingStatus': 'completed', // Initial booking status
      });

      // Return the generated booking reference
      return bookingReference;
    } catch (error) {
      throw error;
    }
  }

  static Future<int> _getBookingNumber() async {
    try {
      // Retrieve the last booking number from Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .orderBy('bookingReference', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // No existing bookings, start with 1
        return 1;
      } else {
        // Get the last booking number and increment it
        int lastBookingNumber = int.parse(
            querySnapshot.docs.first.get('bookingReference').substring(7));
        return lastBookingNumber + 1;
      }
    } catch (error) {
      throw error;
    }
  }

  static String _generateBookingReference(int bookingNumber) {
    // Generate a unique booking reference using the booking number
    return 'BOOKING${bookingNumber.toString().padLeft(3, '0')}';
  }

  static Future<void> updateBookingStatus(
      String bookingId, String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({
        'bookingStatus': status,
      });
    } catch (error) {
      throw error;
    }
  }
}
