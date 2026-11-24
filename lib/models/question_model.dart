enum QuestionCategory { yazilim, gezi, kultur, egitim }
enum QuestionDifficulty { kolay, orta, zor }

class QuestionModel {
  final String question;
  List<String> options;
  final String answer;
  final QuestionCategory category;
  final QuestionDifficulty difficulty;

  QuestionModel({
    required this.question,
    required this.options,
    required this.answer,
    required this.category,
    required this.difficulty,
  });
}