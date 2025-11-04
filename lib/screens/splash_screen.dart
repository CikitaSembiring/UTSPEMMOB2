import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/widgets/primary_button.dart'; // Import widget yang baru dibuat

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Fungsi untuk navigasi ke halaman home
  void _goToHome() {
    // Navigasi
    // pushReplacementNamed berarti halaman ini diganti
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Terapkan latar belakang ungu dengan gambar
        decoration: const BoxDecoration(
          color: Color(0xFF673AB7), // Warna ungu dari mockup
          image: DecorationImage(
            image: AssetImage("assets/images/question_bg.jpg"),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Judul "QuiZ" dengan font kustom (Syarat #5)
            // Sesuai mockup image_f84061.png
            Text(
              'QuiZ',
              style: GoogleFonts.playfairDisplay( // Font kustom
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 100),

            // Tombol MASUK (Reusable Widget - Syarat #3)
            PrimaryButton(
              text: 'MASUK',
              onPressed: _goToHome, // Panggil fungsi navigasi saat ditekan
              backgroundColor: Colors.white,
              textColor: const Color(0xFF4F00C8), // Warna ungu tua
              // Ukuran dinamis (Syarat #6)
              minWidth: MediaQuery.of(context).size.width * 0.7,
            ),
          ],
        ),
      ),
    );
  }
}