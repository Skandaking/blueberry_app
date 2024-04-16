import 'package:blueberry_app/componets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _selectedCategory = 'Flight';
  String? _fullName;
  String? _userEmail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    final User? currentUser = _auth.currentUser;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if (currentUser != null) {
      final DocumentSnapshot userSnapshot =
          await _firestore.collection('Users').doc(currentUser.email).get();

      final userData = userSnapshot.data() as Map<String, dynamic>;

      setState(() {
        _fullName = '${userData['Firstname']} ${userData['Lastname']}';
        _userEmail = currentUser.email;
        _isLoading = false;
      });
    } else {
      setState(() {
        _fullName = 'User Name';
        _userEmail = 'user@example.com';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.message,
                        size: 60,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Help us improve',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your feedback is important to us and helps us improve our services.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        items: const ['Flight', 'Hotel']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _fullName ?? 'User Name',
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _userEmail ?? 'user@example.com',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        enabled: false,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _feedbackController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          labelText: 'Feedback',
                          hintText: 'Enter your feedback here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        onTap: () {
                          _submitFeedback();
                        },
                        text: 'Submit Feedback',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _submitFeedback() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      await _firestore.collection('Reviews').add({
        'Category': _selectedCategory,
        'Fullname': _fullName,
        'Email': _userEmail,
        'Feedback': _feedbackController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback submitted successfully!'),
        ),
      );

      _feedbackController.clear();
    }
  }
}
