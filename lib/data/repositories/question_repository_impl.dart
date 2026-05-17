import 'package:dsa_tracker/domain/entities/question.dart';
import 'package:dsa_tracker/domain/repositories/i_question_repository.dart';
import 'package:dsa_tracker/data/datasources/local_hive_data_source.dart';
import 'package:dsa_tracker/data/models/question_model.dart';

class QuestionRepositoryImpl implements IQuestionRepository {
  final LocalHiveDataSource dataSource;

  QuestionRepositoryImpl(this.dataSource);

  @override
  Future<List<Question>> getQuestions() async {
    final models = await dataSource.getAllQuestions();
    return models.map((m) => _mapToEntity(m)).toList();
  }

  @override
  Future<Question?> getQuestionById(int leetcodeId) async {
    final model = dataSource.questionBox.get(leetcodeId);
    if (model != null) {
      return _mapToEntity(model);
    }
    return null;
  }

  @override
  Future<void> seedQuestions(List<Question> questions) async {
    final models = questions.map((q) => _mapToModel(q)).toList();
    await dataSource.saveQuestions(models);
  }

  Question _mapToEntity(QuestionModel model) {
    return Question(
      leetcodeId: model.leetcodeId,
      title: model.title,
      difficulty: model.difficulty,
      pattern: model.pattern,
      topic: model.topic,
      url: model.url,
      companies: model.companies,
      hints: model.hints,
      timeComplexity: model.timeComplexity,
      spaceComplexity: model.spaceComplexity,
      tags: model.tags,
      striverStep: model.striverStep,
    );
  }

  QuestionModel _mapToModel(Question entity) {
    return QuestionModel()
      ..leetcodeId = entity.leetcodeId
      ..title = entity.title
      ..difficulty = entity.difficulty
      ..pattern = entity.pattern
      ..topic = entity.topic
      ..url = entity.url
      ..companies = entity.companies
      ..hints = entity.hints
      ..timeComplexity = entity.timeComplexity
      ..spaceComplexity = entity.spaceComplexity
      ..tags = entity.tags
      ..striverStep = entity.striverStep;
  }
}
