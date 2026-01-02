import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'image_placeholder.dart';

/// Reusable service card widget with elegant design and photos
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.imageUrl,
  });

  final String title;
  final String description;
  final IconData? icon;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    // Prepare image widget: prefer local asset. If a network URL is provided,
    // derive an asset filename from the URL's last path segment.
    Widget imageWidget;
    if (imageUrl != null) {
      if (kIsWeb && imageUrl!.startsWith('http')) {
        imageWidget = Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => ImagePlaceholder(
            icon: icon ?? Icons.auto_awesome,
            label: title,
          ),
        );
      } else {
        final uri = Uri.tryParse(imageUrl!);
        final lastSegment = (uri != null && uri.pathSegments.isNotEmpty)
            ? uri.pathSegments.last
            : (uri != null ? uri.host : 'placeholder.png');
        final assetPath = imageUrl!.startsWith('http') ? 'assets/images/$lastSegment' : imageUrl!;
        imageWidget = Image.asset(
          assetPath,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) => ImagePlaceholder(
            icon: icon ?? Icons.auto_awesome,
            label: title,
          ),
        );
      }
    } else {
      imageWidget = ImagePlaceholder(
        icon: icon ?? Icons.photo_camera,
        label: title,
      );
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 180,
              width: double.infinity,
              child: imageWidget,
            ),
            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null && imageUrl == null) ...[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.rosePinkLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: AppTheme.rosePink,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.rosePink,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textLight,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

