import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchHistoryPage extends StatefulWidget {
  @override
  _SearchHistoryPageState createState() => _SearchHistoryPageState();
}

class _SearchHistoryPageState extends State<SearchHistoryPage> {
  late User? currentUser; // Initialize as nullable

  @override
  void initState() {
    super.initState();
    // Listen to authentication state changes
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        currentUser =
            user; // Update currentUser when authentication state changes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search History'),
      ),
      body: currentUser != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('searchHistory')
                  .where('userEmail', isEqualTo: currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final searchHistoryDocs = snapshot.data!.docs;
                if (searchHistoryDocs.isEmpty) {
                  return Center(child: Text('No search history found.'));
                }

                return ListView.builder(
                  itemCount: searchHistoryDocs.length,
                  itemBuilder: (context, index) {
                    final historyData =
                        searchHistoryDocs[index].data() as Map<String, dynamic>;
                    final fromCity = historyData['fromCity'] as String;
                    final toCity = historyData['toCity'] as String;
                    final travelClass = historyData['travelClass'] as String;
                    final searchDate = historyData['searchDate'] as Timestamp;

                    return ListTile(
                      title: Text(
                          'From: $fromCity, To: $toCity, Class: $travelClass'),
                      subtitle: Text('Searched on: ${searchDate.toDate()}'),
                    );
                  },
                );
              },
            )
          : Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator if currentUser is null
            ),
    );
  }
}
