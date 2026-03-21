import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foryou/core/app_style.dart';
import 'package:foryou/services/supabase_service.dart';

import '../../../services/ai_service.dart';
import '../../widgets/chat_input.dart';
import '../../widgets/hud/app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final AIService _aiService = AIService();
  final Stream<List<Map<String, dynamic>>> _subscription = SupabaseService()
      .subscribeToMessages();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
    subscribeToMessages();
  }

  void subscribeToMessages() {}

  Future<void> loadMessages() async {
    final data = await SupabaseService().getMessages();

    setState(() {
      messages = data;
      isLoading = false;
    });
  }

  void sendMessage() {
    if (_controller.text.isEmpty) return;

    _aiService.getResponse(_controller.text);
    setState(() {
      messages.add({"role": "user", "content": _controller.text});
    });

    _controller.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add({"role": "assistant", "content": "AI response..."});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chat"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.greyOpacityColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : StreamBuilder(
                        stream: _subscription,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            messages = snapshot.data!;
                            if (kDebugMode) {
                              print(
                                "Stream updated: ${messages.last} messages",
                              );
                            }
                          }
                          return ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final msg = messages[index];

                              return Align(
                                alignment: msg["role"] == "user"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: msg["role"] == "user"
                                        ? Colors.blue
                                        : Colors.grey[800],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(msg["content"] ?? ""),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
              ChatInput(controller: _controller, onSend: sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}
