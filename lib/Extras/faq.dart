import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<QuestionAnswer> faqs = [
    QuestionAnswer(
      question: 'How do I book a flight?',
      answer:
          'To book a flight, you can either visit our website or use our mobile app. Select your destination, travel dates, and preferred flight times. Then proceed to payment to confirm your booking.',
    ),
    QuestionAnswer(
      question: 'Can I cancel or change my booking?',
      answer:
          'Yes, you can cancel or change your booking depending on the fare rules associated with your ticket. Please refer to our cancellation and change policies or contact our customer support for assistance.',
    ),
    QuestionAnswer(
      question: 'How can I contact customer support?',
      answer:
          'You can contact our customer support team via phone, email, or live chat. Visit our website for contact details or access the support options in our mobile app.',
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
    // Add more FAQs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqs[index].question,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  faqs[index].answer,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({required this.question, required this.answer});
}
