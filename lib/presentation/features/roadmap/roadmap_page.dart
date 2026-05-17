import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';
import 'package:dsa_tracker/presentation/providers/question_providers.dart';
import 'package:dsa_tracker/presentation/providers/stats_providers.dart';

class RoadmapPage extends ConsumerWidget {
  const RoadmapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupedQuestions = ref.watch(topicGroupedQuestionsProvider).valueOrNull ?? {};
    final topics = groupedQuestions.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('DSA Learning Roadmap')),
      body: topics.isEmpty 
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(24.0),
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              final progress = ref.watch(topicProgressProvider(topic));
              
              // Unlock logic: First topic always unlocked, 
              // others unlocked if previous topic has > 0 progress
              bool isUnlocked = true;
              if (index > 0) {
                final prevTopic = topics[index - 1];
                final prevProgress = ref.watch(topicProgressProvider(prevTopic));
                isUnlocked = prevProgress > 0.0;
              }

              return _RoadmapCard(
                topic: topic,
                step: index + 1,
                isUnlocked: isUnlocked,
                progress: progress,
              );
            },
          ),
    );
  }
}

class _RoadmapCard extends ConsumerWidget {
  final String topic;
  final int step;
  final bool isUnlocked;
  final double progress;

  const _RoadmapCard({
    required this.topic,
    required this.step,
    required this.isUnlocked,
    required this.progress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isUnlocked
          ? null
          : Theme.of(context).colorScheme.surface.withOpacity(0.5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: isUnlocked
              ? AppColors.darkPrimary.withOpacity(0.2)
              : Colors.grey.withOpacity(0.2),
          child: Icon(
            isUnlocked
                ? (progress == 1.0 ? Icons.check : Icons.lock_open)
                : Icons.lock,
            color: isUnlocked ? AppColors.darkPrimary : Colors.grey,
          ),
        ),
        title: Text(
          'Step $step: $topic',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isUnlocked ? null : Colors.grey,
          ),
        ),
        subtitle: isUnlocked
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    color: progress == 1.0
                        ? AppColors.success
                        : AppColors.darkPrimary,
                  ),
                  const SizedBox(height: 4),
                  Text('${(progress * 100).toInt()}% Complete'),
                ],
              )
            : const Text('Complete previous steps to unlock'),
        trailing: isUnlocked
            ? FilledButton(
                onPressed: () {
                  // Navigate to questions filtered by topic
                  ref.read(searchQueryProvider.notifier).state = topic;
                  context.go('/questions');
                },
                child: Text(progress == 1.0 ? 'Review' : 'Start'),
              )
            : null,
      ),
    );
  }
}
