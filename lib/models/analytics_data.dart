class AnalyticsData {
  final String label;
  final double value;
  final double? previousValue;

  AnalyticsData({
    required this.label,
    required this.value,
    this.previousValue,
  });

  double get changePercentage {
    if (previousValue == null || previousValue == 0) return 0;
    return ((value - previousValue!) / previousValue!) * 100;
  }
}

class ChartDataPoint {
  final String label;
  final double value;

  ChartDataPoint({required this.label, required this.value});
}
