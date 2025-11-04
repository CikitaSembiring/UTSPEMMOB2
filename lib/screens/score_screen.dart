import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/widgets/primary_button.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final screenSize = MediaQuery.of(context).size;

    // Logika Skor (3, 4, 5 = Selamat; 0, 1, 2 = Jangan Menyerah)
    final bool isSuccess = provider.score >= 3;
    final String title = isSuccess ? 'Selamat!' : 'Jangan Menyerah!';
    final String message = isSuccess
        ? '${provider.username} anda berhasil!'
        : '${provider.username} tetap semangat!';
    final Color scoreColor =
    isSuccess ? Theme.of(context).primaryColor : Colors.orange.shade800;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lingkaran Skor (Dinamis - Syarat #6)
              Container(
                width: screenSize.width * 0.6,
                height: screenSize.width * 0.6,
                decoration: BoxDecoration(
                  color: scoreColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: scoreColor.withAlpha(128),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Skor Anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${provider.score}/${provider.questions.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Pesan Hasil
              Text(
                title,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 64),
              // Tombol Kembali
              PrimaryButton(
                text: 'KEMBALI',
                onPressed: () {
                  // Kembali ke halaman kategori, reset semua state
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/category',
                        (route) => false, // Hapus semua rute sebelumnya
                  );
                },
                minWidth: screenSize.width * 0.7,
                backgroundColor: scoreColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}