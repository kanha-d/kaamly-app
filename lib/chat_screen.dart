import 'package:flutter/material.dart';
import 'package:kaamly/chat_detail_screen.dart';
import '../../../core/theme/app_theme.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const chats = [
    _Chat(
      name: 'Rahul Furniture',
      message: 'I can complete it in 6 days.',
      time: '10:42 AM',
      unread: 2,
      online: true,
      icon: Icons.handyman_rounded,
    ),
    _Chat(
      name: 'Frame Studio',
      message: 'I have shared my portfolio.',
      time: 'Yesterday',
      unread: 0,
      online: false,
      icon: Icons.camera_alt_outlined,
    ),
    _Chat(
      name: 'CleanPro Services',
      message: 'Can we schedule it for Sunday?',
      time: 'Yesterday',
      unread: 1,
      online: true,
      icon: Icons.cleaning_services_outlined,
    ),
    _Chat(
      name: 'Anjali Makeup Studio',
      message: 'Thank you!',
      time: 'Mon',
      unread: 0,
      online: false,
      icon: Icons.face_retouching_natural,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                22,
                25,
                22,
                20,
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -.8,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Chat with your professionals',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ChatDetailScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.fromLTRB(
                22,
                0,
                22,
                20,
              ),
              height: 58,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppTheme.greyText,
                  ),
                  hintText: 'Search conversations',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, index) {
                return _ChatTile(
                  chat: chats[index],
                );
              },
              childCount: chats.length,
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 110),
          ),
        ],
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final _Chat chat;

  const _ChatTile({
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Later:
        // Open Firebase chat screen.
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 12,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1FF),
                    borderRadius:
                    BorderRadius.circular(18),
                  ),
                  child: Icon(
                    chat.icon,
                    color: AppTheme.primary,
                    size: 28,
                  ),
                ),

                if (chat.online)
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      height: 15,
                      width: 15,
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

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [
                Text(
                  chat.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.greyText,
                  ),
                ),

                const SizedBox(height: 8),

                if (chat.unread > 0)
                  Container(
                    height: 22,
                    width: 22,
                    decoration:
                    const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${chat.unread}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight:
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Chat {
  final String name;
  final String message;
  final String time;
  final int unread;
  final bool online;
  final IconData icon;

  const _Chat({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.online,
    required this.icon,
  });
}