import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_app/main.dart';

void main() {
  testWidgets('Chatbot UI loads correctly', (WidgetTester tester) async {
    //build the app
    await tester.pumpWidget(ChatbotApp());

    //check if the AppBar title "Chatbot" exists
    expect(find.text('Chatbot'), findsOneWidget);

    //check if the text field for user input exists
    expect(find.byType(TextField), findsOneWidget);

    //check if the send button exists
    expect(find.byIcon(Icons.send), findsOneWidget);
  });
}
