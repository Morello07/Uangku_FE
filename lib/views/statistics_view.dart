import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:uangku_app/models/weekly_day.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;
    final isTablet = screenWidth >= 768;
    
    int totalIncome = incomeData.fold(0, (sum, e) => sum + e.amount);
    int totalExpense = expenseData.fold(0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik'),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? screenWidth * 0.1 : 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ringkasan Bulanan', style: AppTextStyles.heading),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _summaryCard(context, 'Pemasukan', totalIncome, Colors.green),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _summaryCard(context, 'Pengeluaran', totalExpense, Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text('Grafik Mingguan', style: AppTextStyles.heading),
              const SizedBox(height: 12),
              SizedBox(
                height: isTablet ? 400 : 250,
                child: BarChart(
                  BarChartData(
                    barGroups: List.generate(incomeData.length, (i) {
                      return BarChartGroupData(
                        x: i,
                        groupVertically: true,
                        barsSpace: 4,
                        barRods: [
                          BarChartRodData(
                            toY: incomeData[i].amount.toDouble() / 100000,
                            color: Colors.green.withOpacity(0.8),
                            width: isTablet ? 24 : 16,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          BarChartRodData(
                            toY: expenseData[i].amount.toDouble() / 100000,
                            color: Colors.red.withOpacity(0.8),
                            width: isTablet ? 24 : 16,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                      );
                    }),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '${value.toInt() * 100}K',
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value < 0 || value >= incomeData.length) return const SizedBox();
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                incomeData[value.toInt()].week,
                                style: const TextStyle(fontSize: 10),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    maxY: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(BuildContext context, String title, int amount, Color color) {
    final formattedAmount = amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.subtitle.copyWith(
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Rp$formattedAmount',
            style: AppTextStyles.heading.copyWith(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}