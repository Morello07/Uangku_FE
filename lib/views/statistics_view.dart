import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class StatisticsView extends StatelessWidget {
  StatisticsView({super.key});

  final List<WeeklyData> incomeData = [
    WeeklyData('Minggu 1', 1500000),
    WeeklyData('Minggu 2', 2000000),
    WeeklyData('Minggu 3', 1800000),
    WeeklyData('Minggu 4', 2200000),
  ];

  final List<WeeklyData> expenseData = [
    WeeklyData('Minggu 1', 900000),
    WeeklyData('Minggu 2', 1100000),
    WeeklyData('Minggu 3', 1300000),
    WeeklyData('Minggu 4', 800000),
  ];

  @override
  Widget build(BuildContext context) {
    int totalIncome = incomeData.fold(0, (sum, e) => sum + e.amount);
    int totalExpense = expenseData.fold(0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik'),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ringkasan Bulanan', style: AppTextStyles.heading),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryCard('Pemasukan', totalIncome, Colors.green),
                _summaryCard('Pengeluaran', totalExpense, Colors.red),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Grafik Mingguan', style: AppTextStyles.heading),
            const SizedBox(height: 12),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(incomeData.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: incomeData[i].amount.toDouble() / 100000,
                          color: Colors.green,
                          width: 12,
                        ),
                        BarChartRodData(
                          toY: expenseData[i].amount.toDouble() / 100000,
                          color: Colors.red,
                          width: 12,
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value < 0 || value >= incomeData.length) return const SizedBox();
                          return Text(
                            incomeData[value.toInt()].week,
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(String title, int amount, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: AppTextStyles.subtitle),
          const SizedBox(height: 8),
          Text('Rp$amount', style: AppTextStyles.heading.copyWith(color: color)),
        ],
      ),
    );
  }
}

class WeeklyData {
  final String week;
  final int amount;
  WeeklyData(this.week, this.amount);
}
