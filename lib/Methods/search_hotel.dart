class Hotel {
  final String name;
  final String location;
  final double rating;
  final String price;
  final String image;

  Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.image,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(), // Convert to double
      price: json['price'] ?? '',
      image: json['image'] ??
          'default_image_path.jpg', // Provide a default image path or handle null case
    );
  }
}
