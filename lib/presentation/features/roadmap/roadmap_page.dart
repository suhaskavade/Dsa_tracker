import 'package:flutter/material.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';
import 'package:dsa_tracker/core/utils/data_seeder.dart';

class RoadmapPage extends StatelessWidget {
  const RoadmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DSA Learning Roadmap')),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: DataSeeder.topics.length,
        itemBuilder: (context, index) {
          final topic = DataSeeder.topics[index];
          // Mock data: first 3 unlocked, others locked
          final isUnlocked = index <= 2;
          final progress = isUnlocked ? (index == 2 ? 0.4 : 1.0) : 0.0;

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

class _RoadmapCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
                  // TODO: Navigate to questions filtered by topic
                },
                child: Text(progress == 1.0 ? 'Review' : 'Start'),
              )
            : null,
      ),
    );
  }
}
