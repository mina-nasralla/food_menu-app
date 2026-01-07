# Deploying Food Menu App to Vercel

This guide explains how to deploy your Flutter food menu app to Vercel.

## Prerequisites

- Flutter SDK installed and configured
- Vercel account (free tier works fine)
- Git repository (GitHub, GitLab, or Bitbucket)

## Deployment Methods

### Method 1: Deploy via Vercel CLI (Recommended)

1. **Install Vercel CLI**
   ```bash
   npm install -g vercel
   ```

2. **Login to Vercel**
   ```bash
   vercel login
   ```

3. **Build the Flutter web app**
   ```bash
   flutter clean
   flutter pub get
   flutter build web --release
   ```

4. **Deploy to Vercel**
   ```bash
   vercel
   ```
   
   Follow the prompts:
   - Set up and deploy? **Y**
   - Which scope? Select your account
   - Link to existing project? **N**
   - Project name? **food-menu-app** (or your preferred name)
   - In which directory is your code located? **.**
   - Want to override settings? **N**

5. **Deploy to production**
   ```bash
   vercel --prod
   ```

### Method 2: Deploy via GitHub Integration

1. **Push your code to GitHub**
   ```bash
   git add .
   git commit -m "Prepare for Vercel deployment"
   git push origin main
   ```

2. **Import project in Vercel**
   - Go to [vercel.com](https://vercel.com)
   - Click "Add New Project"
   - Import your GitHub repository
   - Vercel will automatically detect the `vercel.json` configuration

3. **Configure build settings** (if needed)
   - Framework Preset: **Other**
   - Build Command: `flutter build web --release --base-href=/`
   - Output Directory: `build/web`
   - Install Command: (leave default or use the one from vercel.json)

4. **Deploy**
   - Click "Deploy"
   - Wait for the build to complete

## Environment Variables (if using Supabase)

If your app uses Supabase or other services requiring API keys:

1. Go to your Vercel project settings
2. Navigate to "Environment Variables"
3. Add your variables:
   - `SUPABASE_URL`: Your Supabase project URL
   - `SUPABASE_ANON_KEY`: Your Supabase anonymous key

**Note**: For Flutter web, environment variables need to be configured at build time, not runtime. You may need to use `--dart-define` flags during build.

## Post-Deployment

### Custom Domain (Optional)

1. Go to your project settings in Vercel
2. Navigate to "Domains"
3. Add your custom domain
4. Update DNS records as instructed

### Testing Your Deployment

After deployment, test the following:

- ✅ All routes work (menu, cart, checkout, item details)
- ✅ Theme switching (light/dark mode)
- ✅ Language switching (Arabic/English)
- ✅ Cart functionality
- ✅ Responsive design on mobile/tablet/desktop
- ✅ Map picker (note: may have limited functionality on web)

## Known Limitations on Web

1. **Map Picker**: Geolocation and geocoding have limited browser support. The app will:
   - Request browser location permission
   - Fall back to coordinate-based addresses if geocoding fails
   - Allow manual location selection by tapping the map

2. **Performance**: First load may be slower than native apps due to Flutter web bundle size

## Troubleshooting

### Build Fails on Vercel

- Check that Flutter is properly installed in the build environment
- Verify `vercel.json` configuration is correct
- Check build logs for specific errors

### Routes Don't Work (404 errors)

- Ensure `vercel.json` has the proper rewrite rules
- Verify base href is set to `/` in `web/index.html`

### Assets Not Loading

- Check that asset paths are correct in `pubspec.yaml`
- Verify assets are included in the build output
- Check browser console for CORS errors

### App Loads Slowly

- This is normal for Flutter web on first load
- Consider implementing a custom loading screen
- Enable caching headers (already configured in `vercel.json`)

## Updating Your Deployment

### Via CLI
```bash
flutter build web --release
vercel --prod
```

### Via GitHub
Simply push your changes to the main branch:
```bash
git add .
git commit -m "Update app"
git push origin main
```

Vercel will automatically rebuild and deploy.

## Support

For issues specific to:
- **Flutter Web**: Check [Flutter web documentation](https://docs.flutter.dev/platform-integration/web)
- **Vercel**: Check [Vercel documentation](https://vercel.com/docs)
- **This App**: Check the project repository issues

## Performance Optimization Tips

1. **Enable caching**: Already configured in `vercel.json`
2. **Optimize images**: Use WebP format where possible
3. **Lazy load routes**: Consider implementing lazy loading for better initial load time
4. **Use CDN**: Vercel automatically uses their global CDN
5. **Monitor performance**: Use Vercel Analytics to track performance metrics
