import 'package:flutter/material.dart';

class WardOverviewPanel extends StatefulWidget {
  final int criticalCount;
  final int pendingReminders;
  final int overdueReminders;

  const WardOverviewPanel({
    super.key,
    required this.criticalCount,
    required this.pendingReminders,
    required this.overdueReminders,
  });

  @override
  State<WardOverviewPanel> createState() => _WardOverviewPanelState();
}

class _WardOverviewPanelState extends State<WardOverviewPanel> {
  bool _icuExpanded = true;
  bool _emergencyExpanded = false;
  bool _pediatricsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0F14),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildWardSection(
            title: 'General',
            count: 6,
            color: const Color(0xFF3B82F6),
            expanded: false,
            onToggle: null,
          ),
          _buildWardSection(
            title: 'ICU',
            count: 2,
            color: const Color(0xFFEF4444),
            expanded: _icuExpanded,
            onToggle: () => setState(() => _icuExpanded = !_icuExpanded),
            children: const [
              _PatientTile(name: 'Fatima Zahra', room: 'ICU-05'),
              _PatientTile(name: 'Imran Hussain', room: 'ICU-02'),
            ],
          ),
          _buildWardSection(
            title: 'Emergency',
            count: 1,
            color: const Color(0xFFF97316),
            expanded: _emergencyExpanded,
            onToggle: () =>
                setState(() => _emergencyExpanded = !_emergencyExpanded),
            children: const [
              _PatientTile(name: 'Bilal Ahmed', room: 'E-301'),
            ],
          ),
          _buildWardSection(
            title: 'Pediatrics',
            count: 2,
            color: const Color(0xFFEC4899),
            expanded: _pediatricsExpanded,
            onToggle: () =>
                setState(() => _pediatricsExpanded = !_pediatricsExpanded),
          ),
          const Spacer(),
          _buildFooterStats(),
        ],
      ),
    );
  }

  /// ---------- HEADER ----------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Ward Overview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '15 patients across 6 wards',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 13,
              ),
            ),
          ],
        ),
        if (widget.criticalCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF7F1D1D),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Color(0xFFEF4444), size: 14),
                const SizedBox(width: 4),
                Text(
                  '${widget.criticalCount} Critical',
                  style: const TextStyle(
                    color: Color(0xFFEF4444),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// ---------- WARD SECTION ----------
  Widget _buildWardSection({
    required String title,
    required int count,
    required Color color,
    required bool expanded,
    required VoidCallback? onToggle,
    List<Widget>? children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 28,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$count patients',
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onToggle != null)
                    Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xFF9CA3AF),
                    ),
                ],
              ),
            ),
          ),
          if (expanded && children != null)
            Column(
              children: children,
            ),
        ],
      ),
    );
  }

  /// ---------- FOOTER STATS ----------
  Widget _buildFooterStats() {
    return Column(
      children: [
        const Divider(color: Color(0xFF1F2937)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFooterItem(
              label: 'Pending',
              value: widget.pendingReminders.toString(),
              color: const Color(0xFFFBBF24),
            ),
            _buildFooterItem(
              label: 'Overdue',
              value: widget.overdueReminders.toString(),
              color: const Color(0xFFEF4444),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// ---------- PATIENT TILE ----------
class _PatientTile extends StatelessWidget {
  final String name;
  final String room;

  const _PatientTile({
    required this.name,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Color(0xFFEF4444)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            room,
            style: const TextStyle(
              color: Color(0xFF60A5FA),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
