import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'repository_providers.dart';
import 'package:dsa_tracker/domain/entities/question.dart';

final questionsListProvider = FutureProvider<List<Question>>((ref) async {
  final repo = ref.watch(questionRepositoryProvider);
  return repo.getQuestions();
});

// A simple provider for search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider to filter questions based on search query
final filteredQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  final questions = await ref.watch(questionsListProvider.future);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return questions;

  return questions.where((q) {
    return q.title.toLowerCase().contains(query) ||
        q.leetcodeId.toString() == query ||
        q.topic.toLowerCase().contains(query) ||
        q.companies.any((c) => c.toLowerCase().contains(query));
  }).toList();
});

final questionDetailProvider = Provider.family<AsyncValue<Question?>, int>((
  ref,
  id,
) {
  final questions = ref.watch(questionsListProvider);
  return questions.whenData((list) {
    try {
      return list.firstWhere((q) => q.leetcodeId == id);
    } catch (_) {
      return null;
    }
  });
});

// A provider that groups the filtered questions by topic
final topicGroupedQuestionsProvider = FutureProvider<Map<String, List<Question>>>((ref) async {
  final filteredQuestions = await ref.watch(filteredQuestionsProvider.future);
  final map = <String, List<Question>>{};
  
  for (final q in filteredQuestions) {
    if (!map.containsKey(q.topic)) {
      map[q.topic] = [];
    }
    map[q.topic]!.add(q);
  }
  
  return map;
});
