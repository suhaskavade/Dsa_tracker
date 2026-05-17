import 'package:dsa_tracker/data/models/user_progress_model.dart';

abstract class IProgressRepository {
  Future<UserProgressModel?> getProgress(int questionId);
  Future<void> saveProgress(UserProgressModel progress);
  Future<List<UserProgressModel>> getAllProgress();
}
