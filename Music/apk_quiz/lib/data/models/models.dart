class Question {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map, String id) {
    return Question(
      id: id,
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctIndex: map['correctIndex'] ?? 0,
    );
  }
}

class Quiz {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    this.questions = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'difficulty': difficulty,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map, String id) {
    return Quiz(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
    );
  }
}

class AppUser {
  final String uid;
  final String name;
  final String email;
  final int score;
  final int level;
  final int xp;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    this.score = 0,
    this.level = 1,
    this.xp = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'score': score,
      'level': level,
      'xp': xp,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      score: map['score'] ?? 0,
      level: map['level'] ?? 1,
      xp: map['xp'] ?? 0,
    );
  }
}

class QuizResult {
  final String id;
  final String userId;
  final String quizId;
  final int score;
  final DateTime timestamp;

  QuizResult({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.score,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'quizId': quizId,
      'score': score,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map, String id) {
    return QuizResult(
      id: id,
      userId: map['userId'] ?? '',
      quizId: map['quizId'] ?? '',
      score: map['score'] ?? 0,
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }
}
