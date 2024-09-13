import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late List<QuestionAnswer> faqs;
  late List<QuestionAnswer> filteredFaqs;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    faqs = [
      QuestionAnswer(
        question: 'How do I book a flight?',
        answer:
            'To book a flight, you can go to book page . enter your location(nearest airport), your destination, traval dates and select your preferred fare option click on search flight. from the list that will diplay select the flight you want to book',
      ),
      QuestionAnswer(
        question: 'Can I cancel or change my booking?',
        answer:
            'Yes, you can cancel or change your booking depending on the fare rules associated with your ticket. Please refer to our cancellation and change policies or contact our customer support for assistance.',
      ),
      QuestionAnswer(
        question: 'How can I contact customer support?',
        answer:
            'You can contact our customer support team via phone, email, or sendign a message, on customer support page.',
      ),
      QuestionAnswer(
        question: 'What payment methods do you accept?',
        answer:
            'We accept various payment methods including credit/debit cards, bank transfers, and mobile money. You can choose the preferred payment option during the booking process.',
      ),
      QuestionAnswer(
        question: 'Are there any baggage restrictions?',
        answer:
            'Yes, there are baggage restrictions depending on the airline and fare type. Please check the baggage allowance section during the booking process or contact us for more information.',
      ),
      QuestionAnswer(
        question: 'Do you offer travel insurance?',
        answer:
            'Yes, we offer travel insurance options for your convenience. You can add travel insurance to your booking during the checkout process.',
      ),
      QuestionAnswer(
        question: 'Can I book flights for multiple passengers?',
        answer:
            'Yes, you can book flights for multiple passengers in a single transaction. Simply select the number of passengers and provide their details during the booking process.',
      ),
      QuestionAnswer(
        question: 'What happens if my flight is delayed or canceled?',
        answer:
            'In case of flight delays or cancellations, we will assist you in rebooking your flight or provide alternative options based on the airline policies and availability.',
      ),
      QuestionAnswer(
        question: 'Do you offer group bookings?',
        answer:
            'Yes, we offer group booking services for flights and hotels. Please contact our group booking department for assistance with group travel arrangements.',
      ),
      QuestionAnswer(
        question: 'Can I book flights for multiple passengers?',
        answer:
            'Yes, you can book flights for multiple passengers in a single transaction. Simply select the number of passengers and provide their details during the booking process.',
      ),
      QuestionAnswer(
        question: 'What happens if my flight is delayed or canceled?',
        answer:
            'In case of flight delays or cancellations, we will assist you in rebooking your flight or provide alternative options based on the airline policies and availability.',
      ),
      QuestionAnswer(
        question: 'Do you offer group bookings?',
        answer:
            'Yes, we offer group booking services for flights and hotels. Please contact our group booking department for assistance with group travel arrangements.',
      ),
      // Add more FAQs as needed
    ];
    filteredFaqs = faqs;
  }

  void _filterFaqs(String query) {
    setState(() {
      filteredFaqs = faqs
          .where((faq) =>
              faq.question.toLowerCase().contains(query.toLowerCase()) ||
              faq.answer.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(
                  color: Color.fromARGB(255, 237, 83, 36),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 237, 83, 36),
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterFaqs,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFaqs.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(
                    filteredFaqs[index].question,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        filteredFaqs[index].answer,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}
