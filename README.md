<div align="center">
  <img src="assets/images/logo.svg" alt="Space App Logo" width="200" />

  # Space App

  *A beautiful, modern, and feature-rich Flutter application for social feeds and posts.*

  <p align="center">
    <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
    <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
    <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase" />
    <img src="https://img.shields.io/badge/BLoC-000000?style=for-the-badge&logo=flutter&logoColor=white" alt="BLoC" />
  </p>
</div>

---

## 📸 Screenshots

<!-- 
TODO: Add your screenshots here later 

<div align="center">
  <img src="path/to/screenshot1.png" alt="Screenshot 1" width="250"/>
  &nbsp;
  <img src="path/to/screenshot2.png" alt="Screenshot 2" width="250"/>
  &nbsp;
  <img src="path/to/screenshot3.png" alt="Screenshot 3" width="250"/>
</div>
-->

## 🚀 Features

- **Social Feed**: Scroll through posts seamlessly in a dynamic feed.
- **User Authentication**: Secure login and sign-up powered by Firebase Auth.
- **Profile Interface**: View your profile, bookmarks, and managed posts intuitively.
- **State Management**: Robust architecture utilizing the BLoC pattern.
- **Cloud Database**: Real-time cloud synchronization and storage via Cloud Firestore and Supabase.
- **Polished UI/UX**: Smooth loading states using `skeletonizer` and customized standard components.

## 🛠️ Tech Stack & Libraries

- **Framework**: [Flutter](https://flutter.dev/) SDK `^3.10.8`
- **State Management**: `flutter_bloc`
- **Backend & Database**: `firebase_core`, `firebase_auth`, `cloud_firestore`, `supabase_flutter`
- **UI Components**: `cupertino_icons`, `skeletonizer`, `cached_network_image`, `flutter_svg`
- **Local Storage**: `shared_preferences`
- **Environment config**: `flutter_dotenv`

## 👨‍💻 About the Author

<div align="center">
  <img src="assets/images/me.jpg" alt="Author Profile Picture" width="150" style="border-radius: 50%;" />  
  **Built with ❤️ by CosmosByME.**
</div>

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.8 or higher recommended)
- [Dart SDK](https://dart.dev/get-dart)
- An emulator or physical device for testing
- Set up Firebase and Supabase instances and update configuration files and `.env` properly.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd space_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get

(IMPORTANT: If you have added Firebase Storage to your Firebase project, then skip step 4. You can configure your Firebase storage service inside the file ```\lib\domain\services\supabase_storage_service.dart```)

4. Create ```.env``` file for your API keys:
   ```bash
   SUPABASE_URL=YOUR_SUPABASE_URL
   SUPABASE_SERVICE_KEY=YOUR_SUPABASE_SECRET_KEY
   ```
5. Configure your Firebase project:
   ```bash
   flutterfire configure
   ```
6. Run the app:
   ```bash
   flutter run
   ```

