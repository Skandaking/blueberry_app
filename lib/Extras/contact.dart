import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Welcome to Our Support Center!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 237, 83, 36),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              'Our team is ready to assist you. Please feel free to reach out to us with any questions, concerns, or feedback.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            _buildContactOptions(),
            const SizedBox(height: 40.0),
            const Text(
              'Send us a Message',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            _buildContactForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildContactButton(
          icon: Icons.phone,
          label: 'Call Us',
          onPressed: () => _launchCaller('+1234567890'),
        ),
        _buildContactButton(
          icon: Icons.email,
          label: 'Email Us',
          onPressed: () => _launchEmail('info@example.com'),
        ),
        _buildContactButton(
          icon: Icons.message,
          label: 'Text Us',
          onPressed: () => _launchSMS('+1234567890'),
        ),
      ],
    );
  }

  Widget _buildContactButton(
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          iconSize: 40.0,
          onPressed: onPressed,
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  Widget _buildContactForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _topicController,
            decoration: const InputDecoration(
              labelText: 'Topic',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a topic';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Message',
              hintText: 'Enter your message here',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          TextButton(
            onPressed: () {
              _submitForm();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                const Color.fromARGB(255, 237, 83, 36),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_topicController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not logged in.'),
          ),
        );
        return;
      }

      final collectionRef = _firestore.collection('contact_messages');
      await collectionRef.add({
        'topic': _topicController.text,
        'message': _messageController.text,
        'email': currentUser.email,
        'timestamp': Timestamp.now(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message submitted successfully!'),
        ),
      );
      _topicController.clear();
      _messageController.clear();
    } catch (e) {
      print('Error submitting message: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  Future<void> _launchCaller(String phoneNum) async {
    final url = 'tel:$phoneNum';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch call app'),
        ),
      );
    }
  }

  Future<void> _launchEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch email app'),
        ),
      );
    }
  }

  Future<void> _launchSMS(String phoneNum) async {
    final url = 'sms:$phoneNum';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not launch SMS app'),
        ),
      );
    }
  }
}
