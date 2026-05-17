import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dsa_tracker/presentation/providers/question_providers.dart';
import 'package:dsa_tracker/presentation/providers/progress_providers.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';
import 'package:dsa_tracker/domain/entities/question.dart';

class QuestionsPage extends ConsumerWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedQuestionsAsync = ref.watch(topicGroupedQuestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DSA Tracker'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by LeetCode #, title, topic, or company...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
        ),
      ),
      body: groupedQuestionsAsync.when(
        data: (groupedMap) {
          if (groupedMap.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }
          final topics = groupedMap.keys.toList();
          return ListView.builder(
            padding: const EdgeInsets.all(24.0),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              final questions = groupedMap[topic]!;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ExpansionTile(
                  initiallyExpanded: index == 0,
                  title: Text(
                    topic,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text('${questions.length} Questions'),
                  children: questions.map((q) => _QuestionCard(question: q)).toList(),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _QuestionCard extends ConsumerWidget {
  final Question question;

  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficultyColor = _getDifficultyColor(question.difficulty);
    final progressMapAsync = ref.watch(progressMapProvider);
    
    final isSolved = progressMapAsync.maybeWhen(
      data: (map) => map[question.leetcodeId]?.isSolved ?? false,
      orElse: () => false,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
      child: InkWell(
        onTap: () {
          context.go('/questions/${question.leetcodeId}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Checkbox(
                value: isSolved,
                onChanged: (val) {
                  if (val != null) {
                    ref.read(progressMapProvider.notifier).toggleSolved(question.leetcodeId, val);
                  }
                },
              ),
              SizedBox(
                width: 50,
                child: Text(
                  '#${question.leetcodeId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: isSolved ? TextDecoration.lineThrough : null,
                        color: isSolved ? Colors.grey : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _Chip(
                          label: question.difficulty,
                          color: difficultyColor,
                        ),
                        if (question.companies.isNotEmpty)
                          _Chip(
                            label: question.companies.first,
                            color: AppColors.darkSecondary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String diff) {
    switch (diff) {
      case 'Easy':
        return AppColors.success;
      case 'Medium':
        return AppColors.warning;
      case 'Hard':
        return AppColors.error;
      default:
        return Colors.grey;
    }
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
