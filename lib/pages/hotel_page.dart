import 'dart:convert';

import 'package:blueberry_app/pages/guest_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

import '../Methods/search_hotel.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final DateTime _selectedDate = DateTime.now();
  final int _numberOfRooms = 1;
  final int _numberOfGuests = 1;
  List<Hotel> hotels = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    loadHotels();
  }

  Future<void> loadHotels() async {
    final String data = await rootBundle.loadString('lib/Methods/hotels.json');
    final jsonResult = json.decode(data);
    setState(() {
      hotels =
          (jsonResult as List).map((item) => Hotel.fromJson(item)).toList();
    });
  }

  List<Hotel> _searchHotels(String query) {
    return hotels
        .where(
            (hotel) => hotel.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Find What You Want',
                style: TextStyle(
                  fontSize: 20.0,
                  //color: Color.fromARGB(255, 237, 83, 36),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search hotels...',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 237, 83, 36)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Color.fromARGB(255, 237, 83, 36),
                      ),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    ),
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: hotels.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _searchController.text.isEmpty
                        ? hotels.length
                        : _searchHotels(_searchController.text).length,
                    itemBuilder: (context, index) {
                      final List<Hotel> displayedHotels =
                          _searchController.text.isEmpty
                              ? hotels
                              : _searchHotels(_searchController.text);
                      final Hotel hotel = displayedHotels[index];
                      return HotelCard(
                        name: hotel.name,
                        price: hotel.price,
                        location: hotel.location,
                        rating: ' ${hotel.rating.toString()}',
                        image: hotel.image,
                        onTapReserve: () => reserveHotel(hotel),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> reserveHotel(Hotel hotel) async {
    String bookingReference = _generateBookingReference();
    String userEmail = FirebaseAuth.instance.currentUser!.email!;

    await FirebaseFirestore.instance.collection('hotelBookings').add({
      'name': hotel.name,
      'price': hotel.price,
      'location': hotel.location,
      'rating': hotel.rating,
      'bookingDate': Timestamp.now(),
      'bookingReference': bookingReference,
      'email': userEmail, // Add the user's email to the document
    });

    // Navigate to GuestDetailsPage and pass the necessary data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuestDetailsPage(
          hotelBookingReference: bookingReference,
          price: hotel.price,
        ),
      ),
    );
  }
}

String _generateBookingReference() {
  // Generate a unique booking reference
  // You can use any logic you prefer, here's an example:
  return 'HT${DateTime.now().millisecondsSinceEpoch}';
}

class HotelCard extends StatelessWidget {
  final String name;
  final String price;
  final String location;
  final String rating;
  final String image;
  final VoidCallback onTapReserve;

  const HotelCard({
    Key? key,
    required this.name,
    required this.price,
    required this.location,
    required this.rating,
    required this.image,
    required this.onTapReserve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Rating: $rating',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: onTapReserve,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 237, 83, 36),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 62),
                ),
                child: const Text(
                  'Reserve',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
