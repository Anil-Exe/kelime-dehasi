import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  String _getMessage(int correctCount) {
    if (correctCount <= 3) return "Çalışmaya devam et!";
    if (correctCount <= 7) return "İyi iş çıkardın!";
    return "Mükemmel!";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final score = provider.score;
    final correctCount = provider.correctAnswers;
    final wrongCount = provider.wrongAnswers;
    final isHighScore = score > 0 && score >= provider.highScore;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Oyun Bitti!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            if (isHighScore)
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "🏆 YENİ REKOR! 🏆",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.cyanAccent, width: 4),
                color: Colors.white10,
              ),
              child: Column(
                children: [
                  Text(
                    "$score",
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.amberAccent),
                  ),
                  const Text("Puan", style: TextStyle(fontSize: 16, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.greenAccent, size: 30),
                    Text("$correctCount Doğru", style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    const Icon(Icons.cancel, color: Colors.redAccent, size: 30),
                    Text("$wrongCount Yanlış", style: const TextStyle(fontSize: 18, color: Colors.redAccent)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              _getMessage(correctCount),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                context.read<QuizProvider>().resetQuiz();
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Tekrar Oyna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: const Text("Ana Sayfaya Dön", style: TextStyle(color: Colors.white70)),
            )
          ],
        ),
      ),
    );
  }
}