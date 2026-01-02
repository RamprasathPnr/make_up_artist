import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_navigation_bar.dart';
import '../../../shared/widgets/cta_button.dart';
import '../../../shared/widgets/image_placeholder.dart';

/// Home page with hero section and primary CTAs
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: CustomScrollView(
        slivers: [
          // Sticky Navigation Bar
          SliverToBoxAdapter(
            child: AppNavigationBar(),
          ),

          // Hero Section
          SliverToBoxAdapter(
            child: _HeroSection(isMobile: isMobile, isTablet: isTablet),
          ),

          // Features Section
          SliverToBoxAdapter(
            child: _FeaturesSection(isMobile: isMobile),
          ),

          // CTA Section
          SliverToBoxAdapter(
            child: _CTASection(isMobile: isMobile),
          ),

          // Footer
          SliverToBoxAdapter(
            child: _Footer(),
          ),
        ],
      ),
    );
  }
}


/// Decorative pattern painter for Tamil-inspired designs
class _DecorativePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.gold
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 3;

    // Draw decorative circular patterns
    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(
        center,
        radius - (i * 30),
        paint..strokeWidth = 3 - (i * 0.5),
      );
    }

    // Draw decorative lines (8-pointed star pattern)
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * math.pi / 180;
      final start = Offset(
        center.dx + (radius * 0.4) * math.cos(angle),
        center.dy + (radius * 0.4) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }

    // Draw small decorative dots
    final dotPaint = Paint()
      ..color = AppTheme.gold
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * math.pi / 180;
      final dotCenter = Offset(
        center.dx + (radius * 0.7) * math.cos(angle),
        center.dy + (radius * 0.7) * math.sin(angle),
      );
      canvas.drawCircle(dotCenter, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Hero section with bridal image and tagline
class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.isMobile,
    required this.isTablet,
  });

  final bool isMobile;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isMobile ? 500 : 600,
      decoration: BoxDecoration(
        // Background gradient (asset image layered below in Stack)
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.rosePinkLight.withOpacity(0.3),
            AppTheme.offWhite,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Use network image on web to avoid missing local assets during dev;
          // otherwise prefer a local asset.
          Positioned.fill(
            child: kIsWeb
                ? Image.network(
                    'https://source.unsplash.com/1600x900/?makeup,brush,bride,tamil',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  )
                : Image.asset(
                    'assets/images/home_hero.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
          ),

          // Background with gradient and decorative pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.rosePink.withOpacity(0.8),
                    AppTheme.rosePinkDark.withOpacity(0.9),
                    AppTheme.gold.withOpacity(0.3),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Decorative pattern
                  // Positioned.fill(
                  //   child: Opacity(
                  //     opacity: 0.15,
                  //     child: CustomPaint(
                  //       painter: _DecorativePatternPainter(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),

          // Content Overlay
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : isTablet ? 48 : 96,
                vertical: isMobile ? 40 : 80,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Business Name (Bilingual)
                  Column(
                    children: [
                      Text(
                        AppConstants.businessName,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tagline (Bilingual)
                  Text(
                    AppConstants.tagline,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                  ),
                  const SizedBox(height: 40),

                  // CTAs
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      const WhatsAppButton(),
                      const CallButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Features highlight section
class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 96,
        vertical: 64,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                AppStrings.whyChooseUs,
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 3,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 2.5 : 1.2,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              final features = [
                {
                  'icon': Icons.brush,
                  'title': 'Expert Artists',
                  'description': 'Professional makeup artists with years of experience',
                },
                {
                  'icon': Icons.star,
                  'title': 'Premium Products',
                  'description': 'High-quality makeup products for flawless looks',
                },
                {
                  'icon': Icons.celebration,
                  'title': 'Bridal Specialists',
                  'description': 'Specialized in creating your perfect bridal look',
                },
              ];
              final feature = features[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        feature['icon'] as IconData,
                        size: 48,
                        color: AppTheme.rosePink,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        feature['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['description'] as String,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Call-to-action section
class _CTASection extends StatelessWidget {
  const _CTASection({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 96,
        vertical: 64,
      ),
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.rosePink,
            AppTheme.rosePinkDark,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.rosePink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppStrings.readyToLookStunning,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppTheme.white,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.bookAppointment,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.white.withOpacity(0.9),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              const WhatsAppButton(),
              const CallButton(),
            ],
          ),
        ],
      ),
    );
  }
}

/// Footer section
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: AppTheme.textDark,
      child: Column(
        children: [
          Text(
            AppConstants.businessName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.white,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} ${AppConstants.businessName}. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.white.withOpacity(0.7),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

