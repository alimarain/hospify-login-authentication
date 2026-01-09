import 'package:flutter_riverpod/flutter_riverpod.dart';

const double sidebarMinWidth = 220;
const double sidebarMaxWidth = 360;
const double sidebarCollapsedWidth = 84;

final sidebarWidthProvider = StateProvider<double>(
  (ref) => 290, // default expanded width
);
