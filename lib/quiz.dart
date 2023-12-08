import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:harmonix/utils/globals.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final Map<String, dynamic> _questions = <String, dynamic>{
    "What is the primary language for communication for deaf people?": <String>["Sign language", "Braille", "Morse code", "Finger spelling"],
    "Which sense is typically heightened in individuals who are blind?": <String>["Hearing", "Taste", "Smell", "Touch"],
    "What is a primary tool used by visually impaired people to read?": <String>["Braille", "Sign language", "Audio books", "Large print"],
    "What method is used for communication among blind individuals?": <String>["Braille", "Sign language", "Morse code", "Texting"],
    "What is a primary means of communication for deaf-blind individuals?": <String>["Tactile sign language", "Lip reading", "Audio devices", "Visual cues"]
  };
  final Map<String, String> _falses = <String, String>{};

  final Map<String, dynamic> _correctAnswers = {
    "What is the primary language for communication for deaf people?": "Finger spelling",
    "Which sense is typically heightened in individuals who are blind?": "Touch",
    "What is a primary tool used by visually impaired people to read?": "Large print",
    "What method is used for communication among blind individuals?": "Morse code",
    "What is a primary means of communication for deaf-blind individuals?": "Tactile sign language",
  };
  int _currentIndex = 0;
  double _score = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == _questions.length
          ? Center(child: Text("Your score is : \n${(_score * 100 / _questions.length).toStringAsFixed(2)}%", style: const TextStyle(fontSize: 45), textAlign: TextAlign.center))
          : PageView.builder(
              controller: _pageController,
              itemCount: _questions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(_questions.keys.elementAt(index), style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 10),
                  for (String choice in _questions.values.elementAt(index))
                    GestureDetector(
                      onTap: () async {
                        if (choice == _correctAnswers.values.elementAt(index)) {
                          _score += 1;
                        } else {
                          _falses.addIf(true, choice, "");
                        }
                        _currentIndex += 1;
                        if (_currentIndex == _questions.length) {
                          print(1);
                          await FirebaseFirestore.instance.collection("results").add(
                            <String, dynamic>{
                              "uid": FirebaseAuth.instance.currentUser!.uid,
                              "score": _score * 100 / _questions.length,
                              "falses": _falses,
                              "date": Timestamp.now(),
                            },
                          );
                          setState(() {});
                        }
                        _pageController.nextPage(duration: 500.ms, curve: Curves.linear);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: teal.withOpacity(.3)),
                        child: Text(choice, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w400)),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
