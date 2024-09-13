import 'package:blueberry_app/componets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blueberry_app/pages/hotel_payment.dart';

class GuestDetailsPage extends StatefulWidget {
  final String hotelBookingReference;
  final String price;

  const GuestDetailsPage({
    Key? key,
    required this.hotelBookingReference,
    required this.price,
  }) : super(key: key);

  @override
  _GuestDetailsPageState createState() => _GuestDetailsPageState();
}

class _GuestDetailsPageState extends State<GuestDetailsPage> {
  String _selectedPurpose = 'Leisure'; // Default purpose
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _detailsConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Hotel Booking Reference: ${widget.hotelBookingReference}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: ${widget.price}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Guest Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(labelText: 'Country/Region'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country/region';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Purpose of Trip:',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                value: _selectedPurpose,
                onChanged: (newValue) {
                  setState(() {
                    _selectedPurpose = newValue!;
                  });
                },
                items: <String>['Leisure', 'Business']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: _confirmDetails,
                text: ('Confirm Guest Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDetails() async {
    if (_formKey.currentState!.validate()) {
      // Check if details are already confirmed
      if (!_detailsConfirmed) {
        // Save guest details to Firestore
        await saveGuestDetails();

        // Show a snackbar indicating the details are confirmed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Guest details confirmed'),
          ),
        );

        // Set details confirmed to true
        setState(() {
          _detailsConfirmed = true;
        });
      } else {
        // Show a snackbar if details are already confirmed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Guest details already confirmed'),
          ),
        );
      }

      // Navigate to hotel payment page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelPaymentPage(
            hotelBookingReference: widget.hotelBookingReference,
            price: widget.price,
          ),
        ),
      );
    }
  }

  Future<void> saveGuestDetails() async {
    // Get current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      // Save guest details to Firestore
      await FirebaseFirestore.instance.collection('guests').doc(uid).set({
        'hotelBookingReference': widget.hotelBookingReference,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
        'country': _countryController.text,
        'phoneNumber': _phoneNumberController.text,
        'purposeOfTrip': _selectedPurpose,
      });
    }
  }
}
