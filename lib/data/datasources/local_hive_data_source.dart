import 'package:hive_flutter/hive_flutter.dart';
import 'package:dsa_tracker/data/models/question_model.dart';
import 'package:dsa_tracker/data/models/user_progress_model.dart';
import 'package:dsa_tracker/data/models/user_profile_model.dart';

class LocalHiveDataSource {
  late Box<QuestionModel> questionBox;
  late Box<UserProgressModel> progressBox;
  late Box<UserProfileModel> profileBox;

  static Future<LocalHiveDataSource> init() async {
    Hive.registerAdapter(QuestionModelAdapter());
    Hive.registerAdapter(UserProgressModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());

    final dataSource = LocalHiveDataSource();
    dataSource.questionBox = await Hive.openBox<QuestionModel>('questions');
    dataSource.progressBox = await Hive.openBox<UserProgressModel>('progress');
    dataSource.profileBox = await Hive.openBox<UserProfileModel>('profile');

    return dataSource;
  }

  Future<void> saveQuestions(List<QuestionModel> questions) async {
    final Map<int, QuestionModel> map = {
      for (var q in questions) q.leetcodeId: q
    };
    await questionBox.putAll(map);
  }

  Future<List<QuestionModel>> getAllQuestions() async {
    return questionBox.values.toList();
  }
}
