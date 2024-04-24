class Flight {
  final String flightNumber;
  final String departure;
  final String arrival;
  final String departureDate;
  final String departureTime;
  final int availableSeats;
  final String price;
  final String status;

  Flight({
    required this.flightNumber,
    required this.departure,
    required this.arrival,
    required this.departureDate,
    required this.departureTime,
    required this.availableSeats,
    required this.price,
    required this.status,
  });

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      flightNumber: json['FlightNumber'] ?? json['uniqueID'],
      departure: json['Departure'],
      arrival: json['Arrival'],
      departureDate: json['DepartureDate'],
      departureTime: json['DepartureTime'],
      availableSeats: json['AvailableSeats'],
      price: json['Price'],
      status: json['Status'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'flightNumber': flightNumber,
      'departure': departure,
      'arrival': arrival,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'availableSeats': availableSeats,
      'price': price,
      'status': status,
    };
  }
}

List<Flight> flights = [
  {
    "FlightNumber": "FL001",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Blantyre (BLT)",
    "DepartureDate": "2024-04-30",
    "DepartureTime": "08:30",
    "AvailableSeats": 50,
    "Price": "120000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL010",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Blantyre (BLT)",
    "DepartureDate": "2024-05-10",
    "DepartureTime": "13:30",
    "AvailableSeats": 50,
    "Price": "120000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL002",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Cape Town (CPT)",
    "DepartureDate": "2024-05-3",
    "DepartureTime": "10:00",
    "AvailableSeats": 60,
    "Price": "200000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL003",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Mombasa (MBA)",
    "DepartureDate": "2024-05-13",
    "DepartureTime": "09:45",
    "AvailableSeats": 45,
    "Price": "150000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL004",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Johannesburg (JNB)",
    "DepartureDate": "2024-05-1",
    "DepartureTime": "11:20",
    "AvailableSeats": 55,
    "Price": "140000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL005",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Lagos (LOS)",
    "DepartureDate": "2024-05-7",
    "DepartureTime": "08:00",
    "AvailableSeats": 40,
    "Price": "125000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL006",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Zanzibar City (ZNZ)",
    "DepartureDate": "2024-05-16",
    "DepartureTime": "10:30",
    "AvailableSeats": 65,
    "Price": "155000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL007",
    "Departure": "Lilongew (LLW)",
    "Arrival": "Dar es Salaam (DAR)",
    "DepartureDate": "2024-05-2",
    "DepartureTime": "09:15",
    "AvailableSeats": 70,
    "Price": "160000",
    "Status": "Active"
  },
  {
    "FlightNumber": "FL008",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Kigali (KGL)",
    "DepartureDate": "2024-05-9",
    "DepartureTime": "11:45",
    "AvailableSeats": 48,
    "Price": "220000",
    "Status": "Active"
  },
  {
    "uniqueID": "FL009",
    "Departure": "Lilongwe (LLW)",
    "Arrival": "Accra (ACC)",
    "DepartureDate": "2024-04-29",
    "DepartureTime": "08:45",
    "AvailableSeats": 53,
    "Price": "145000",
    "Status": "Active"
  }
  // Add more flight data here...
].map((json) => Flight.fromJson(json)).toList();

List<Flight> searchFlightsByArrival(String toCity, String travelClass) {
  List<Flight> results = flights
      .where((flight) =>
          flight.arrival.toLowerCase().contains(toCity.toLowerCase()))
      .toList();

  if (travelClass == 'Business') {
    results = results
        .map((flight) => Flight(
              flightNumber: flight.flightNumber,
              departure: flight.departure,
              arrival: flight.arrival,
              departureDate: flight.departureDate,
              departureTime: flight.departureTime,
              availableSeats: flight.availableSeats,
              price: (int.parse(flight.price) * 2).toString(),
              status: flight.status,
            ))
        .toList();
  } else if (travelClass == 'First Class') {
    results = results
        .map((flight) => Flight(
              flightNumber: flight.flightNumber,
              departure: flight.departure,
              arrival: flight.arrival,
              departureDate: flight.departureDate,
              departureTime: flight.departureTime,
              availableSeats: flight.availableSeats,
              price: (int.parse(flight.price) * 3).toString(),
              status: flight.status,
            ))
        .toList();
  }

  return results;
}
