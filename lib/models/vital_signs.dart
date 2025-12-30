class VitalSigns {
  final String bloodPressure;
  final int heartRate;
  final double temperature;
  final int respiratoryRate;
  final int oxygenSaturation;
  final double weight;
  final DateTime lastUpdated;

  VitalSigns({
    required this.bloodPressure,
    required this.heartRate,
    required this.temperature,
    required this.respiratoryRate,
    required this.oxygenSaturation,
    required this.weight,
    required this.lastUpdated,
  });

  VitalSigns copyWith({
    String? bloodPressure,
    int? heartRate,
    double? temperature,
    int? respiratoryRate,
    int? oxygenSaturation,
    double? weight,
    DateTime? lastUpdated,
  }) {
    return VitalSigns(
      bloodPressure: bloodPressure ?? this.bloodPressure,
      heartRate: heartRate ?? this.heartRate,
      temperature: temperature ?? this.temperature,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      weight: weight ?? this.weight,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
