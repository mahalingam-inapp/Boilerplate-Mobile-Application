import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../core/auth_notifier.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';

class _AreaPoint {
  final String name;
  final double value;
  const _AreaPoint(this.name, this.value);
}

class _BarPoint {
  final String name;
  final double value;
  const _BarPoint(this.name, this.value);
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const _areaData = [
    _AreaPoint('Mon', 400.0),
    _AreaPoint('Tue', 300.0),
    _AreaPoint('Wed', 600.0),
    _AreaPoint('Thu', 800.0),
    _AreaPoint('Fri', 500.0),
    _AreaPoint('Sat', 700.0),
    _AreaPoint('Sun', 900.0),
  ];

  static const _barData = [
    _BarPoint('Jan', 4000.0),
    _BarPoint('Feb', 3000.0),
    _BarPoint('Mar', 5000.0),
    _BarPoint('Apr', 4500.0),
    _BarPoint('May', 6000.0),
    _BarPoint('Jun', 5500.0),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome back, ${user?.name ?? ''}!', style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 4),
          Text("Here's what's happening today", style: TextStyle(color: theme.brightness == Brightness.dark ? AppColorsDark.mutedForeground : AppColors.mutedForeground)),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.4,
            children: [
              _MetricCard(icon: Icons.trending_up, label: 'Revenue', value: '\$12,345', change: '+12.5%', color: AppColors.chart1),
              _MetricCard(icon: Icons.people_outline, label: 'Users', value: '2,834', change: '+8.2%', color: AppColors.chart2),
              _MetricCard(icon: Icons.shopping_bag_outlined, label: 'Orders', value: '1,234', change: '+23.1%', color: AppColors.chart4),
              _MetricCard(icon: Icons.show_chart, label: 'Active', value: '892', change: '+5.3%', color: AppColors.chart5),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Your activity over the past week', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: AppColors.accent, strokeWidth: 1)),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, meta) {
                              final i = v.toInt().clamp(0, _areaData.length - 1);
                              return Text(_areaData[i].name, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground));
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _areaData.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
                          isCurved: true,
                          color: AppColors.primary,
                          barWidth: 2,
                          belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.2)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Monthly Overview', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('Performance over the last 6 months', style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 7000,
                      gridData: FlGridData(show: true, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: AppColors.accent, strokeWidth: 1)),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (v, meta) {
                              final i = v.toInt().clamp(0, _barData.length - 1);
                              return Text(_barData[i].name, style: const TextStyle(fontSize: 12, color: AppColors.mutedForeground));
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: _barData.asMap().entries.map((e) => BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(
                            toY: e.value.value,
                            color: AppColors.primary,
                            width: 24,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          ),
                        ],
                        showingTooltipIndicators: [0],
                      )).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.6,
                  children: [
                    _QuickAction(icon: Icons.attach_money, label: 'New Transaction', color: AppColors.primary),
                    _QuickAction(icon: Icons.people_outline, label: 'Add User', color: AppColors.secondary),
                    _QuickAction(icon: Icons.shopping_bag_outlined, label: 'View Orders', color: AppColors.primary),
                    _QuickAction(icon: Icons.show_chart, label: 'Analytics', color: AppColors.secondary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String change;
  final Color color;

  const _MetricCard({required this.icon, required this.label, required this.value, required this.change, required this.color});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 20, color: color),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.greenSuccessBg, borderRadius: BorderRadius.circular(999)),
                child: Text(change, style: const TextStyle(fontSize: 12, color: AppColors.greenSuccess)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 14, color: AppColors.mutedForeground)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _QuickAction({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: color),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
