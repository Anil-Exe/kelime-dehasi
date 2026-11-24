import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();

    // Eğer oyun bittiyse sonuç ekranını göster (Deklaratif yaklaşım)
    if (provider.isFinished) {
      return const ResultScreen();
    }

    final question = provider.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Soru ${provider.currentIndex + 1}/${provider.totalQuestions}"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Puan: ${provider.score}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                if (provider.streak > 1)
                  Text("Seri: 🔥 x${provider.streak}", style: const TextStyle(fontSize: 12, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        decoration: BoxDecoration(
          color: provider.flashColor, // Yeşil veya kırmızı yanıp sönme
          gradient: LinearGradient(
            colors: [Color(0xFF141E30), Color(0xFF243B55)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Joker Butonları Bölümü
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: provider.hasUsedHint ? null : () => context.read<QuizProvider>().useHint(),
                      icon: const Icon(Icons.lightbulb),
                      label: const Text("İpucu"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                    ),
                    ElevatedButton.icon(
                      onPressed: provider.hasUsedPass ? null : () => context.read<QuizProvider>().usePass(),
                      icon: const Icon(Icons.fast_forward),
                      label: const Text("Pas Geç"),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, foregroundColor: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Zaman Çubuğu
                LinearProgressIndicator(
                  value: provider.timeLeft / 10,
                  backgroundColor: Colors.white12,
                  color: provider.timeLeft > 3 ? Colors.cyanAccent : Colors.redAccent,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 40),
                // Soru Metni
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: Text(
                    question.question,
                    key: ValueKey<int>(provider.currentIndex),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                // Şıklar
                Expanded(
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      return AnswerButton(
                        option: option,
                        isSelected: provider.selectedAnswer == option,
                        isCorrect: question.answer == option,
                        isAnswered: provider.isAnswered,
                        onTap: () => context.read<QuizProvider>().selectAnswer(option),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}