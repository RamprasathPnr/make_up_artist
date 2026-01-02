import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Using local assets instead of cached network images
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_navigation_bar.dart';
import '../../../shared/widgets/image_placeholder.dart';

/// Gallery page with responsive grid and lightbox functionality
class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  // Sample gallery images - Use placeholder gradients when images fail
  // Replace these with actual image URLs when available
  static final List<Map<String, dynamic>> galleryImages = [
    {'url': 'https://source.unsplash.com/800x800/?tamil,bride,makeup', 'label': 'Bridal Makeup'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,mehendi,henna', 'label': 'Mehendi Design'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,party,makeup', 'label': 'Party Makeup'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,facial,skincare', 'label': 'Facial Treatment'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,portrait,hd', 'label': 'HD Makeup'},
    {'url': 'https://source.unsplash.com/800x800/?makeup,glass-skin,tamil', 'label': 'Glass Finish'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,bridal,portrait', 'label': 'Bridal Look'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,wedding,makeover', 'label': 'Special Occasion'},
    {'url': 'https://source.unsplash.com/800x800/?tamil,transformation,makeup', 'label': 'Makeover'},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isTablet = MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1024;

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppNavigationBar(),
          ),
          SliverToBoxAdapter(
            child: _GalleryContent(
              isMobile: isMobile,
              isTablet: isTablet,
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryContent extends StatelessWidget {
  const _GalleryContent({
    required this.isMobile,
    required this.isTablet,
  });

  final bool isMobile;
  final bool isTablet;

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
                    AppStrings.ourGallery,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Removed Tamil translation label — showing English heading only
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.browseWork,
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

        // Image Grid
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : isTablet ? 48 : 96,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : isTablet ? 3 : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: GalleryPage.galleryImages.length,
            itemBuilder: (context, index) {
              final imageData = GalleryPage.galleryImages[index];
              return _GalleryImageItem(
                imageUrl: imageData['url'] as String,
                label: imageData['label'] as String,
                onTap: () => _showImageLightbox(
                  context,
                  GalleryPage.galleryImages.map((e) => e['url'] as String).toList(),
                  index,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 64),
      ],
    );
  }

  void _showImageLightbox(
    BuildContext context,
    List<String> images,
    int initialIndex,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) => _ImageLightbox(
        images: images,
        initialIndex: initialIndex,
      ),
    );
  }
}

/// Gallery image item with lazy loading and beautiful fallback
class _GalleryImageItem extends StatelessWidget {
  const _GalleryImageItem({
    required this.imageUrl,
    required this.label,
    required this.onTap,
  });

  final String imageUrl;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Prefer network images on web for dev; otherwise use local assets
            Builder(builder: (context) {
              if (kIsWeb && imageUrl.startsWith('http')) {
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => ImagePlaceholder(
                    icon: Icons.auto_awesome,
                    label: label,
                  ),
                );
              }
              final uri = Uri.tryParse(imageUrl);
              final lastSegment = (uri != null && uri.pathSegments.isNotEmpty)
                  ? uri.pathSegments.last
                  : (uri != null ? uri.host : 'placeholder.png');
              final assetPath = imageUrl.startsWith('http') ? 'assets/images/$lastSegment' : imageUrl;
              return Image.asset(
                assetPath,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) => ImagePlaceholder(
                  icon: Icons.auto_awesome,
                  label: label,
                ),
              );
            }),
            // Overlay with label on hover
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Image lightbox dialog for full-screen viewing
class _ImageLightbox extends StatefulWidget {
  const _ImageLightbox({
    required this.images,
    required this.initialIndex,
  });

  final List<String> images;
  final int initialIndex;

  @override
  State<_ImageLightbox> createState() => _ImageLightboxState();
}

class _ImageLightboxState extends State<_ImageLightbox> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Image Viewer
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                  child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Builder(builder: (context) {
                    if (kIsWeb && widget.images[index].startsWith('http')) {
                      return Image.network(
                        widget.images[index],
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.white,
                          ),
                        ),
                      );
                    }
                    final uri = Uri.tryParse(widget.images[index]);
                    final lastSegment = (uri != null && uri.pathSegments.isNotEmpty)
                        ? uri.pathSegments.last
                        : (uri != null ? uri.host : 'placeholder.png');
                    final assetPath = widget.images[index].startsWith('http')
                        ? 'assets/images/$lastSegment'
                        : widget.images[index];
                    return Image.asset(
                      assetPath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.white,
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),

          // Close Button
          Positioned(
            top: 40,
            right: 40,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppTheme.white, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Image Counter
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(
                    color: AppTheme.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          // Navigation Arrows
          if (widget.images.length > 1) ...[
            if (_currentIndex > 0)
              Positioned(
                left: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppTheme.white,
                      size: 40,
                    ),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
            if (_currentIndex < widget.images.length - 1)
              Positioned(
                right: 20,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppTheme.white,
                      size: 40,
                    ),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

