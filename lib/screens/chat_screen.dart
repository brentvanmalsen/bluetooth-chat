import 'package:flutter/material.dart';
import 'package:flutter_application_bluetooth/main.dart';
import 'package:flutter_application_bluetooth/message.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Controller voor het invoerveld van berichten
  final messageController = TextEditingController();

  // Lijst van berichten
  final messages = <Message>[];

  @override
  void initState() {
    super.initState();
    // Luister naar inkomende berichten
    allBluetooth.listenForData.listen((event) {
      messages.add(Message(
        message: event.toString(),
        isMe: false,
      ));
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Maak de controller schoon bij het afsluiten van de widget
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bovenste balk met sluitknop
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              allBluetooth.closeConnection();
            },
            child: const Text("SLUIT"),
          ),
        ],
      ),
      // Lichaam van de chatinterface
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  // Weergave van het bericht met chatballon
                  child: ChatBubble(
                    clipper: ChatBubbleClipper4(
                      type: message.isMe
                          ? BubbleType.sendBubble
                          : BubbleType.receiverBubble,
                    ),
                    alignment: message.isMe ? Alignment.topRight : Alignment.topLeft,
                    child: Text(message.message),
                  ),
                );
              },
            ),
          ),
          // Invoerveld voor het typen van een nieuw bericht
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              // Knop om het bericht te verzenden
              IconButton(
                onPressed: () {
                  final message = messageController.text;
                  allBluetooth.sendMessage(message);
                  messageController.clear();
                  messages.add(
                    Message(
                      message: message,
                      isMe: true,
                    ),
                  );
                  setState(() {});
                },
                icon: const Icon(Icons.send),
              )
            ],
          )
        ],
      ),
    );
  }
}
