import 'package:flutter/material.dart';

class FlightView extends StatelessWidget {
  FlightView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(
              'Explore Our Fleet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildFlightCarousel(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightCarousel() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: flightImages.length,
      itemBuilder: (context, index) => _buildFlightCard(flightImages[index]),
    );
  }

  Widget _buildFlightCard(String imagePath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      child: SizedBox(
        width: 200.0,
        height: 450.0, // Fixed height for each card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 320.0, // Specify a finite height for the image
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.black
                        .withOpacity(0.5), // Background color for image name
                    child: Text(
                      // Extract the image name from the path (assuming a specific format)
                      imagePath.split('/').last.split('.').first,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white, // Text color for image name
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Flight Description', // Replace with actual flight description
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            const Text(
              'Additional details about the flight...', // Replace with actual flight details
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Replace this list with the actual paths to your flight images in the 'lib' folder
  final List<String> flightImages = [
    'lib/images/daniel.jpg',
    'lib/images/rahul.jpg',
    'lib/images/jason.jpg',
    'lib/images/athena.jpg',
  ];
}
