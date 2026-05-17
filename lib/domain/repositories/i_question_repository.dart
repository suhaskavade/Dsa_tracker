import 'package:dsa_tracker/domain/entities/question.dart';

abstract class IQuestionRepository {
  Future<List<Question>> getQuestions();
  Future<Question?> getQuestionById(int leetcodeId);
  Future<void> seedQuestions(List<Question> questions);
}
