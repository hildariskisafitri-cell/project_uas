import 'package:flutter/material.dart';
import 'package:edu_quiz/core/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (score / totalQuestions) * 100;
    String message = percentage >= 70 ? "Excellent Job!" : percentage >= 40 ? "Good Try!" : "Keep Learning!";
    IconData icon = percentage >= 70 ? Icons.emoji_events_rounded : percentage >= 40 ? Icons.thumb_up_rounded : Icons.menu_book_rounded;
    Color color = percentage >= 70 ? Colors.amber : percentage >= 40 ? Colors.blue : Colors.orange;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Quiz Completed!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 100, color: color),
              ).animate().scale(duration: 600.ms, curve: Curves.backOut),
              const SizedBox(height: 24),
              Text(
                message,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
              ),
              const SizedBox(height: 16),
              Text(
                "You scored $score out of $totalQuestions",
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 40),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat("Score", "$score"),
                      const VerticalDivider(),
                      _buildStat("Accuracy", "${percentage.toInt()}%"),
                      const VerticalDivider(),
                      _buildStat("XP Gained", "+${score * 10}"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Try Again"),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
