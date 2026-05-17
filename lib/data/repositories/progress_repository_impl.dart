import 'package:dsa_tracker/domain/repositories/i_progress_repository.dart';
import 'package:dsa_tracker/data/datasources/local_hive_data_source.dart';
import 'package:dsa_tracker/data/models/user_progress_model.dart';

class ProgressRepositoryImpl implements IProgressRepository {
  final LocalHiveDataSource dataSource;

  ProgressRepositoryImpl(this.dataSource);

  @override
  Future<UserProgressModel?> getProgress(int questionId) async {
    return dataSource.progressBox.get(questionId);
  }

  @override
  Future<void> saveProgress(UserProgressModel progress) async {
    await dataSource.progressBox.put(progress.questionId, progress);
  }

  @override
  Future<List<UserProgressModel>> getAllProgress() async {
    return dataSource.progressBox.values.toList();
  }
}
