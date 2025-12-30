class FilterState {
  List<String> status;
  List<String> gender;
  String ageMin;
  String ageMax;
  String dateFrom;
  String dateTo;
  List<String> diagnosis;

  FilterState({
    this.status = const [],
    this.gender = const [],
    this.ageMin = '',
    this.ageMax = '',
    this.dateFrom = '',
    this.dateTo = '',
    this.diagnosis = const [],
  });

  FilterState copyWith({
    List<String>? status,
    List<String>? gender,
    String? ageMin,
    String? ageMax,
    String? dateFrom,
    String? dateTo,
    List<String>? diagnosis,
  }) {
    return FilterState(
      status: status ?? this.status,
      gender: gender ?? this.gender,
      ageMin: ageMin ?? this.ageMin,
      ageMax: ageMax ?? this.ageMax,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      diagnosis: diagnosis ?? this.diagnosis,
    );
  }
}
