import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'assessment_screen.dart';

class DigitalAuditScreen extends StatefulWidget {
  final Business business;

  const DigitalAuditScreen({super.key, required this.business});

  @override
  State<DigitalAuditScreen> createState() => _DigitalAuditScreenState();
}

class _DigitalAuditScreenState extends State<DigitalAuditScreen> {
  late HealthLevel website;
  late HealthLevel google;
  late HealthLevel social;
  late HealthLevel acquisition;
  late HealthLevel growth;

  @override
  void initState() {
    super.initState();
    website = widget.business.health.website;
    google = widget.business.health.google;
    social = widget.business.health.social;
    acquisition = widget.business.health.acquisition;
    growth = widget.business.health.growth;
  }

  String _recommendation(String area, HealthLevel level) {
    if (level == HealthLevel.strong) {
      return 'Looking solid — maintain and monitor.';
    }
    return switch (area) {
      'Website' =>
        'Create a mobile-friendly website with menu, location, WhatsApp and enquiry functionality.',
      'Google' =>
        'Claim and optimise Google Business Profile with photos, hours and services.',
      'Social Media' =>
        'Set a simple weekly posting plan on the platforms customers already use.',
      'Customer Acquisition' =>
        'Clarify where customers come from and plug the biggest leak first.',
      _ => 'Map growth plans into a 90-day digital action list.',
    };
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Website', website, (HealthLevel v) => setState(() => website = v)),
      ('Google', google, (HealthLevel v) => setState(() => google = v)),
      ('Social Media', social, (HealthLevel v) => setState(() => social = v)),
      (
        'Customer Acquisition',
        acquisition,
        (HealthLevel v) => setState(() => acquisition = v),
      ),
      ('Growth Opportunity', growth, (HealthLevel v) => setState(() => growth = v)),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Digital health check')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            widget.business.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap each item and set the health level.',
            style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          ...items.map((item) {
            final (label, level, onChange) = item;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      HealthDot(level: level, size: 12),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        HealthDot(level: level).label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: HealthLevel.values.map((h) {
                      final selected = level == h;
                      return ChoiceChip(
                        label: Text(HealthDot(level: h).label),
                        selected: selected,
                        onSelected: (_) => onChange(h),
                        avatar: HealthDot(level: h, size: 8),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.canvas,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommendation',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(_recommendation(label, level)),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.forest,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AssessmentScreen(business: widget.business),
                ),
              );
            },
            child: const Text(
              'Continue to growth assessment',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
