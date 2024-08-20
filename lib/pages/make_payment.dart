import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blueberry_app/componets/bottom_navbar.dart';

// Import necessary packages and files...

class PaymentPage extends StatefulWidget {
  final String bookingReference;
  final String price;

  PaymentPage({required this.bookingReference, required this.price});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Token? _paymentToken;
  PaymentMethod? _paymentMethod;
  bool _isLoading = false;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            'pk_test_51P2JHGRrldZeIbJC83F3Rs5vxU1IrznOIf1dqdJxbMNCFWW5GJ4QrtpZ6eXsqmCBbLwOw0ByFQwMWOeYtKpdn8AK004rqFawWL',
        merchantId: 'your_merchant_id',
        androidPayMode: 'test',
      ),
    );
  }

  Future<void> _payWithCard() async {
    int amount = int.tryParse(widget.price) ?? 0;

    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      print('Payment amount: MK ${widget.price}');

      // Save payment details to Firestore
      await FirebaseFirestore.instance.collection('payments').add({
        'price': amount,
        'bookingReference': widget.bookingReference,
        'paymentDate': DateTime.now(),
        'userEmail': FirebaseAuth.instance.currentUser!.email,
      });

      // Save notification details to Firestore
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': 'Booking Confirmation',
        'message':
            'You have successfully booked a flight: ${widget.bookingReference}',
        'userEmail': FirebaseAuth.instance.currentUser!.email,
        'timestamp': DateTime.now(),
      });

      // Show payment successful dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(
            // Wrap with Builder widget
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Payment Successful'),
                content:
                    Text('Payment completed for amount: MK ${widget.price}'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the AlertDialog
                      //Navigator.pop(context); // Close the PaymentPage
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
      );
    } catch (error) {
      print('Error during payment: $error');
      // Show error snackbar if payment fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during payment. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Payment'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to NavbarBottom when Home icon is clicked
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavbarBottom()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 70.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Price:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'MK${widget.price}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 237, 83, 36),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _payWithCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  minimumSize: Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Pay with Card',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Booking Reference: ${widget.bookingReference}',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
