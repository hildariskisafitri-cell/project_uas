import 'package:flutter/material.dart';
import 'package:edu_quiz/core/theme/app_theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;
  const QuizScreen({super.key, required this.category});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;

  final List<Map<String, dynamic>> _dummyQuestions = [
    {
      'question': 'What is the full form of CPU?',
      'options': ['Central Process Unit', 'Central Processing Unit', 'Computer Processing Unit', 'Control Process Unit'],
      'correctIndex': 1,
    },
    {
      'question': 'Which programming language is used for Flutter?',
      'options': ['Java', 'Swift', 'Kotlin', 'Dart'],
      'correctIndex': 3,
    },
    {
      'question': 'What does HTML stand for?',
      'options': ['Hyper Text Markup Language', 'High Tech Modern Language', 'Hyper Tool Multi Language', 'None of these'],
      'correctIndex': 0,
    },
  ];

  void _handleAnswer(int index) {
    if (_isAnswered) return;
    
    setState(() {
      _selectedOptionIndex = index;
      _isAnswered = true;
      if (index == _dummyQuestions[_currentQuestionIndex]['correctIndex']) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (_currentQuestionIndex < _dummyQuestions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOptionIndex = null;
          _isAnswered = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: _score,
              totalQuestions: _dummyQuestions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _dummyQuestions[_currentQuestionIndex];
    double progress = (_currentQuestionIndex + 1) / _dummyQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            LinearPercentIndicator(
              lineHeight: 12.0,
              percent: progress,
              backgroundColor: Colors.grey[200],
              progressColor: AppTheme.primaryColor,
              barRadius: const Radius.circular(10),
              animation: true,
              animateFromLastPercent: true,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${_currentQuestionIndex + 1}/${_dummyQuestions.length}",
                  style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                ),
                const Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 18, color: Colors.red),
                    SizedBox(width: 4),
                    Text("15s", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    question['question'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().scale(),
                  const SizedBox(height: 40),
                  ...List.generate(
                    question['options'].length,
                    (index) => _buildOptionButton(index, question['options'][index], question['correctIndex']),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(int index, String text, int correctIndex) {
    Color? buttonColor = Colors.white;
    Color textColor = Colors.black87;
    IconData? icon;

    if (_isAnswered) {
      if (index == correctIndex) {
        buttonColor = Colors.green[100];
        textColor = Colors.green[800]!;
        icon = Icons.check_circle_rounded;
      } else if (index == _selectedOptionIndex) {
        buttonColor = Colors.red[100];
        textColor = Colors.red[800]!;
        icon = Icons.cancel_rounded;
      }
    } else if (_selectedOptionIndex == index) {
      buttonColor = AppTheme.primaryColor.withOpacity(0.1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _handleAnswer(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isAnswered && index == correctIndex 
                ? Colors.green 
                : _isAnswered && index == _selectedOptionIndex 
                  ? Colors.red 
                  : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: const TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              if (icon != null) Icon(icon, color: textColor),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX();
  }
}
