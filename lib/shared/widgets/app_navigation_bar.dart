import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

/// Sticky navigation bar for web with smooth scroll navigation
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current route path from GoRouter
    String currentPath = '/';
    try {
      final router = GoRouter.of(context);
      currentPath = router.routerDelegate.currentConfiguration.uri.path;
    } catch (e) {
      // Fallback to home if router not available
      currentPath = AppConstants.homeRoute;
    }
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 48,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/Brand Name
              Text(
                AppConstants.businessName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.rosePink,
                      fontWeight: FontWeight.bold,
                    ),
              ),

              // Navigation Links (Desktop)
              if (!isMobile) ...[
                _NavLink(
                  label: 'Home',
                  route: AppConstants.homeRoute,
                  isActive: currentPath == AppConstants.homeRoute,
                ),
                _NavLink(
                  label: 'Services',
                  route: AppConstants.servicesRoute,
                  isActive: currentPath == AppConstants.servicesRoute,
                ),
                _NavLink(
                  label: 'Gallery',
                  route: AppConstants.galleryRoute,
                  isActive: currentPath == AppConstants.galleryRoute,
                ),
                _NavLink(
                  label: 'Contact',
                  route: AppConstants.contactRoute,
                  isActive: currentPath == AppConstants.contactRoute,
                ),
              ],

              // Mobile Menu Button
              if (isMobile)
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _showMobileMenu(context, currentPath),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context, String currentPath) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _MobileNavItem(
              label: 'Home',
              route: AppConstants.homeRoute,
              isActive: currentPath == AppConstants.homeRoute,
            ),
            _MobileNavItem(
              label: 'Services',
              route: AppConstants.servicesRoute,
              isActive: currentPath == AppConstants.servicesRoute,
            ),
            _MobileNavItem(
              label: 'Gallery',
              route: AppConstants.galleryRoute,
              isActive: currentPath == AppConstants.galleryRoute,
            ),
            _MobileNavItem(
              label: 'Contact',
              route: AppConstants.contactRoute,
              isActive: currentPath == AppConstants.contactRoute,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Desktop navigation link with hover effect
class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.route,
    required this.isActive,
  });

  final String label;
  final String route;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(route),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.rosePinkLight : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isActive ? AppTheme.rosePink : AppTheme.textDark,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
          ),
        ),
      ),
    );
  }
}

/// Mobile navigation item
class _MobileNavItem extends StatelessWidget {
  const _MobileNavItem({
    required this.label,
    required this.route,
    required this.isActive,
  });

  final String label;
  final String route;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isActive ? AppTheme.rosePink : AppTheme.textDark,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
      ),
      trailing: isActive
          ? const Icon(Icons.check, color: AppTheme.rosePink)
          : null,
      onTap: () {
        context.go(route);
        Navigator.pop(context);
      },
    );
  }
}

