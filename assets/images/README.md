# Assets Images Directory

Place your image files here to use with the DisplayImage feature.

## Required Image
- Add an image named `sample_image.jpg` (or update the path in `displayimage_page.dart`)
- Supported formats: JPG, PNG, GIF, WebP

## Example Images You Can Add
- sample_image.jpg
- sample_image.png
- logo.png
- background.jpg

## Usage
After adding images to this directory, run:
```bash
flutter pub get
```

Then the images will be available in your Flutter app using:
```dart
Image.asset('assets/images/your_image_name.jpg')
```
