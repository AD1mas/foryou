import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foryou/core/app_style.dart';
import 'package:foryou/services/supabase_service.dart';

import '../../../services/ai_service.dart';
import '../../widgets/inputs/chat_input.dart';
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

  final ScrollController _scrollController = ScrollController();

  bool isAtBottom = true;
  bool showScrollToBottom = false;

  @override
  void initState() {
    super.initState();
    loadMessages();
    subscribeToMessages();
    _scrollController.addListener(_onScroll);
  }

  void subscribeToMessages() {}

  Future<void> loadMessages() async {
    final data = await SupabaseService().getMessages();

    setState(() {
      messages = data;
      isLoading = false;
    });

    _scrollToBottom();
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

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;

    const threshold = 100;

    final atBottomNow = current >= (max - threshold);

    if (atBottomNow != isAtBottom) {
      setState(() {
        isAtBottom = atBottomNow;
        showScrollToBottom = !atBottomNow;
      });
    }
  }

  void _onNewMessage() {
    if (isAtBottom) {
      _scrollToBottom();
    } else {
      setState(() {
        showScrollToBottom = true;
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : StreamBuilder(
                        stream: _subscription,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            messages = snapshot.data ?? [];
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _onNewMessage();
                            });
                            if (kDebugMode) {
                              print(
                                "Stream updated: ${messages.isNotEmpty ? messages.last : 'No messages'}",
                              );
                            }
                          }
                          return ListView.builder(
                            controller: _scrollController,
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
                                        ? AppColors.blueColor
                                        : AppColors.lightGreyColor,
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
