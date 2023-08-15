import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geppetto_mobile/presentation/utils/dialog_utils.dart';
import 'package:geppetto_mobile/presentation/utils/typing_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SolvIAScreen extends StatefulWidget {
  const SolvIAScreen({Key? key}) : super(key: key);

  @override
  _SolvIAScreenState createState() => _SolvIAScreenState();
}

class _SolvIAScreenState extends State<SolvIAScreen> {
  List<Message> messages = [
    Message(
      "HELLO WORLD! Soy GEPPETTO, una IA 🧠 creada para el curso de metodos numéricos en la UTN🎓 sede Guanacaste, y estoy aqui para ayudarte con tus problemas matemáticos 👀",
      false,
    ),
  ];
  TextEditingController _textEditingController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;

  void _sendMessage(String text) async {
    setState(() {
      messages.add(Message(text, true));
    });

    _textEditingController.clear();

    final apiUrl =
        "https://api-python-matematicas.onrender.com/api/problemasAI/";
    try {
      isLoading=true;
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'charset': 'UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "prompt": text,
          },
        ),
      );

      Map<String, dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      isLoading=true;
      if (jsonResponse['Status'] == "true") {
        String answer = jsonResponse['Respuesta'];

        setState(() {
          messages.add(Message(answer, false));
          errorMessage = ''; // Clear any previous error messages
        });
      } else {
        setState(() {
          errorMessage = '${jsonResponse['Mensaje']} 🤔';
        });
        DialogUtils.showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Algo salió mal al hacer la solicitud';
      });
      DialogUtils.showErrorDialog(context, errorMessage);
    }

    isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/logo-gpto.svg',
              width: 45,
            ),
            const Text(
              "GEPPETTO",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  text: message.text,
                  isUser: message.isUser,
                );
              },
            ),
          ),
          TypingIndicator(isTyping: isLoading),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Escribe tu pregunta",
                      filled: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.white,),
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red)),
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      _sendMessage(_textEditingController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message(this.text, this.isUser);
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const MessageBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
