import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/widgets/answer_option.dart';
import 'package:quiz_app/widgets/primary_button.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  void _submitQuiz(BuildContext context, QuizProvider provider) {
    provider.calculateScore();
    Navigator.pushReplacementNamed(context, '/score');
  }

  void _goBack(BuildContext context, QuizProvider provider) {
    if (provider.currentQuestionIndex == 0) {
      // Jika di soal pertama, kembali ke kategori
      Navigator.pop(context);
    } else {
      // Mundur ke soal sebelumnya
      provider.previousQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan Consumer untuk auto-rebuild saat state berubah
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        // Handle jika tidak ada pertanyaan (error)
        if (provider.questions.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('Gagal memuat pertanyaan. Coba lagi.'),
            ),
          );
        }

        final Question currentQuestion = provider.currentQuestion;
        final String? selectedAnswer =
        provider.selectedAnswers[currentQuestion.id];

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // 1. Custom App Bar
                  _buildCustomAppBar(context, provider),

                  // 2. Kartu Pertanyaan
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24.0),
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pertanyaan: ${provider.currentQuestionIndex + 1}/${provider.questions.length}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              currentQuestion.questionText,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // 3. Daftar Pilihan Jawaban
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: currentQuestion.options.length,
                              itemBuilder: (context, index) {
                                final option = currentQuestion.options[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  // Reusable Widget (Syarat #3)
                                  child: AnswerOption(
                                    text: option,
                                    isSelected: selectedAnswer == option,
                                    onTap: () {
                                      provider.selectAnswer(
                                          currentQuestion.id, option);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // 4. Tombol Navigasi
                  _buildNavigationButtons(context, provider),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget privat untuk merapikan 'build'
  Widget _buildCustomAppBar(BuildContext context, QuizProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'PPKN', // Kategori
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${provider.questions.length} Pertanyaan',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(BuildContext context, QuizProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol Kembali
          PrimaryButton(
            text: 'Kembali',
            onPressed: () => _goBack(context, provider),
            backgroundColor: Colors.white,
            textColor: Theme.of(context).primaryColor,
            elevation: 2.0,
            minWidth: 150,
          ),
          // Tombol Selanjutnya / Submit
          PrimaryButton(
            text: provider.isLastQuestion ? 'Submit' : 'Selanjutnya',
            onPressed: () {
              if (provider.isLastQuestion) {
                _submitQuiz(context, provider);
              } else {
                provider.nextQuestion();
              }
            },
            minWidth: 150,
          ),
        ],
      ),
    );
  }
}