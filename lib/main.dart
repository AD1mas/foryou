import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChatScreen());
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<String>? _responseFuture;

  Future<String> generateResponse(String prompt) async {
    final url = Uri.parse("http://127.0.0.1:8000/generate");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"text": prompt}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response']['content'];
    } else {
      throw Exception("Failed to generate response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Streamer Brain Flutter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Type your prompt...",
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _responseFuture = generateResponse(_controller.text);
                });
              },
              child: const Text("Generate"),
            ),
            const SizedBox(height: 20),
            _responseFuture == null
                ? const SizedBox()
                : FutureBuilder<String>(
                    future: _responseFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(fontSize: 16),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
