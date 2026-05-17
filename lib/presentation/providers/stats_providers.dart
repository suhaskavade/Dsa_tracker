import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dsa_tracker/presentation/providers/progress_providers.dart';
import 'package:dsa_tracker/presentation/providers/question_providers.dart';

final totalSolvedProvider = Provider<int>((ref) {
  final progressMap = ref.watch(progressMapProvider).valueOrNull ?? {};
  return progressMap.values.where((p) => p.isSolved).length;
});

final pendingRevisionProvider = Provider<int>((ref) {
  final progressMap = ref.watch(progressMapProvider).valueOrNull ?? {};
  return progressMap.values.where((p) => p.needsRevision).length;
});

final topicProgressProvider = Provider.family<double, String>((ref, topic) {
  final groupedQuestions = ref.watch(topicGroupedQuestionsProvider).valueOrNull ?? {};
  final progressMap = ref.watch(progressMapProvider).valueOrNull ?? {};
  
  final questions = groupedQuestions[topic] ?? [];
  if (questions.isEmpty) return 0.0;
  
  int solvedCount = 0;
  for (final q in questions) {
    if (progressMap[q.leetcodeId]?.isSolved == true) {
      solvedCount++;
    }
  }
  
  return solvedCount / questions.length;
});

final patternMasteryProvider = Provider<List<MapEntry<String, double>>>((ref) {
  final groupedQuestions = ref.watch(topicGroupedQuestionsProvider).valueOrNull ?? {};
  final progressMap = ref.watch(progressMapProvider).valueOrNull ?? {};
  
  final entries = <MapEntry<String, double>>[];
  for (final entry in groupedQuestions.entries) {
    final topic = entry.key;
    final questions = entry.value;
    if (questions.isEmpty) continue;
    
    int solvedCount = 0;
    for (final q in questions) {
      if (progressMap[q.leetcodeId]?.isSolved == true) {
        solvedCount++;
      }
    }
    entries.add(MapEntry(topic, (solvedCount / questions.length) * 100));
  }
  
  // Sort by highest percentage or just return first 6
  entries.sort((a, b) => b.value.compareTo(a.value));
  return entries.take(6).toList();
});
