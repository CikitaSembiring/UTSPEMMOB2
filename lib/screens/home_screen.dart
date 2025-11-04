import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/widgets/primary_button.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller untuk mengambil teks dari input field
  final TextEditingController _nameController = TextEditingController();

  void _startGame() {
    // Ambil nama dari controller dan hilangkan spasi di awal/akhir
    final String username = _nameController.text.trim();

    // Validasi: Pastikan nama tidak kosong
    if (username.isNotEmpty) {
      // Simpan nama ke state management (Syarat #7)
      // 'listen: false' wajib ada di dalam fungsi/event
      Provider.of<QuizProvider>(context, listen: false)
          .setUsername(username);

      // Navigasi ke halaman kategori (Syarat #2)
      Navigator.pushReplacementNamed(context, '/category');
    } else {
      // Tampilkan peringatan jika nama kosong
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama pengguna tidak boleh kosong!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Penting untuk membersihkan controller saat widget tidak lagi digunakan
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ukuran dinamis (Syarat #6)
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Latar belakang yang sama dengan Splash Screen
        decoration: const BoxDecoration(
          color: Color(0xFF673AB7), // Warna ungu dari mockup
          image: DecorationImage(
            image: AssetImage("assets/images/question_bg.jpg"), // PASTIKAN .jpg
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        // Gunakan SingleChildScrollView agar tidak error saat keyboard muncul
        child: SingleChildScrollView(
          child: Container(
            // Pastikan tinggi konten minimal setinggi layar
            height: screenSize.height,
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Teks "Ayo Tes Pengetahuan Anda"
                // Sesuai mockup image_f843fe.png
                Text(
                  'Ayo Tes',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 48,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Pengetahuan Anda',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 40,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),

                // Input Nama Pengguna
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'NAMA PENGGUNA',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol MULAI (Reusable Widget - Syarat #3)
                PrimaryButton(
                  text: 'MULAI',
                  onPressed: _startGame,
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFF4F00C8),
                  minWidth: screenSize.width * 0.8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}