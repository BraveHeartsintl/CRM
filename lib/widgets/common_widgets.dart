import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';

class HealthDot extends StatelessWidget {
  final HealthLevel level;
  final double size;

  const HealthDot({super.key, required this.level, this.size = 10});

  Color get color => switch (level) {
        HealthLevel.strong => AppColors.strong,
        HealthLevel.needsWork => AppColors.warn,
        HealthLevel.poor => AppColors.weak,
      };

  String get label => switch (level) {
        HealthLevel.strong => 'Strong',
        HealthLevel.needsWork => 'Needs work',
        HealthLevel.poor => 'Poor',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class TempChip extends StatelessWidget {
  final LeadTemp temp;

  const TempChip({super.key, required this.temp});

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (temp) {
      LeadTemp.hot => (const Color(0xFFFFE4E0), AppColors.weak),
      LeadTemp.warm => (AppColors.emberSoft, AppColors.ember),
      LeadTemp.cold => (const Color(0xFFE8EEF2), AppColors.cold),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        temp.label,
        style: TextStyle(color: fg, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}

class StageChip extends StatelessWidget {
  final PipelineStage stage;

  const StageChip({super.key, required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.forestSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        stage.label,
        style: const TextStyle(
          color: AppColors.forest,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color? accent;

  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final color = accent ?? AppColors.forest;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                color: AppColors.forest,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}

class BusinessCard extends StatelessWidget {
  final Business business;
  final VoidCallback? onTap;

  const BusinessCard({super.key, required this.business, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    business.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TempChip(temp: business.temperature),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${business.type.label} · ${business.address}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                StageChip(stage: business.stage),
                const Spacer(),
                HealthDot(level: business.health.overall),
                const SizedBox(width: 6),
                Text(
                  HealthDot(level: business.health.overall).label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Next: ${business.nextAction}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceChips extends StatelessWidget {
  final List<String> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final bool multi;

  const ChoiceChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onToggle,
    this.multi = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final isOn = selected.contains(opt);
        return FilterChip(
          label: Text(opt),
          selected: isOn,
          onSelected: (_) {
            if (!multi) {
              onToggle(opt);
              return;
            }
            onToggle(opt);
          },
          selectedColor: AppColors.forest,
          checkmarkColor: AppColors.white,
          labelStyle: TextStyle(
            color: isOn ? AppColors.white : AppColors.ink,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: AppColors.white,
          side: BorderSide(
            color: isOn ? AppColors.forest : AppColors.line,
          ),
        );
      }).toList(),
    );
  }
}
