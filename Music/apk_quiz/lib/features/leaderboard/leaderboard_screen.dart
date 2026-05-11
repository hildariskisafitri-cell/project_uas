import 'package:flutter/material.dart';
import 'package:edu_quiz/core/theme/app_theme.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> users = [
      {'name': 'Alex Johnson', 'score': 2450, 'rank': 1, 'avatar': 'AJ'},
      {'name': 'Sarah Smith', 'score': 2300, 'rank': 2, 'avatar': 'SS'},
      {'name': 'John Doe', 'score': 2150, 'rank': 3, 'avatar': 'JD'},
      {'name': 'Emma Wilson', 'score': 1900, 'rank': 4, 'avatar': 'EW'},
      {'name': 'Michael Brown', 'score': 1850, 'rank': 5, 'avatar': 'MB'},
      {'name': 'You', 'score': 1200, 'rank': 15, 'avatar': 'Y'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Leaderboard"),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTopRanker(users[1], 100),
                _buildTopRanker(users[0], 130, isFirst: true),
                _buildTopRanker(users[2], 100),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length - 3,
              itemBuilder: (context, index) {
                final user = users[index + 3];
                return _buildLeaderboardTile(user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRanker(Map<String, dynamic> user, double height, {bool isFirst = false}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            if (isFirst)
              const Icon(Icons.workspace_premium_rounded, color: Colors.amber, size: 30),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: CircleAvatar(
                radius: isFirst ? 40 : 30,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Text(
                  user['avatar'],
                  style: TextStyle(
                    fontSize: isFirst ? 24 : 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          user['name'],
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          "${user['score']} pts",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLeaderboardTile(Map<String, dynamic> user) {
    bool isMe = user['name'] == 'You';
    return Card(
      color: isMe ? AppTheme.primaryColor.withOpacity(0.05) : null,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "#${user['rank']}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isMe ? AppTheme.primaryColor : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundColor: isMe ? AppTheme.primaryColor : Colors.grey[200],
              child: Text(
                user['avatar'],
                style: TextStyle(color: isMe ? Colors.white : Colors.black87),
              ),
            ),
          ],
        ),
        title: Text(
          user['name'],
          style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal),
        ),
        trailing: Text(
          "${user['score']} pts",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
