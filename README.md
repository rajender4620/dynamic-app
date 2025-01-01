# Hni Customers App

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

New hni_customers_app app

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Hni Customers App works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:hni_customers_app/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli

====================================================================================================

# Project Name

A Flutter app with mobile (APK) and web versions.

## Features

- Dynamic Forms
- Local Storage for Web and Mobile
- Responsive UI

## Running the Project

### Mobile (APK)

1. Download the APK from the `releases` section.
2. Install it on your Android device.
3. Open the app and test.

### Web

1. Open the `build/web/index.html` file in a browser.
2. Alternatively, access the hosted version at [Live Demo](https://example.com).

## Development Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/your-repository-name.git
   ```

=============================

Title:
Dynamic Form Application

Overview:
The Dynamic Form Application is a Flutter-based project that provides a seamless experience across mobile and web platforms. It allows users to dynamically create, manage, and save form data. The app features a responsive design, local data storage, and geolocation capabilities, making it versatile for various use cases.

Features:
Cross-Platform Support:

Available as a mobile APK for Android devices.
Fully functional web version accessible via browsers.
Dynamic Forms:

Users can interact with dynamically generated forms.
Supports text input, radio buttons, dropdowns, and nested forms.
Local Data Storage:

Saves form responses locally for offline access.
Uses SharedPreferences for lightweight storage.
Geolocation and Camera Access:

Fetches the user’s location (mobile and web).
Allows image selection via camera or file picker (platform-specific).
Responsive Design:

Adapts to various screen sizes and devices.
User-Friendly Interface:

Intuitive navigation and minimalistic UI.
Deliverables:

1. APK for Mobile Devices:
   Description:
   An Android app that users can install to experience the application on their devices.
2. Web Version:
   Description:
   A browser-accessible web app version with identical functionality to the mobile app. It provides users with the flexibility to access the app on desktops or tablets.
3. GitHub Repository:
   Description:
   A well-documented GitHub repository containing:
   Source code with Flutter project structure.
   Dependencies (pubspec.yaml) for easy setup.
   A detailed README.md file explaining how to:
   Run the app locally.
   Build the APK.
   Deploy the web version.
   How to Use the App
   Mobile:

Download and install the APK on your Android device.
Open the app and interact with forms.
Save and retrieve responses locally.
Web:

Access the app via a supported browser (Chrome, Firefox, etc.).
Perform the same tasks as in the mobile app.
Technologies Used:
Flutter: A cross-platform framework for building mobile and web apps.
Dart: Programming language used with Flutter.
SharedPreferences: For local data storage on mobile and web.
Geolocator: For fetching geolocation data.
