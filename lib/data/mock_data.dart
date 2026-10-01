import '../models/business.dart';

class MockData {
  static const salesperson = 'Alex Morgan';
  static const territory = 'South London — Zone A';

  static const packages = [
    ServicePackage(
      id: 'starter',
      name: 'Starter',
      priceMonthly: 20,
      includes: ['Basic website', 'Hosting', 'Contact form'],
    ),
    ServicePackage(
      id: 'growth',
      name: 'Growth',
      priceMonthly: 49,
      includes: ['Website', 'Google optimisation', 'Social posts'],
    ),
    ServicePackage(
      id: 'business',
      name: 'Business Growth',
      priceMonthly: 99,
      includes: [
        'Website',
        'Hosting',
        'Google',
        'Social Media',
        'SEO',
        'Monthly marketing',
      ],
    ),
    ServicePackage(
      id: 'custom',
      name: 'Custom',
      priceMonthly: 199,
      includes: ['Everything in Business Growth', 'Custom campaigns', 'Priority support'],
    ),
  ];

  static final businesses = [
    Business(
      id: '1',
      name: 'ABC Restaurant',
      type: BusinessType.restaurant,
      address: '123 High Street, Brixton, London',
      owner: 'John Smith',
      phone: '07700 900123',
      email: 'john@abc.co.uk',
      website: null,
      hasGoogleProfile: true,
      socialMedia: ['Instagram', 'Facebook'],
      stage: PipelineStage.proposalSent,
      temperature: LeadTemp.hot,
      health: const DigitalHealth(
        website: HealthLevel.poor,
        google: HealthLevel.needsWork,
        social: HealthLevel.needsWork,
        acquisition: HealthLevel.needsWork,
        growth: HealthLevel.strong,
      ),
      packageName: 'Business Growth',
      monthlyRevenue: 99,
      primaryGoal: 'More customers',
      mainChallenge: 'Competition from nearby restaurants',
      nextAction: 'Call owner',
      nextActionDate: DateTime(2026, 10, 3),
      services: ['Website', 'Google', 'Social Media', 'SEO', 'Marketing'],
      activity: [
        '01 Oct — Assessment completed',
        '01 Oct — Proposal sent (£99)',
        '02 Oct — Owner reviewing package',
      ],
      territory: 'Brixton',
      financeInterest: true,
    ),
    Business(
      id: '2',
      name: 'Fade & Blade Barbers',
      type: BusinessType.barber,
      address: '45 Acre Lane, Brixton',
      owner: 'Marcus Lee',
      phone: '07700 900456',
      email: 'marcus@fadeblade.uk',
      website: 'fadeblade.uk',
      hasGoogleProfile: true,
      socialMedia: ['Instagram'],
      stage: PipelineStage.won,
      temperature: LeadTemp.hot,
      health: const DigitalHealth(
        website: HealthLevel.needsWork,
        google: HealthLevel.strong,
        social: HealthLevel.strong,
        acquisition: HealthLevel.strong,
        growth: HealthLevel.needsWork,
      ),
      packageName: 'Growth',
      monthlyRevenue: 49,
      primaryGoal: 'More bookings',
      mainChallenge: 'Inconsistent Instagram posting',
      nextAction: 'Onboarding call',
      nextActionDate: DateTime(2026, 10, 1),
      services: ['Website improvements', 'Google', 'Social Media'],
      activity: [
        '28 Sep — Signed up',
        '29 Sep — Website brief received',
        '30 Sep — Draft homepage ready',
      ],
      territory: 'Brixton',
    ),
    Business(
      id: '3',
      name: 'Corner Convenience',
      type: BusinessType.convenience,
      address: '8 Coldharbour Lane, Brixton',
      owner: 'Priya Patel',
      phone: '07700 900789',
      email: 'priya@cornerstore.co.uk',
      website: null,
      hasGoogleProfile: false,
      socialMedia: [],
      stage: PipelineStage.contacted,
      temperature: LeadTemp.warm,
      health: const DigitalHealth(
        website: HealthLevel.poor,
        google: HealthLevel.poor,
        social: HealthLevel.poor,
        acquisition: HealthLevel.needsWork,
        growth: HealthLevel.needsWork,
      ),
      primaryGoal: 'More walk-ins',
      mainChallenge: 'People don\'t know we exist online',
      nextAction: 'Complete digital audit',
      nextActionDate: DateTime(2026, 9, 30),
      services: [],
      activity: [
        '29 Sep — Door visit — Owner available',
        '29 Sep — Interest confirmed',
      ],
      territory: 'Brixton',
    ),
    Business(
      id: '4',
      name: 'Glow Beauty Studio',
      type: BusinessType.beauty,
      address: '22 Electric Avenue, Brixton',
      owner: 'Sofia Reyes',
      phone: '07700 900321',
      email: 'hello@glowbeauty.uk',
      website: 'glowbeauty.uk',
      hasGoogleProfile: true,
      socialMedia: ['Instagram', 'TikTok'],
      stage: PipelineStage.negotiating,
      temperature: LeadTemp.hot,
      health: const DigitalHealth(
        website: HealthLevel.needsWork,
        google: HealthLevel.strong,
        social: HealthLevel.strong,
        acquisition: HealthLevel.strong,
        growth: HealthLevel.strong,
      ),
      packageName: 'Business Growth',
      monthlyRevenue: 99,
      primaryGoal: 'Online booking',
      mainChallenge: 'Website looks outdated',
      nextAction: 'Send revised proposal',
      nextActionDate: DateTime(2026, 10, 2),
      services: ['Website', 'Online booking', 'Social Media', 'Marketing'],
      activity: [
        '27 Sep — Audit completed',
        '28 Sep — Proposal sent',
        '29 Sep — Asked about booking system',
      ],
      territory: 'Brixton',
    ),
    Business(
      id: '5',
      name: 'Swift Motoring',
      type: BusinessType.garage,
      address: '91 Streatham High Rd',
      owner: 'Dave Collins',
      phone: '07700 900654',
      email: 'dave@swiftmotoring.co.uk',
      website: null,
      hasGoogleProfile: true,
      socialMedia: ['Facebook'],
      stage: PipelineStage.notNow,
      temperature: LeadTemp.cold,
      health: const DigitalHealth(
        website: HealthLevel.poor,
        google: HealthLevel.needsWork,
        social: HealthLevel.needsWork,
        acquisition: HealthLevel.needsWork,
        growth: HealthLevel.poor,
      ),
      primaryGoal: 'More phone enquiries',
      mainChallenge: 'Busy season — revisit later',
      nextAction: 'Follow-up call',
      nextActionDate: DateTime(2026, 11, 15),
      services: [],
      activity: [
        '20 Sep — Visited — Asked to return in Nov',
      ],
      territory: 'Streatham',
    ),
    Business(
      id: '6',
      name: 'Spice Route Takeaway',
      type: BusinessType.takeaway,
      address: '15 Brixton Road',
      owner: 'Amir Khan',
      phone: '07700 900987',
      email: 'amir@spiceroute.uk',
      website: null,
      hasGoogleProfile: false,
      socialMedia: ['WhatsApp'],
      stage: PipelineStage.auditDone,
      temperature: LeadTemp.warm,
      health: const DigitalHealth(
        website: HealthLevel.poor,
        google: HealthLevel.poor,
        social: HealthLevel.needsWork,
        acquisition: HealthLevel.needsWork,
        growth: HealthLevel.strong,
      ),
      primaryGoal: 'Online ordering',
      mainChallenge: 'Rely only on walk-ins and WhatsApp',
      nextAction: 'Present Growth package',
      nextActionDate: DateTime(2026, 10, 1),
      services: [],
      activity: [
        '30 Sep — Growth assessment done',
        '30 Sep — Digital audit complete',
      ],
      territory: 'Brixton',
    ),
  ];

