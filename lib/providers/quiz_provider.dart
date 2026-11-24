import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question_model.dart';

class QuizProvider with ChangeNotifier {
  // Genişletilmiş ve Kategorize Edilmiş Soru Havuzu
  final List<QuestionModel> _allQuestions = [
    // Yazılım
    QuestionModel(question: "Flutter hangi dili kullanır?", options: ["Java", "Kotlin", "Dart", "Swift"], answer: "Dart", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Bir değişkenin değerini değiştirememek için hangi anahtar kelime kullanılır (Dart)?", options: ["var", "dynamic", "final", "let"], answer: "final", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Aşağıdakilerden hangisi bir NoSQL veritabanıdır?", options: ["PostgreSQL", "MySQL", "MongoDB", "Oracle"], answer: "MongoDB", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Web sayfalarının iskeletini oluşturan dil hangisidir?", options: ["CSS", "HTML", "JavaScript", "PHP"], answer: "HTML", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "En popüler versiyon kontrol sistemi hangisidir?", options: ["SVN", "Mercurial", "Git", "CVS"], answer: "Git", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Yapay zeka alanında en çok tercih edilen dil hangisidir?", options: ["C++", "Java", "Python", "Ruby"], answer: "Python", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "OOP'nin açılımı nedir?", options: ["Object Oriented", "Only Output", "Over Protocol", "Open Origin"], answer: "Object Oriented", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Hafif veri değişim formatı hangisidir?", options: ["XML", "JSON", "CSV", "YAML"], answer: "JSON", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Android uygulamaları için Google'ın önerdiği dil hangisidir?", options: ["Java", "Kotlin", "C#", "Dart"], answer: "Kotlin", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "iOS geliştirmek için kullanılan dil hangisidir?", options: ["Objective-C", "Swift", "C++", "Python"], answer: "Swift", category: QuestionCategory.yazilim, difficulty: QuestionDifficulty.kolay),
    
    // Kültür
    QuestionModel(question: "Mona Lisa tablosu hangi ressama aittir?", options: ["Van Gogh", "Picasso", "Da Vinci", "Dali"], answer: "Da Vinci", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Sefiller kitabının yazarı kimdir?", options: ["Victor Hugo", "Tolstoy", "Dostoyevski", "Balzac"], answer: "Victor Hugo", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Hamlet eserinin yazarı kimdir?", options: ["Charles Dickens", "William Shakespeare", "Mark Twain", "Jane Austen"], answer: "William Shakespeare", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Suç ve Ceza'nın başkarakteri kimdir?", options: ["Raskolnikov", "Mişkin", "İvan Karamazov", "Anna Karenina"], answer: "Raskolnikov", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Yıldızlı Gece tablosu kime aittir?", options: ["Claude Monet", "Vincent van Gogh", "Salvador Dali", "Edvard Munch"], answer: "Vincent van Gogh", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "İlahi Komedi kimin eseridir?", options: ["Homeros", "Vergilius", "Dante", "Boccaccio"], answer: "Dante", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Guernica tablosu hangi ressama aittir?", options: ["Francisco Goya", "Diego Velazquez", "Pablo Picasso", "Joan Miro"], answer: "Pablo Picasso", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "9. Senfoni hangi besteciye aittir?", options: ["Mozart", "Bach", "Beethoven", "Chopin"], answer: "Beethoven", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Don Kişot'un sadık yardımcısı kimdir?", options: ["Sancho Panza", "Dulcinea", "Rocinante", "Figaro"], answer: "Sancho Panza", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "İki Şehrin Hikayesi kitabındaki iki şehir neresidir?", options: ["Londra - Paris", "Roma - Venedik", "New York - Boston", "Berlin - Moskova"], answer: "Londra - Paris", category: QuestionCategory.kultur, difficulty: QuestionDifficulty.zor),
    
    // Gezi
    QuestionModel(question: "Eyfel Kulesi nerededir?", options: ["Roma", "Paris", "Londra", "Berlin"], answer: "Paris", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Machu Picchu hangi ülkededir?", options: ["Brezilya", "Şili", "Peru", "Arjantin"], answer: "Peru", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Kolezyum hangi ülkededir?", options: ["Yunanistan", "İtalya", "İspanya", "Fransa"], answer: "İtalya", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Tac Mahal hangi ülkededir?", options: ["Endonezya", "Hindistan", "Pakistan", "Bangladeş"], answer: "Hindistan", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Özgürlük Anıtı nerede bulunur?", options: ["Washington DC", "Los Angeles", "New York", "Chicago"], answer: "New York", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Çin Seddi hangi kıtadadır?", options: ["Asya", "Avrupa", "Afrika", "Amerika"], answer: "Asya", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Keops Piramidi nerededir?", options: ["Fas", "Mısır", "Tunus", "Cezayir"], answer: "Mısır", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Petra Antik Kenti hangi ülkededir?", options: ["Suriye", "Lübnan", "Ürdün", "Mısır"], answer: "Ürdün", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Sagrada Familia hangi şehirdedir?", options: ["Madrid", "Barselona", "Sevilla", "Valensiya"], answer: "Barselona", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Big Ben saat kulesi nerededir?", options: ["Manchester", "Edinburgh", "Londra", "Dublin"], answer: "Londra", category: QuestionCategory.gezi, difficulty: QuestionDifficulty.kolay),
    
    // Eğitim
    QuestionModel(question: "Hangi gezegen Güneş'e en yakındır?", options: ["Venüs", "Mars", "Merkür", "Dünya"], answer: "Merkür", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Pi sayısının ilk 3 basamağı nedir?", options: ["3.12", "3.14", "3.16", "3.18"], answer: "3.14", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Suyun kimyasal formülü nedir?", options: ["CO2", "O2", "H2O", "NaCl"], answer: "H2O", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Işık hızı saniyede yaklaşık kaç kilometredir?", options: ["100.000", "200.000", "300.000", "400.000"], answer: "300.000", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Yerçekimi kanununu kim bulmuştur?", options: ["Albert Einstein", "Isaac Newton", "Galileo Galilei", "Nikola Tesla"], answer: "Isaac Newton", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "İzafiyet teorisini kim geliştirmiştir?", options: ["Isaac Newton", "Stephen Hawking", "Albert Einstein", "Niels Bohr"], answer: "Albert Einstein", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.orta),
    QuestionModel(question: "Hücrenin enerji merkezi neresidir?", options: ["Çekirdek", "Ribozom", "Mitokondri", "Lizozom"], answer: "Mitokondri", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.zor),
    QuestionModel(question: "Kızıl Gezegen olarak bilinen gezegen hangisidir?", options: ["Jüpiter", "Mars", "Satürn", "Uranüs"], answer: "Mars", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Oksijenin kimyasal sembolü nedir?", options: ["O", "Ox", "C", "H"], answer: "O", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.kolay),
    QuestionModel(question: "Altının kimyasal sembolü nedir?", options: ["Ag", "Au", "Al", "Fe"], answer: "Au", category: QuestionCategory.egitim, difficulty: QuestionDifficulty.orta),
  ];

  List<QuestionModel> _askedQuestions = [];
  QuestionModel? _currentQuestion;
  int _roundMaxQuestions = 10;
  List<String> _lastScores = [];
  
  int _currentIndex = 0;
  int _score = 0;
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _streak = 0;
  int _highScore = 0;
  int _timeLeft = 10;
  bool _isAnswered = false;
  bool _isFinished = false;
  String? _selectedAnswer;
  Timer? _timer;
  
  // Ekstra Mekanikler
  Color? _flashColor;
  bool _hasUsedHint = false;
  bool _hasUsedPass = false;
  QuestionDifficulty _currentDifficulty = QuestionDifficulty.kolay;
  int _consecutiveCorrect = 0;
  int _consecutiveWrong = 0;
  QuestionCategory? _selectedCategory;

  QuizProvider() {
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt('highScore') ?? 0;
    _lastScores = prefs.getStringList('lastScores') ?? [];
    notifyListeners();
  }

  void setCategoryAndReset(QuestionCategory? category) {
    _selectedCategory = category;
    _currentDifficulty = QuestionDifficulty.kolay; // Oyuna kolay başlar
    resetQuiz();
  }

  void _setNextQuestion() {
    // Yapay Zeka (AI) ve Kategoriye uygun henüz sorulmamış soruları filtrele
    var candidates = _allQuestions.where((q) {
      bool catMatch = _selectedCategory == null || q.category == _selectedCategory;
      bool diffMatch = q.difficulty == _currentDifficulty;
      return catMatch && diffMatch && !_askedQuestions.contains(q);
    }).toList();

    // O zorlukta soru kalmadıysa zorluğu es geç
    if (candidates.isEmpty) {
      candidates = _allQuestions.where((q) {
        bool catMatch = _selectedCategory == null || q.category == _selectedCategory;
        return catMatch && !_askedQuestions.contains(q);
      }).toList();
    }

    if (candidates.isNotEmpty) {
      candidates.shuffle();
      _currentQuestion = candidates.first;
      _currentQuestion!.options.shuffle(); // Şıkları karıştır
      _askedQuestions.add(_currentQuestion!);
    }
  }

  // Getters
  int get totalQuestions => _roundMaxQuestions;
  List<String> get lastScores => _lastScores;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get correctAnswers => _correctAnswers;
  int get wrongAnswers => _wrongAnswers;
  int get streak => _streak;
  int get highScore => _highScore;
  int get timeLeft => _timeLeft;
  bool get isAnswered => _isAnswered;
  bool get isFinished => _isFinished;
  String? get selectedAnswer => _selectedAnswer;
  QuestionModel get currentQuestion => _currentQuestion!;
  Color? get flashColor => _flashColor;
  bool get hasUsedHint => _hasUsedHint;
  bool get hasUsedPass => _hasUsedPass;

  void startTimer() {
    _timeLeft = 10;
    _isAnswered = false;
    _selectedAnswer = null;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _handleTimeout();
      }
    });
    notifyListeners();
  }

