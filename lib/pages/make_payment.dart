import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentPage extends StatefulWidget {
  final String bookingReference;

  PaymentPage({required this.bookingReference});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Token? _paymentToken;
  PaymentMethod? _paymentMethod;
  TextEditingController _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Fetch the price from Firestore based on the booking reference
    fetchPriceFromFirestore();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
            "pk_test_51P2JHGRrldZeIbJC83F3Rs5vxU1IrznOIf1dqdJxbMNCFWW5GJ4QrtpZ6eXsqmCBbLwOw0ByFQwMWOeYtKpdn8AK004rqFawWL",
      ),
    );
  }

  Future<void> fetchPriceFromFirestore() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingReference)
          .get();

      if (documentSnapshot.exists) {
        var price = documentSnapshot['price'];
        if (price is String) {
          _amountController.text =
              price; // Set the text directly if it's a string
        } else if (price is int) {
          _amountController.text =
              price.toString(); // Convert integer to string
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Document does not exist. Please check the booking reference.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Error fetching price from Firestore. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _payWithCard() async {
    int amount = int.tryParse(_amountController.text) ?? 0;

    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );

      print('Payment amount: \$${amount / 100}');

      // Save payment details to Firestore
      await FirebaseFirestore.instance.collection('payments').add({
        'price': amount,
        'bookingReference': widget.bookingReference,
        'paymentDate': DateTime.now(),
        'userEmail': FirebaseAuth.instance.currentUser!.email,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Payment Successful'),
            content: Text('Payment completed for amount: \$${amount / 100}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
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
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Price: ${_amountController.text}',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _payWithCard,
                    child: Text('Pay with Card'),
                  ),
                  Text(
                    'Booking Reference: ${widget.bookingReference}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
    );
  }
}
