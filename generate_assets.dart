import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  print('Generating Play Store assets...');

  // 1. Load the source logo
  final File logoFile = File('assets/branding/Leveluplogo.png');
  if (!logoFile.existsSync()) {
    print('Error: assets/branding/Leveluplogo.png not found!');
    return;
  }

  final img.Image? logo = img.decodeImage(logoFile.readAsBytesSync());
  if (logo == null) {
    print('Error: Could not decode logo image!');
    return;
  }

  // 2. Generate 512x512 App Icon
  // We'll resize the logo to fit nicely within 512x512. 
  // Play Store icons are usually full bleed or have a background.
  // We'll make a white background 512x512 and center the logo.
  final img.Image icon512 = img.Image(width: 512, height: 512);
  // Fill with white (or transparent if preferred, but Play Store often prefers opaque)
  // Google Play requires 32-bit PNG. Alpha is allowed but it's often better to have a background.
  // Let's use white background for safety/cleanliness, or keep transparency if the logo is shaped.
  // If the logo is already a square icon, we just resize.
  // Let's assume we want to preserve transparency if it exists, but resize to 512x512.
  
  // Strategy: Resize logo to fit 512x512 while maintaining aspect ratio.
  final img.Image resizedLogo512 = img.copyResize(logo, width: 512, height: 512, interpolation: img.Interpolation.cubic);
  
  // Save 512x512
  File('play_store_icon_512.png').writeAsBytesSync(img.encodePng(resizedLogo512));
  print('Generated play_store_icon_512.png');

  // 3. Generate 1024x500 Feature Graphic
  // This MUST be 1024x500. We'll create a white background and center the logo.
  final img.Image featureGraphic = img.Image(width: 1024, height: 500);
  // Fill with white
  img.fill(featureGraphic, color: img.ColorRgba8(255, 255, 255, 255));
  
  // Resize logo to fit within the height (e.g., 300px height) to look good
  final img.Image logoForBanner = img.copyResize(logo, height: 300, interpolation: img.Interpolation.cubic);
  
  // Center it
  final int centerX = (1024 - logoForBanner.width) ~/ 2;
  final int centerY = (500 - logoForBanner.height) ~/ 2;
  
  img.compositeImage(featureGraphic, logoForBanner, dstX: centerX, dstY: centerY);
  
  File('feature_graphic_1024x500.png').writeAsBytesSync(img.encodePng(featureGraphic));
  print('Generated feature_graphic_1024x500.png');
}
