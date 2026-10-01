enum BusinessType {
  restaurant,
  takeaway,
  offLicence,
  convenience,
  barber,
  beauty,
  garage,
  trades,
  professional,
  other,
}

enum PipelineStage {
  newLead,
  contacted,
  auditDone,
  proposalSent,
  negotiating,
  won,
  notNow,
  lost,
}

enum LeadTemp { hot, warm, cold }

enum HealthLevel { strong, needsWork, poor }

extension BusinessTypeLabel on BusinessType {
  String get label => switch (this) {
        BusinessType.restaurant => 'Restaurant',
        BusinessType.takeaway => 'Takeaway',
        BusinessType.offLicence => 'Off-licence',
        BusinessType.convenience => 'Convenience store',
        BusinessType.barber => 'Barber',
        BusinessType.beauty => 'Beauty / salon',
        BusinessType.garage => 'Garage / automotive',
        BusinessType.trades => 'Trades',
        BusinessType.professional => 'Professional service',
        BusinessType.other => 'Other',
      };
}

extension PipelineStageLabel on PipelineStage {
  String get label => switch (this) {
        PipelineStage.newLead => 'New Lead',
        PipelineStage.contacted => 'Contacted',
        PipelineStage.auditDone => 'Audit Done',
        PipelineStage.proposalSent => 'Proposal Sent',
        PipelineStage.negotiating => 'Negotiating',
        PipelineStage.won => 'Won',
        PipelineStage.notNow => 'Not Now',
        PipelineStage.lost => 'Lost',
      };
}

extension LeadTempLabel on LeadTemp {
  String get label => switch (this) {
        LeadTemp.hot => 'Hot',
        LeadTemp.warm => 'Warm',
        LeadTemp.cold => 'Cold',
      };
}

class DigitalHealth {
  final HealthLevel website;
  final HealthLevel google;
  final HealthLevel social;
  final HealthLevel acquisition;
  final HealthLevel growth;

  const DigitalHealth({
    required this.website,
    required this.google,
    required this.social,
    required this.acquisition,
    required this.growth,
  });

  HealthLevel get overall {
    final scores = [website, google, social, acquisition, growth]
        .map((h) => switch (h) {
              HealthLevel.strong => 2,
              HealthLevel.needsWork => 1,
              HealthLevel.poor => 0,
            })
        .toList();
    final avg = scores.reduce((a, b) => a + b) / scores.length;
    if (avg >= 1.5) return HealthLevel.strong;
    if (avg >= 0.75) return HealthLevel.needsWork;
    return HealthLevel.poor;
  }
}

class ServicePackage {
  final String id;
  final String name;
  final int priceMonthly;
  final List<String> includes;

  const ServicePackage({
    required this.id,
    required this.name,
    required this.priceMonthly,
    required this.includes,
  });
}

class Business {
  final String id;
  final String name;
  final BusinessType type;
  final String address;
  final String owner;
  final String phone;
  final String email;
  final String? website;
  final bool hasGoogleProfile;
  final List<String> socialMedia;
  final PipelineStage stage;
  final LeadTemp temperature;
  final DigitalHealth health;
  final String? packageName;
  final int? monthlyRevenue;
  final String? primaryGoal;
  final String? mainChallenge;
  final String nextAction;
  final DateTime nextActionDate;
  final List<String> services;
  final List<String> activity;
  final String territory;
  final bool financeInterest;

  const Business({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.owner,
    required this.phone,
    required this.email,
    this.website,
    required this.hasGoogleProfile,
    required this.socialMedia,
    required this.stage,
    required this.temperature,
    required this.health,
    this.packageName,
    this.monthlyRevenue,
    this.primaryGoal,
    this.mainChallenge,
    required this.nextAction,
    required this.nextActionDate,
    required this.services,
    required this.activity,
    required this.territory,
    this.financeInterest = false,
  });
}

class TodayVisit {
  final String businessName;
  final String address;
  final String status;
  final String timeSlot;

  const TodayVisit({
    required this.businessName,
    required this.address,
    required this.status,
    required this.timeSlot,
  });
}
