import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/analytics_data.dart';

final patientAdmissionsProvider = Provider<List<ChartDataPoint>>((ref) {
  return [
    ChartDataPoint(label: 'Mon', value: 45),
    ChartDataPoint(label: 'Tue', value: 52),
    ChartDataPoint(label: 'Wed', value: 48),
    ChartDataPoint(label: 'Thu', value: 61),
    ChartDataPoint(label: 'Fri', value: 55),
    ChartDataPoint(label: 'Sat', value: 38),
    ChartDataPoint(label: 'Sun', value: 42),
  ];
});

final departmentStatsProvider = Provider<List<AnalyticsData>>((ref) {
  return [
    AnalyticsData(label: 'Cardiology', value: 156, previousValue: 142),
    AnalyticsData(label: 'Neurology', value: 98, previousValue: 105),
    AnalyticsData(label: 'Orthopedics', value: 124, previousValue: 118),
    AnalyticsData(label: 'Pediatrics', value: 87, previousValue: 82),
    AnalyticsData(label: 'Emergency', value: 234, previousValue: 198),
  ];
});

final monthlyRevenueProvider = Provider<List<ChartDataPoint>>((ref) {
  return [
    ChartDataPoint(label: 'Jan', value: 125000),
    ChartDataPoint(label: 'Feb', value: 132000),
    ChartDataPoint(label: 'Mar', value: 145000),
    ChartDataPoint(label: 'Apr', value: 138000),
    ChartDataPoint(label: 'May', value: 152000),
    ChartDataPoint(label: 'Jun', value: 168000),
  ];
});

final occupancyRateProvider = Provider<double>((ref) => 78.5);

final avgStayDurationProvider = Provider<double>((ref) => 4.2);

final patientSatisfactionProvider = Provider<double>((ref) => 92.3);
