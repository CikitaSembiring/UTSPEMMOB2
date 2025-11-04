import 'package:flutter/foundation.dart';
import 'package:quiz_app/models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _username = "Username";
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  Map<String, String> _selectedAnswers = {}; // Menyimpan jawaban (ID Soal, Jawaban)

  String get username => _username;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  Map<String, String> get selectedAnswers => _selectedAnswers;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  bool get isLastQuestion => _currentQuestionIndex == _questions.length - 1;

  void setUsername(String name) {
    _username = name.isNotEmpty ? name : "Username";
    notifyListeners();
  }

  // Memuat data dummy (Syarat #8)
  void loadQuestions(String category) {
    // Di aplikasi nyata, ini bisa mengambil data dari API atau DB
    // Untuk UTS, kita gunakan data dummy PPKN
    if (category == "PPKN") {
      _questions = [
        Question(
          id: '1',
          questionText: 'Siapa presiden pertama Indonesia?',
          options: ['Soekarno', 'Megawati', 'Joko Widodo', 'BJ Habibie'],
          correctAnswer: 'Soekarno',
        ),
        Question(
          id: '2',
          questionText: 'Dasar negara Indonesia adalah',
          options: ['UUD 1945', 'Pancasila', 'Bhineka Tunggal Ika', 'Garuda Pancasila'],
          correctAnswer: 'Pancasila',
        ),
        Question(
          id: '3',
          questionText: 'Bentuk pemerintahan Indonesia adalah',
          options: ['Kerajaan', 'Republik', 'Federasi', 'Monarki'],
          correctAnswer: 'Republik',
        ),
        Question(
          id: '4',
          questionText: 'Pembacaan teks proklamasi dilakukan oleh?',
          options: ['Soekarno', 'Bung Tarno', 'Jen. Sudirman', 'Hatta'],
          correctAnswer: 'Soekarno',
        ),
        Question(
          id: '5',
          questionText: 'Warna dasar bendera Indonesia adalah',
          options: ['Merah dan Putih', 'Merah dan Biru', 'Putih dan Merah', 'Putih dan Biru'],
          correctAnswer: 'Merah dan Putih',
        ),
      ];
    } else {
      _questions = []; // Kategori lain belum ada
    }
    // Reset progres saat memuat kuis baru
    resetQuiz();
    notifyListeners();
  }

  void selectAnswer(String questionId, String answer) {
    _selectedAnswers[questionId] = answer;
    notifyListeners();
  }

  void nextQuestion() {
    if (!isLastQuestion) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void calculateScore() {
    _score = 0;
    for (var question in _questions) {
      if (_selectedAnswers[question.id] == question.correctAnswer) {
        _score++;
      }
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedAnswers = {};
    notifyListeners();
  }
}