  void _handleTimeout() {
    _isAnswered = true;
    _wrongAnswers++;
    _streak = 0;
    _handleAI(false);
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () => nextQuestion());
  }

  // Jokerler
  void useHint() {
    if (_hasUsedHint || _isAnswered || _currentQuestion == null) return;
    _hasUsedHint = true;
    
    final answer = _currentQuestion!.answer;
    final wrongs = _currentQuestion!.options.where((o) => o != answer).toList();
    wrongs.shuffle();
    
    // 2 yanlış şıkkı sil
    _currentQuestion!.options.remove(wrongs[0]);
    if (wrongs.length > 1) {
      _currentQuestion!.options.remove(wrongs[1]);
    }
    notifyListeners();
  }

  void usePass() {
    if (_hasUsedPass || _isAnswered) return;
    _hasUsedPass = true;
    nextQuestion();
  }

  // Yapay Zeka - Dinamik Zorluk
  void _handleAI(bool isCorrect) {
    if (isCorrect) {
      _consecutiveCorrect++;
      _consecutiveWrong = 0;
      if (_consecutiveCorrect >= 2 && _currentDifficulty != QuestionDifficulty.zor) {
        _currentDifficulty = QuestionDifficulty.values[_currentDifficulty.index + 1];
        _consecutiveCorrect = 0; // Seviye atlayınca sıfırla
      }
    } else {
      _consecutiveWrong++;
      _consecutiveCorrect = 0;
      if (_consecutiveWrong >= 2 && _currentDifficulty != QuestionDifficulty.kolay) {
        _currentDifficulty = QuestionDifficulty.values[_currentDifficulty.index - 1];
        _consecutiveWrong = 0; // Seviye düşünce sıfırla
      }
    }
  }

  void selectAnswer(String answer) {
    if (_isAnswered || _currentQuestion == null) return;

    _timer?.cancel();
    _isAnswered = true;
    _selectedAnswer = answer;
    int timeTaken = 10 - _timeLeft;

    if (answer == _currentQuestion!.answer) {
      _correctAnswers++;
      _streak++;
      int speedBonus = timeTaken <= 5 ? 5 : 0;
      _score += 10 + speedBonus; // +10 ve hızlıysa +5
      _flashColor = Colors.green.withOpacity(0.5);
      _handleAI(true);
    } else {
      _streak = 0;
      _wrongAnswers++;
      _score = (_score - 5 < 0) ? 0 : _score - 5; // -5 ceza, 0'ın altına inmez
      _flashColor = Colors.red.withOpacity(0.5);
      _handleAI(false);
    }
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      _flashColor = null; // Efekti temizle
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_currentIndex < _roundMaxQuestions - 1) {
      _currentIndex++;
      _setNextQuestion();
      startTimer();
    } else {
      _finishQuiz();
    }
  }

  Future<void> _finishQuiz() async {
    _isFinished = true;
    _timer?.cancel();
    final prefs = await SharedPreferences.getInstance();
    
    if (_score > _highScore) {
      _highScore = _score;
      await prefs.setInt('highScore', _highScore);
    }
    
    // Puan_DogruSayisi_YanlisSayisi formatında kaydediyoruz
    _lastScores.insert(0, "${_score}_${_correctAnswers}_${_wrongAnswers}");
    if (_lastScores.length > 3) _lastScores = _lastScores.sublist(0, 3); // Sadece son 3'ü tut
    await prefs.setStringList('lastScores', _lastScores);
    
    notifyListeners();
  }

  void resetQuiz() {
    _currentIndex = 0;
    _score = 0;
    _correctAnswers = 0;
    _wrongAnswers = 0;
    _streak = 0;
    _isFinished = false;
    _hasUsedHint = false;
    _hasUsedPass = false;
    _consecutiveCorrect = 0;
    _consecutiveWrong = 0;
    _askedQuestions.clear();
    _setNextQuestion();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}