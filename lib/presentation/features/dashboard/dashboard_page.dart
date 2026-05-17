import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, User!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            const _StatsRow(),
            const SizedBox(height: 32),
            Text(
              'Pattern Mastery',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 300, child: _PatternMasteryChart()),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total Solved',
            value: '142',
            icon: Icons.check_circle,
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Current Streak',
            value: '12 Days',
            icon: Icons.local_fire_department,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Pending Revision',
            value: '8',
            icon: Icons.refresh,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PatternMasteryChart extends StatelessWidget {
  const _PatternMasteryChart();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 100,
            barTouchData: BarTouchData(enabled: false),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const titles = [
                      'Arrays',
                      'Strings',
                      'Sorting',
                      'Two Ptrs',
                      'Sliding Win',
                      'Binary Search',
                    ];
                    if (value.toInt() < titles.length) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          titles[value.toInt()],
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            barGroups: [
              _buildBar(0, 80),
              _buildBar(1, 60),
              _buildBar(2, 40),
              _buildBar(3, 90),
              _buildBar(4, 30),
              _buildBar(5, 70),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppColors.darkPrimary,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
