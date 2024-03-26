import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Blueberry Travel'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Blueberry Travel Limited Malawi',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Since its establishment in Djibouti in 2013, Blueberry has become a renowned global travel management company that\'s highly regarded within the industry. With clients such as multinational corporations, international NGOs, and UN agencies on their books, Blueberry offers an extensive network of more than 200 airlines worldwide at competitive rates for flights and hotel accommodations alike.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Blueberry Travel Malawi Limited is one arm among many other branches under this prestigious firm, spreading all over Africa. Their strong presence speaks volumes about Blueberry\'s dominance in managing travels and catering services efficiently throughout Africa by offering diverse ticketing options for individuals or companies who desire quality assistance when planning overseas trips without breaking budgets.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Operating tirelessly with round-the-clock service availability, including public holidays, demonstrates the exceptional level of customer dedication they consistently deliver to clients globally.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
