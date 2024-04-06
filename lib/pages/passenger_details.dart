import 'package:blueberry_app/Methods/firestore_passenger.dart';
import 'package:blueberry_app/pages/make_payment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blueberry_app/componets/my_button.dart';

class PassengerInformationPage extends StatefulWidget {
  final String bookingReference;

  PassengerInformationPage({required this.bookingReference});

  @override
  _PassengerInformationPageState createState() =>
      _PassengerInformationPageState();
}

class _PassengerInformationPageState extends State<PassengerInformationPage> {
  bool _autofillFromProfile = false;
  String _title = "";
  String _firstName = "";
  String _middleName = "";
  String _lastName = "";
  DateTime _dateOfBirth = DateTime.now();
  String _gender = "";
  String _email = "";
  String _phoneNumber = "";
  bool _saveContactDetails = false;
  bool _subscribeBookingUpdates = false;
  bool _subscribePromotions = false;
  bool _confirmed = false;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        if (date != null) {
          _dateOfBirth = date;
        }
      });
    });
  }

  Future<void> _savePassenger(BuildContext context) async {
    try {
      await FirestoreService.savePassenger(
        bookingReference: widget.bookingReference,
        title: _title,
        firstName: _firstName,
        middleName: _middleName,
        lastName: _lastName,
        dateOfBirth: _dateOfBirth,
        gender: _gender,
        email: _email,
        phoneNumber: _phoneNumber,
        saveContactDetails: _saveContactDetails,
        subscribeBookingUpdates: _subscribeBookingUpdates,
      );
      // Show success message or handle success as needed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passenger details saved successfully'),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        _confirmed = true;
      });
    } catch (error) {
      // Show error message using a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving passenger details: $error'),
          backgroundColor: Colors.red,
        ),
      );
      // Optionally, re-throw the error to propagate it up
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passenger Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Reference
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Booking Reference: ${widget.bookingReference}',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Passenger details
            Text(
              'Passenger Details:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),

            // Title (optional)
            DropdownButtonFormField<String>(
              value: _title,
              hint: Text('Title (Optional)'),
              items: [
                DropdownMenuItem<String>(
                    value: "", child: Text('-- Select Title --')),
                DropdownMenuItem<String>(value: "Mr", child: Text('Mr.')),
                DropdownMenuItem<String>(value: "Ms", child: Text('Ms.')),
                DropdownMenuItem<String>(value: "Mrs", child: Text('Mrs.')),
              ],
              onChanged: (value) => setState(() => _title = value!),
            ),

            // First Name
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              onChanged: (value) => _firstName = value,
            ),

            // Middle Name (Optional)
            TextFormField(
              decoration: InputDecoration(labelText: 'Middle Name (Optional)'),
              onChanged: (value) => _middleName = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              onChanged: (value) => _lastName = value,
            ),

            // Date of Birth
            Row(
              children: [
                Text('Date of Birth:'),
                SizedBox(width: 10.0),
                TextButton.icon(
                  onPressed: _showDatePicker,
                  icon: Icon(
                    Icons.calendar_today,
                    color: Color.fromARGB(255, 237, 83, 36),
                  ),
                  label: Text(
                    DateFormat('yyyy-MM-dd').format(_dateOfBirth),
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 83, 36),
                    ),
                  ),
                ),
              ],
            ),

            // Gender
            Row(
              children: [
                Text('Gender:'),
                SizedBox(width: 10.0),
                Radio(
                  value: "male",
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value!),
                ),
                Text('Male'),
                SizedBox(width: 10.0),
                Radio(
                  value: "female",
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value!),
                ),
                Text('Female'),
                SizedBox(width: 10.0),
                Radio(
                  value: "other",
                  groupValue: _gender,
                  onChanged: (value) => setState(() => _gender = value!),
                ),
                Text('Other'),
              ],
            ),

            // Contact Details
            Text(
              'Contact Details:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),

            // Email
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => _email = value,
            ),

            // Phone Number
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) => _phoneNumber = value,
            ),

            // Save Contact Details Checkbox
            Row(
              children: [
                Checkbox(
                  value: _saveContactDetails,
                  onChanged: (value) =>
                      setState(() => _saveContactDetails = value!),
                ),
                Expanded(
                  child: Text(
                    'Save Contact Details for Next Booking',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Subscribe to Booking Updates Checkbox
            Row(
              children: [
                Checkbox(
                  value: _subscribeBookingUpdates,
                  onChanged: (value) =>
                      setState(() => _subscribeBookingUpdates = value!),
                ),
                Expanded(
                  child: Text(
                    'Subscribe to Booking & Flight Schedule Promotions',
                  ),
                ),
              ],
            ),

            // Confirm Button
            MyButton(
              text: 'Confirm Passenger Details',
              onTap: () async {
                // Manually validate the form fields
                if (_firstName.isEmpty ||
                    _lastName.isEmpty ||
                    _email.isEmpty ||
                    _phoneNumber.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all required fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                // Save passenger details and proceed to payment page
                await _savePassenger(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PaymentPage(bookingReference: widget.bookingReference),
                  ),
                );
              },
            ),

            // Confirmation Message
            if (_confirmed)
              Text(
                'Passenger details confirmed!',
                style: TextStyle(color: Colors.green, fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}
