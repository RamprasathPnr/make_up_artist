# Deployment Guide

Quick reference guide for deploying the Flutter Web app.

## Quick Start

### 1. Build the App
```bash
flutter build web --release
```

### 2. Deploy Options

#### Firebase Hosting (Recommended - Free)
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Initialize (first time only)
firebase init hosting
# Select: build/web as public directory
# Configure as single-page app: Yes

# Deploy
firebase deploy --only hosting
```

#### Netlify (Free - Easiest)
```bash
# Option 1: Drag & Drop
# 1. Build: flutter build web --release
# 2. Go to: https://app.netlify.com/drop
# 3. Drag build/web folder

# Option 2: CLI
npm install -g netlify-cli
netlify deploy --prod --dir=build/web
```

#### Vercel (Free)
```bash
npm install -g vercel
cd build/web
vercel --prod
```

## Custom Domain Setup

### Firebase
1. Go to Firebase Console > Hosting
2. Click "Add custom domain"
3. Follow DNS configuration steps

### Netlify
1. Go to Site settings > Domain management
2. Add custom domain
3. Update DNS records as instructed

## Environment Variables

No environment variables needed for this app. All configuration is in:
- `lib/core/constants/app_constants.dart`

## Performance Tips

1. **Enable Compression**: Most hosting platforms do this automatically
2. **CDN**: Firebase/Netlify/Vercel provide CDN automatically
3. **Caching**: Configure cache headers in hosting settings
4. **Image Optimization**: Use optimized image URLs or CDN

## Troubleshooting

### 404 on Refresh
- Ensure single-page app configuration is enabled
- Check base-href in build command if using subdirectory

### Images Not Loading
- Check CORS settings on image server
- Use HTTPS URLs
- Verify image URLs are accessible

### Routing Issues
- Clear browser cache
- Verify base-href matches deployment path

