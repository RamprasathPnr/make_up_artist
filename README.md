# Pooja's Makeover Fashion Artist

A production-ready Flutter Web application for a premium beauty business specializing in bridal makeup, mehendi, and facial services.

## Features

- 🎨 **Beautiful UI/UX**: Elegant design with Rose Pink, Gold, and White color palette
- 📱 **Fully Responsive**: Mobile-first design that works seamlessly on all devices
- 🚀 **Performance Optimized**: Lazy loading, cached images, and optimized rebuilds
- 📞 **Direct CTAs**: WhatsApp and Call buttons for high conversion
- 🖼️ **Image Gallery**: Responsive grid with lightbox functionality
- 📝 **Contact Form**: Integrated form that sends messages via WhatsApp
- 🎯 **SEO Friendly**: Meta tags and proper web configuration

## Tech Stack

- **Flutter** (Latest stable)
- **Riverpod** - State management (no setState)
- **GoRouter** - Declarative routing
- **Google Fonts** - Playfair Display & Poppins
- **Cached Network Image** - Optimized image loading
- **URL Launcher** - Deep linking for WhatsApp and phone calls

## Project Structure

```
lib/
├── core/
│   ├── constants/       # App-wide constants
│   ├── routing/         # Router configuration
│   └── theme/           # Theme and styling
├── features/
│   ├── home/           # Home page with hero section
│   ├── services/       # Services listing page
│   ├── gallery/        # Image gallery with lightbox
│   └── contact/        # Contact form and info
└── shared/
    └── widgets/        # Reusable widgets
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Chrome browser (for web development)

### Installation

1. **Clone the repository** (or navigate to the project directory)

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run -d chrome
   ```

   Or for web with specific port:
   ```bash
   flutter run -d chrome --web-port=8080
   ```

### Development

- **Hot Reload**: Press `r` in the terminal or click the hot reload button
- **Hot Restart**: Press `R` in the terminal
- **Open DevTools**: Press `d` in the terminal

## Building for Production

### Build Web App

```bash
flutter build web
```

The built files will be in the `build/web/` directory.

### Optimize Build (Recommended)

For better performance, use the release build:

```bash
flutter build web --release
```

### Build with Base Href (for subdirectory deployment)

```bash
flutter build web --base-href="/your-subdirectory/"
```

## Deployment

### Option 1: Firebase Hosting (Free)

1. **Install Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase:**
   ```bash
   firebase login
   ```

3. **Initialize Firebase in your project:**
   ```bash
   firebase init hosting
   ```
   - Select your Firebase project
   - Set `build/web` as your public directory
   - Configure as a single-page app: **Yes**
   - Set up automatic builds: **No** (or Yes if using GitHub Actions)

4. **Build and Deploy:**
   ```bash
   flutter build web --release
   firebase deploy --only hosting
   ```

5. **Your app will be live at:**
   `https://your-project-id.web.app`

### Option 2: Netlify (Free)

1. **Install Netlify CLI:**
   ```bash
   npm install -g netlify-cli
   ```

2. **Build the app:**
   ```bash
   flutter build web --release
   ```

3. **Deploy:**
   ```bash
   netlify deploy --prod --dir=build/web
   ```

   Or drag and drop the `build/web` folder to [Netlify Drop](https://app.netlify.com/drop)

4. **Your app will be live at:**
   `https://your-site-name.netlify.app`

### Option 3: GitHub Pages

1. **Build the app:**
   ```bash
   flutter build web --base-href="/your-repo-name/"
   ```

2. **Copy build/web contents to gh-pages branch:**
   ```bash
   git checkout -b gh-pages
   cp -r build/web/* .
   git add .
   git commit -m "Deploy to GitHub Pages"
   git push origin gh-pages
   ```

3. **Enable GitHub Pages in repository settings**

### Option 4: Vercel (Free)

1. **Install Vercel CLI:**
   ```bash
   npm install -g vercel
   ```

2. **Build and Deploy:**
   ```bash
   flutter build web --release
   cd build/web
   vercel --prod
   ```

## Configuration

### Update Business Information

Edit `lib/core/constants/app_constants.dart`:

```dart
static const String businessName = "Pooja's Makeover Fashion Artist";
static const String phoneNumber = "8838637951";
static const String whatsappNumber = "918838637951";
```

### Update Gallery Images

Edit `lib/features/gallery/presentation/gallery_page.dart`:

```dart
static final List<String> galleryImages = [
  'your-image-url-1',
  'your-image-url-2',
  // Add more image URLs
];
```

### Customize Theme

Edit `lib/core/theme/app_theme.dart` to change colors, fonts, and styling.

## Features Breakdown

### Home Page
- Hero section with bridal image
- Business name and tagline
- Primary and secondary CTAs
- Features highlight section
- Call-to-action section

### Services Page
- Makeup Services (HD, Glass Finish, Matte, Waterproof)
- Mehendi Services (Organic, Bridal, Arabic, African)
- Facial Services (Hydro, Fruit, Golden, Diamond)

### Gallery Page
- Responsive image grid
- Click to enlarge (lightbox)
- Lazy loading images
- Smooth navigation

### Contact Page
- Contact form (name, phone, message)
- Form validation
- WhatsApp integration
- Contact information display

## Performance Optimizations

- ✅ Const constructors wherever possible
- ✅ Lazy loading images with cached_network_image
- ✅ Riverpod for efficient state management
- ✅ No unnecessary rebuilds
- ✅ Optimized web build with tree shaking

## Browser Support

- Chrome (Recommended)
- Firefox
- Safari
- Edge

## Troubleshooting

### Images not loading
- Ensure image URLs are accessible (CORS enabled)
- Check network connectivity
- Verify image URLs in gallery_page.dart

### WhatsApp/Call buttons not working
- Ensure phone number format is correct (with country code for WhatsApp)
- Check if device/browser supports tel: and whatsapp: protocols

### Routing issues
- Clear browser cache
- Ensure base href is correctly set for deployment

## License

This project is private and proprietary.

## Contact

For questions or support, contact: 8838637951

---

**Built with ❤️ using Flutter**
