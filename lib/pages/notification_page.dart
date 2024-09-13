import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: _buildNotificationList(),
    );
  }

  Widget _buildNotificationList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notifications')
          .where('userEmail',
              isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("No notifications"),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final notification = snapshot.data!.docs[index];
            final notificationDate =
                (notification['timestamp'] as Timestamp).toDate();
            return ListTile(
              title: Text(
                notification['title'],
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 237, 83, 36),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification['message'],
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Received on: ${_formatDate(notificationDate)}',
                    style: const TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 237, 83, 36),
                ),
                onPressed: () =>
                    _deleteNotification(context, notification.reference),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  Future<void> _deleteNotification(
      BuildContext context, DocumentReference notificationRef) async {
    try {
      await notificationRef.delete();
    } catch (error) {
      print("Error deleting notification: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleting notification. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
