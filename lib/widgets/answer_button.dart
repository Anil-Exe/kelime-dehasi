import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Cevaplanma durumuna göre buton rengini belirleyen fonksiyon
    Color getBackgroundColor() {
      if (!isAnswered) return Colors.white12;
      if (isCorrect) return Colors.green.withOpacity(0.8); // Doğruysa yeşil
      if (isSelected && !isCorrect) return Colors.red.withOpacity(0.8); // Yanlış seçildiyse kırmızı
      return Colors.white12;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Text(
            option,
            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}