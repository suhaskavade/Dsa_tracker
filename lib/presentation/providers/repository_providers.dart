import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dsa_tracker/data/datasources/local_hive_data_source.dart';
import 'package:dsa_tracker/domain/repositories/i_question_repository.dart';
import 'package:dsa_tracker/data/repositories/question_repository_impl.dart';
import 'package:dsa_tracker/domain/repositories/i_progress_repository.dart';
import 'package:dsa_tracker/data/repositories/progress_repository_impl.dart';

final dataSourceProvider = Provider<LocalHiveDataSource>((ref) {
  throw UnimplementedError('Should be overridden in main');
});

final questionRepositoryProvider = Provider<IQuestionRepository>((ref) {
  final ds = ref.watch(dataSourceProvider);
  return QuestionRepositoryImpl(ds);
});

final progressRepositoryProvider = Provider<IProgressRepository>((ref) {
  final ds = ref.watch(dataSourceProvider);
  return ProgressRepositoryImpl(ds);
});
