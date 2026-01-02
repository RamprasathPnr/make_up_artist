import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_navigation_bar.dart';
import '../../../shared/widgets/service_card.dart';
import '../../../shared/widgets/cta_button.dart';

/// Services page displaying all makeup, mehendi, and facial services
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppNavigationBar(),
          ),
          SliverToBoxAdapter(
            child: _ServicesContent(isMobile: isMobile),
          ),
        ],
      ),
    );
  }
}

class _ServicesContent extends StatelessWidget {
  const _ServicesContent({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 96,
            vertical: 64,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.ourServices,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Tamil translation label removed; showing English heading only
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.premiumBeautyServices,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textLight,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),

        // Makeup Services
        _ServiceSection(
          title: 'Makeup Services',
          icon: Icons.brush,
          services: [
            {
              'title': 'HD Makeup',
              'description':
                  'High-definition makeup for flawless, camera-ready looks',
              'icon': Icons.high_quality,
              'image': 'https://source.unsplash.com/600x600/?tamil,hd-makeup,portrait',
            },
            {
              'title': 'Glass Finish Makeup',
              'description':
                  'Achieve a dewy, glass-like finish for a radiant glow',
              'icon': Icons.auto_awesome,
              'image': 'https://source.unsplash.com/600x600/?tamil,glass-skin,makeup',
            },
            {
              'title': 'Matte Finish Makeup',
              'description':
                  'Long-lasting matte finish perfect for all-day events',
              'icon': Icons.style,
              'image': 'https://source.unsplash.com/600x600/?tamil,matte-makeup,portrait',
            },
            {
              'title': 'Waterproof Makeup',
              'description':
                  'Smudge-proof and waterproof makeup that lasts all day',
              'icon': Icons.water_drop,
              'image': 'https://source.unsplash.com/600x600/?tamil,waterproof-makeup,portrait',
            },
          ],
          isMobile: isMobile,
        ),

        // Mehendi Services
        _ServiceSection(
          title: 'Mehendi Services',
          icon: Icons.auto_awesome,
          services: [
            {
              'title': 'Organic Mehendi',
              'description':
                  'Natural, organic henna for beautiful, long-lasting designs',
              'icon': Icons.eco,
              'image': 'https://source.unsplash.com/600x600/?tamil,mehendi,bridal',
            },
            {
              'title': 'Bridal Mehendi',
              'description':
                  'Intricate bridal mehendi designs for your special day',
              'icon': Icons.favorite,
              'image': 'https://source.unsplash.com/600x600/?tamil,bridal-mehendi,henna',
            },
            {
              'title': 'Arabic Mehendi',
              'description':
                  'Elegant Arabic patterns with floral and geometric designs',
              'icon': Icons.auto_awesome,
              'image': 'https://source.unsplash.com/600x600/?tamil,mehendi,design',
            },
            {
              'title': 'African Mehendi',
              'description':
                  'Bold and beautiful African-inspired mehendi patterns',
              'icon': Icons.brush,
              'image': 'https://source.unsplash.com/600x600/?tamil,bridal-portrait,makeup',
            },
          ],
          isMobile: isMobile,
        ),

        // Facial Services
        _ServiceSection(
          title: 'Facial Services',
          icon: Icons.face,
          services: [
            {
              'title': 'Hydro Facial',
              'description':
                  'Deep cleansing and hydration for glowing, refreshed skin',
              'icon': Icons.water_drop,
              'image': 'https://source.unsplash.com/600x600/?tamil,facial,skincare',
            },
            {
              'title': 'Fruit Facial',
              'description':
                  'Natural fruit extracts for brightening and rejuvenation',
              'icon': Icons.local_florist,
              'image': 'https://source.unsplash.com/600x600/?tamil,fruit-facial,skincare',
            },
            {
              'title': 'Golden Facial',
              'description':
                  'Luxurious gold-infused treatment for radiant skin',
              'icon': Icons.star,
              'image': 'https://source.unsplash.com/600x600/?tamil,golden-facial,skincare',
            },
            {
              'title': 'Diamond Facial',
              'description':
                  'Premium diamond facial for ultimate skin transformation',
              'icon': Icons.diamond,
              'image': 'https://source.unsplash.com/600x600/?tamil,diamond-facial,skincare',
            },
          ],
          isMobile: isMobile,
        ),

        // CTA Section
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 96,
            vertical: 64,
          ),
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Interested in Our Services?',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Contact us to book your appointment',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textLight,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Responsive button layout
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    // Stack buttons vertically on small screens
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: double.infinity,
                          child: WhatsAppButton(),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: CallButton(),
                        ),
                      ],
                    );
                  } else {
                    // Show buttons side by side on larger screens
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: WhatsAppButton(),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: CallButton(),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Service section widget
class _ServiceSection extends StatelessWidget {
  const _ServiceSection({
    required this.title,
    required this.icon,
    required this.services,
    required this.isMobile,
  });

  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> services;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 96,
        vertical: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.rosePinkLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: AppTheme.rosePink, size: 28),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 0.75 : 0.7, // Adjusted for images
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              return ServiceCard(
                title: service['title'] as String,
                description: service['description'] as String,
                icon: service['icon'] as IconData,
                imageUrl: service['image'] as String?,
              );
            },
          ),
        ],
      ),
    );
  }
}

