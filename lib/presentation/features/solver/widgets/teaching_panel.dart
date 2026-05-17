import 'package:flutter/material.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';

class TeachingPanel extends StatefulWidget {
  final List<String> hints;
  final String algorithm;

  const TeachingPanel({
    super.key,
    required this.hints,
    required this.algorithm,
  });

  @override
  State<TeachingPanel> createState() => _TeachingPanelState();
}

class _TeachingPanelState extends State<TeachingPanel> {
  int _currentHintLevel = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkPrimary.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.darkPrimary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.psychology, color: AppColors.darkPrimary),
                const SizedBox(width: 8),
                Text(
                  'AI Teaching Mode',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (widget.hints.isNotEmpty) ...[
              const Text(
                'Hints:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...List.generate(_currentHintLevel, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('💡', style: TextStyle(fontSize: 18)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(widget.hints[index])),
                    ],
                  ),
                );
              }),
              if (_currentHintLevel < widget.hints.length)
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentHintLevel++;
                      });
                    },
                    icon: const Icon(Icons.lightbulb),
                    label: Text('Reveal Hint Level ${_currentHintLevel + 1}'),
                  ),
                )
              else
                _buildAlgorithmReveal(),
            ] else
              _buildAlgorithmReveal(),
          ],
        ),
      ),
    );
  }

  Widget _buildAlgorithmReveal() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.success),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Algorithm to use: ${widget.algorithm}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
