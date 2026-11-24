import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/question_model.dart';
import '../providers/quiz_provider.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _selectCategory(BuildContext context, QuestionCategory? category) {
    context.read<QuizProvider>().setCategoryAndReset(category);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelime Dehası"),
        backgroundColor: const Color(0xFF141E30),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // High Score Kartı
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amberAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.amberAccent, width: 2),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.emoji_events, color: Colors.amber, size: 50),
                    const SizedBox(height: 10),
                    const Text("En Yüksek Puan (Best Scorer)", style: TextStyle(fontSize: 16, color: Colors.white70)),
                    Text("${provider.highScore}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Son 3 Oyun İstatistiği
              const Text("Son 3 Oyun", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  String score = "-";
                  String correct = "-";
                  String wrong = "-";
                  
                  if (index < provider.lastScores.length) {
                    // Puan_Dogru_Yanlis verisini parçalara ayır
                    List<String> parts = provider.lastScores[index].split('_');
                    score = parts.isNotEmpty ? parts[0] : "-";
                    correct = parts.length > 1 ? parts[1] : "-";
                    wrong = parts.length > 2 ? parts[2] : "-";
                  }
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: index == 1 ? 8 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text("${index + 1}. Oyun", style: const TextStyle(fontSize: 12, color: Colors.white54)),
                          const SizedBox(height: 5),
                          Text(score, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 12),
                              const SizedBox(width: 4),
                              Text(correct, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                              const SizedBox(width: 8),
                              const Icon(Icons.cancel, color: Colors.redAccent, size: 12),
                              const SizedBox(width: 4),
                              Text(wrong, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              
              // Kategoriler
              const Text("Kategori Seç ve Oyna", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildCategoryCard(context, "Yazılım", Icons.computer, Colors.blueAccent, QuestionCategory.yazilim),
                  _buildCategoryCard(context, "Gezi", Icons.flight, Colors.orangeAccent, QuestionCategory.gezi),
                  _buildCategoryCard(context, "Kültür", Icons.account_balance, Colors.purpleAccent, QuestionCategory.kultur),
                  _buildCategoryCard(context, "Eğitim", Icons.school, Colors.greenAccent, QuestionCategory.egitim),
                  _buildCategoryCard(context, "Karışık", Icons.shuffle, Colors.pinkAccent, null), // null göndererek karışık seçiyoruz
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon, Color color, QuestionCategory? category) {
    return GestureDetector(
      onTap: () => _selectCategory(context, category),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}