import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/widgets/category_card.dart'; // Import widget baru

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  // Fungsi untuk memilih kategori
  void _selectCategory(BuildContext context, String categoryName) {
    // Muat pertanyaan berdasarkan kategori (Syarat #7)
    // 'listen: false' wajib di dalam fungsi
    Provider.of<QuizProvider>(context, listen: false).loadQuestions(categoryName);

    // Navigasi ke halaman pertanyaan (Syarat #2)
    Navigator.pushNamed(context, '/question');
  }

  @override
  Widget build(BuildContext context) {
    // Ambil nama pengguna dari Provider
    // Kita pakai context.watch agar otomatis update jika nama berubah
    final String username = context.watch<QuizProvider>().username;

    // Kategori dummy
    final List<String> categories = [
      'PPKN',
      'Biologi',
      'Matematika',
      'Kimia',
      'Seni'
    ];

    return Scaffold(
      // Kita pakai SafeArea agar tidak tertutup notch/statusbar
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Teks sapaan sesuai mockup image_f8447a.png
              Text(
                'Halo, $username', // Menampilkan nama pengguna dari Provider
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Tampilkan daftar kategori
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      // Reusable Widget
                      child: CategoryCard(
                        categoryName: category,
                        onTap: () {
                          //  punya soal PPKN
                          if (category == 'PPKN') {
                            _selectCategory(context, category);
                          } else {
                            // Tampilkan pesan jika kategori lain dipilih
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Kuis $category belum tersedia.'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}