import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class ChatDetailScreen extends StatefulWidget {
  final String providerName;

  const ChatDetailScreen({
    super.key,
    this.providerName = 'Rahul Furniture',
  });

  @override
  State<ChatDetailScreen> createState() =>
      _ChatDetailScreenState();
}

class _ChatDetailScreenState
    extends State<ChatDetailScreen> {
  final messageController =
  TextEditingController();

  final List<_Message> messages = [
    _Message(
      text: 'Hi! I saw your requirement.',
      isMe: false,
      time: '10:30 AM',
    ),
    _Message(
      text: 'Hi Rahul, yes. I need a custom wardrobe.',
      isMe: true,
      time: '10:32 AM',
    ),
    _Message(
      text:
      'Sure. I can make it according to your room size.',
      isMe: false,
      time: '10:35 AM',
    ),
    _Message(
      text:
      'Great. Can you share an estimated price?',
      isMe: true,
      time: '10:38 AM',
    ),
    _Message(
      text:
      'Around ₹18,500 including material and installation.',
      isMe: false,
      time: '10:42 AM',
    ),
  ];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1FF),
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppTheme.primary,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      color: const Color(0xFF27B36A),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 11),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  widget.providerName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF27A964),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.fromLTRB(
                18,
                20,
                18,
                20,
              ),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                return _MessageBubble(
                  message: messages[index],
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(
              12,
              10,
              12,
              12,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Container(
                      constraints:
                      const BoxConstraints(
                        minHeight: 48,
                      ),
                      decoration: BoxDecoration(
                        color:
                        const Color(0xFFF3F4F6),
                        borderRadius:
                        BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller:
                        messageController,
                        minLines: 1,
                        maxLines: 4,
                        decoration:
                        const InputDecoration(
                          hintText:
                          'Type a message...',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 13,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration:
                      const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text =
    messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(
        _Message(
          text: text,
          isMe: true,
          time: 'Now',
        ),
      );
    });

    messageController.clear();
  }
}

class _MessageBubble extends StatelessWidget {
  final _Message message;

  const _MessageBubble({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
          MediaQuery.of(context).size.width *
              .76,
        ),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: message.isMe
              ? AppTheme.primary
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(
              message.isMe ? 20 : 5,
            ),
            bottomRight: Radius.circular(
              message.isMe ? 5 : 20,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isMe
                    ? Colors.white
                    : const Color(0xFF24272D),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 9,
                color: message.isMe
                    ? Colors.white
                    .withOpacity(.75)
                    : AppTheme.greyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;
  final String time;

  const _Message({
    required this.text,
    required this.isMe,
    required this.time,
  });
}