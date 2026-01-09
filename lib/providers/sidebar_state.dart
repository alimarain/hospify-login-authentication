// web_sidebar_state.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sidebarCollapsedProvider = StateProvider<bool>((ref) => false);
final sidebarHoverProvider = StateProvider<bool>((ref) => false);
