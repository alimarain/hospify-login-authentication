import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/filter_state.dart';

final filterProvider =
    StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState());

  void toggleStatus(String value) {
    final list = [...state.status];
    list.contains(value) ? list.remove(value) : list.add(value);
    state = state.copyWith(status: list);
  }

  void toggleGender(String value) {
    final list = [...state.gender];
    list.contains(value) ? list.remove(value) : list.add(value);
    state = state.copyWith(gender: list);
  }

  void toggleDiagnosis(String value) {
    final list = [...state.diagnosis];
    list.contains(value) ? list.remove(value) : list.add(value);
    state = state.copyWith(diagnosis: list);
  }

  void setAgeMin(String value) => state = state.copyWith(ageMin: value);
  void setAgeMax(String value) => state = state.copyWith(ageMax: value);
  void setDateFrom(String value) => state = state.copyWith(dateFrom: value);
  void setDateTo(String value) => state = state.copyWith(dateTo: value);

  void clearAll() {
    state = FilterState();
  }
}
