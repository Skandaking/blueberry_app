import 'package:flutter/material.dart';

class TicketView extends StatelessWidget {
  final Map<String, dynamic> flight;

  const TicketView({Key? key, required this.flight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${flight['from']['code']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                          width: 80), // Add space between "from" and icon
                      Transform.rotate(
                        angle: 1.5, // Adjust the angle as needed
                        child: const Icon(Icons.local_airport_rounded,
                            size: 30, color: Colors.white),
                      ),
                      const SizedBox(width: 80),
                      Text(
                        '${flight['to']['code']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Second row wrapped with SingleChildScrollView
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Adjusted alignment
                      children: [
                        Text(
                          '${flight['from']['name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          '${flight['flying_time']}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 40),
                        Text(
                          '${flight['to']['name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  // topLeft: Radius.circular(10),
                  //  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Adjust as needed
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Number',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Flight ${flight['number']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${flight['date']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Departure time',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${flight['departure_time']}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
