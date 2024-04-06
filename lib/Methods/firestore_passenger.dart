import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static Future<void> savePassenger({
    required String bookingReference,
    required String title,
    required String firstName,
    required String middleName,
    required String lastName,
    required DateTime dateOfBirth,
    required String gender,
    required String email,
    required String phoneNumber,
    required bool saveContactDetails,
    required bool subscribeBookingUpdates,
  }) async {
    try {
      // Add logic to save passenger details to Firestore here
      // Example:
      await FirebaseFirestore.instance.collection('passengers').add({
        'bookingReference': bookingReference,
        'title': title,
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'email': email,
        'phoneNumber': phoneNumber,
        'saveContactDetails': saveContactDetails,
        'subscribeBookingUpdates': subscribeBookingUpdates,
      });
    } catch (error) {
      throw error;
    }
  }
}
