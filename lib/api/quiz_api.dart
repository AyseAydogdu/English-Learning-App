import 'package:cloud_firestore/cloud_firestore.dart';

class QuizApi {
  getQuiz() async {
    return await FirebaseFirestore.instance.collection('quiz').snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .collection("qn")
        .get();
  }
}
