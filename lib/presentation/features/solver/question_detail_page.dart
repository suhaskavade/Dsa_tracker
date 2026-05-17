import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';
import 'package:dsa_tracker/presentation/providers/question_providers.dart';
import 'widgets/teaching_panel.dart';

class QuestionDetailPage extends ConsumerWidget {
  final int leetcodeId;

  const QuestionDetailPage({super.key, required this.leetcodeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionAsync = ref.watch(questionDetailProvider(leetcodeId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/questions'),
        ),
      ),
      body: questionAsync.when(
        data: (q) {
          if (q == null)
            return const Center(child: Text('Question not found.'));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${q.leetcodeId} - ${q.title}',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: [
                          Chip(label: Text(q.difficulty)),
                          Chip(label: Text(q.topic)),
                          if (q.companies.isNotEmpty)
                            Chip(label: Text(q.companies.first)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Complexity',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Time: ${q.timeComplexity} | Space: ${q.spaceComplexity}',
                      ),
                      const SizedBox(height: 24),
                      Text('Striver Sheet Step: ${q.striverStep}'),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        'Tracker & Notes',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      _TrackerSection(questionId: q.leetcodeId),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: TeachingPanel(hints: q.hints, algorithm: q.pattern),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _TrackerSection extends StatefulWidget {
  final int questionId;

  const _TrackerSection({required this.questionId});

  @override
  State<_TrackerSection> createState() => _TrackerSectionState();
}

class _TrackerSectionState extends State<_TrackerSection> {
  bool isSolved = false;
  bool isFavorite = false;
  bool needsRevision = false;
  int solveCount = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Mark as Solved'),
              value: isSolved,
              onChanged: (val) => setState(() => isSolved = val ?? false),
            ),
            CheckboxListTile(
              title: const Text('Needs Revision'),
              value: needsRevision,
              onChanged: (val) => setState(() => needsRevision = val ?? false),
            ),
            CheckboxListTile(
              title: const Text('Favorite'),
              value: isFavorite,
              onChanged: (val) => setState(() => isFavorite = val ?? false),
            ),
            const Divider(),
            ListTile(
              title: const Text('Solve Count'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (solveCount > 0) setState(() => solveCount--);
                    },
                  ),
                  Text(
                    '$solveCount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => solveCount++),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
