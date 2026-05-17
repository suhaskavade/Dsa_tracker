import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dsa_tracker/data/models/user_progress_model.dart';
import 'repository_providers.dart';

final progressMapProvider = AsyncNotifierProvider<ProgressMapNotifier, Map<int, UserProgressModel>>(
  ProgressMapNotifier.new,
);

class ProgressMapNotifier extends AsyncNotifier<Map<int, UserProgressModel>> {
  @override
  Future<Map<int, UserProgressModel>> build() async {
    final repo = ref.watch(progressRepositoryProvider);
    final allProgress = await repo.getAllProgress();
    return {for (var p in allProgress) p.questionId: p};
  }

  Future<void> toggleSolved(int questionId, bool isSolved) async {
    final repo = ref.read(progressRepositoryProvider);
    
    // Check if progress already exists
    UserProgressModel? progress = state.value?[questionId];
    
    if (progress == null) {
      progress = UserProgressModel()
        ..questionId = questionId
        ..isSolved = isSolved
        ..solveCount = isSolved ? 1 : 0
        ..lastSolvedDate = isSolved ? DateTime.now() : null;
    } else {
      progress.isSolved = isSolved;
      if (isSolved) {
        progress.solveCount += 1;
        progress.lastSolvedDate = DateTime.now();
      }
    }
    
    await repo.saveProgress(progress);
    
    // Update local state
    if (state.value != null) {
      final updatedMap = Map<int, UserProgressModel>.from(state.value!);
      updatedMap[questionId] = progress;
      state = AsyncData(updatedMap);
    }
  }
}