  static const todayVisits = [
    TodayVisit(
      businessName: 'Corner Convenience',
      address: '8 Coldharbour Lane',
      status: 'Audit due',
      timeSlot: '10:00',
    ),
    TodayVisit(
      businessName: 'Spice Route Takeaway',
      address: '15 Brixton Road',
      status: 'Present package',
      timeSlot: '11:30',
    ),
    TodayVisit(
      businessName: 'Fresh Cuts Barbers',
      address: '3 Market Row',
      status: 'First visit',
      timeSlot: '13:00',
    ),
    TodayVisit(
      businessName: 'Lotus Nails',
      address: '67 Acre Lane',
      status: 'First visit',
      timeSlot: '15:00',
    ),
  ];

  static List<Business> followUpsDue({DateTime? on}) {
    final day = on ?? DateTime(2026, 9, 30);
    return businesses.where((b) {
      return b.nextActionDate.year == day.year &&
          b.nextActionDate.month == day.month &&
          b.nextActionDate.day == day.day;
    }).toList();
  }

  static Map<PipelineStage, List<Business>> get pipeline {
    final map = <PipelineStage, List<Business>>{};
    for (final stage in PipelineStage.values) {
      map[stage] = businesses.where((b) => b.stage == stage).toList();
    }
    return map;
  }

  static int get activeCustomers =>
      businesses.where((b) => b.stage == PipelineStage.won).length;

  static int get mrr => businesses
      .where((b) => b.stage == PipelineStage.won && b.monthlyRevenue != null)
      .fold(0, (sum, b) => sum + (b.monthlyRevenue ?? 0));
}
