# MyEvents - Flutter Event Management Application

A cross-platform Flutter application for browsing, creating, and managing events with authentication, offline support, and modern UI/UX.

## 📋 Table of Contents

- [Features Implemented](#features-implemented)
- [Tech Stack & Architecture](#tech-stack--architecture)
- [Project Structure](#project-structure)
- [Setup & Installation](#setup--installation)
- [Running the App](#running-the-app)
- [API Endpoints](#api-endpoints)
- [Testing Credentials](#testing-credentials)
- [Known Issues & Limitations](#known-issues--limitations)
- [AI Tools Used](#ai-tools-used)

---

## ✅ Features Implemented

### Authentication

- ✅ Login and Sign Up functionality
- ✅ Email + Password authentication
- ✅ Remember Me (session persistence)
- ✅ Secure token storage using `flutter_secure_storage`
- ✅ Form validation with visual feedback
- ✅ Logout functionality

### Events List (Home)

- ✅ Paginated event listing from mock API
- ✅ Event cards showing title, description, date/time, location, attendee count
- ✅ Pull-to-refresh functionality
- ✅ Infinite scroll with pagination
- ✅ Shimmer loading indicators
- ✅ Error handling with retry mechanism

### Event Details

- ✅ Full event information display
- ✅ Organizer contact information
- ✅ Event registration functionality
- ✅ Optimistic UI updates (attendee count)
- ✅ Success dialog on registration
- ✅ Error handling with rollback

### Create Event

- ✅ Basic event creation form
- ✅ Form validation (title, description, location)
- ✅ Image picker integration (gallery & camera)
- ✅ Date/time picker
- ✅ Organizer information fields
- ✅ Coordinate validation (latitude/longitude)
- ✅ Attendee limit setting

### Design & UX

- ✅ Responsive design using MediaQuery percentages (no fixed pixels)
- ✅ Consistent color palette and typography
- ✅ Custom fonts (Poppins for headings, Inter for body)
- ✅ Loading states and error handling throughout
- ✅ Clean, modern UI with Material Design principles

---

## 🛠 Tech Stack & Architecture

### State Management

**GetX** - Chosen for its simplicity and all-in-one approach:

- **Why GetX?**
  - Combines state management, routing, and dependency injection
  - Minimal boilerplate compared to Bloc/Riverpod
  - Reactive programming with `.obs` (easy learning curve)
  - Built-in navigation without context
  - Perfect for tight deadlines and rapid development

### Architecture Pattern

**Repository Pattern with Clean Architecture principles:**

```
lib/
├── core/               # Shared utilities, constants, widgets
│   ├── constants/      # Colors, text styles
│   └── widgets/        # Reusable UI components
├── data/              # Data layer
│   ├── models/        # Data models (User, Event)
│   ├── repositories/  # Data access abstraction
│   └── services/      # API services (Dio HTTP client)
├── presentation/      # UI layer
│   ├── screens/       # App screens
│   └── controllers/   # GetX controllers (state management)
└── main.dart          # App entry point
```

**Benefits:**

- Separation of concerns
- Easy to test and mock
- Single source of truth for data operations
- Can swap APIs without touching UI layer

### Packages Used

| Package                  | Version | Purpose                         |
| ------------------------ | ------- | ------------------------------- |
| `get`                    | ^4.6.6  | State management, routing, DI   |
| `flutter_secure_storage` | ^9.0.0  | Secure token storage            |
| `dio`                    | ^5.4.0  | HTTP client with interceptors   |
| `flutter_dotenv`         | ^5.1.0  | Environment variable management |
| `shimmer`                | ^3.0.0  | Skeleton loading indicators     |
| `image_picker`           | ^1.0.4  | Camera and gallery access       |
| `intl`                   | ^0.18.1 | Date formatting                 |

---

## 📁 Project Structure

```
my_events/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   └── app_text_styles.dart
│   │   └── widgets/
│   │       ├── event_card.dart
│   │       └── event_card_shimmer.dart
│   ├── data/
│   │   ├── models/
│   │   │   ├── user_model.dart
│   │   │   └── event_model.dart
│   │   ├── repositories/
│   │   │   ├── auth_repository.dart
│   │   │   └── events_repository.dart
│   │   └── services/
│   │       ├── api_service.dart
│   │       └── events_api_service.dart
│   ├── presentation/
│   │   ├── controllers/
│   │   │   ├── auth_controller.dart
│   │   │   └── events_controller.dart
│   │   └── screens/
│   │       ├── auth_screen.dart
│   │       ├── home_screen.dart
│   │       ├── event_detail_screen.dart
│   │       └── create_event_screen.dart
│   └── main.dart
├── assets/
│   └── fonts/
│       ├── Poppins-Regular.ttf
│       ├── Poppins-SemiBold.ttf
│       ├── Poppins-Bold.ttf
│       ├── Inter-Regular.ttf
│       └── Inter-Medium.ttf
├── .env
├── .env.example
├── pubspec.yaml
└── README.md
```

---

## 🚀 Setup & Installation

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for iOS)

### Installation Steps

1. **Clone the repository**

```bash
git clone <your-repo-url>
cd my_events
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Download fonts**

- Download Poppins and Inter from [Google Fonts](https://fonts.google.com)
- Place font files in `assets/fonts/` directory

4. **Setup environment variables**
   Create a `.env` file in the root directory:

```env
API_BASE_URL=https://reqres.in/api
EVENTS_API_URL=https://691f28b9bb52a1db22c0b383.mockapi.io
```

5. **Verify setup**

```bash
flutter doctor
```

---

## ▶️ Running the App

### Development Mode

```bash
# Run on connected device/emulator
flutter run

# Run with hot reload
flutter run --hot

# Run in release mode
flutter run --release
```

### Build APK

```bash
# Debug APK
flutter build apk

# Release APK
flutter build apk --release

# APK will be located at: build/app/outputs/flutter-apk/app-release.apk
```

### Build iOS (macOS only)

```bash
flutter build ios --release
```

---

## 🌐 API Endpoints

### Authentication API (ReqRes)

**Base URL:** `https://reqres.in/api`

| Endpoint    | Method | Description       |
| ----------- | ------ | ----------------- |
| `/login`    | POST   | User login        |
| `/register` | POST   | User registration |

### Events API (MockAPI)

**Base URL:** `https://691f28b9bb52a1db22c0b383.mockapi.io`

| Endpoint                     | Method | Description                  |
| ---------------------------- | ------ | ---------------------------- |
| `/events`                    | GET    | Fetch paginated events       |
| `/events?page={n}&limit={m}` | GET    | Fetch events with pagination |
| `/events/{id}`               | GET    | Fetch event details          |
| `/events`                    | POST   | Create new event             |
| `/events/{id}`               | PUT    | Update event                 |
| `/events/{id}`               | DELETE | Delete event                 |
| `/registrations`             | POST   | Register for event           |

**Event Schema:**

```json
{
  "id": "1",
  "title": "Tech Conference 2024",
  "description": "Annual technology conference",
  "scheduledAt": 1763683624,
  "location": "Karachi, Pakistan",
  "lat": 24.8607,
  "lng": 67.0011,
  "images": [],
  "organizerName": "John Doe",
  "organizerEmail": "john@example.com",
  "organizerPhone": "+92300123456",
  "attendeeLimit": 100,
  "attendeeCount": 45,
  "userId": "1",
  "createdAt": "2025-11-20T12:27:24.143Z"
}
```

**Registration Schema:**

```json
{
  "id": "1",
  "userId": "4",
  "isFav": false,
  "createdAt": "2025-11-20T21:41:47.716Z"
}
```

---

## 🔑 Testing Credentials

### ReqRes Test Accounts

Use any of these emails with **any password**:

```
george.bluth@reqres.in
janet.weaver@reqres.in
emma.wong@reqres.in
eve.holt@reqres.in
charles.morris@reqres.in
tracey.ramos@reqres.in
```

**Note:** ReqRes is a mock API that accepts any password for these accounts.

---

## ⚠️ Known Issues & Limitations

### Not Implemented

- ❌ Splash screen with auto-login
- ❌ Social login (Google/Facebook)
- ❌ Offline caching
- ❌ Deep linking
- ❌ Edit event functionality
- ❌ Delete event functionality
- ❌ Favorite/bookmark events
- ❌ Event search and filters
- ❌ Map integration for event location
- ❌ Password strength meter
- ❌ Async email validation
- ❌ Image upload to server (currently uses placeholder)
- ❌ Unit tests
- ❌ CI/CD pipeline

### Known Bugs

- `CachedNetworkImage` package causes app to hang during navigation - replaced with `Image.network`
- GetX controllers sometimes cause build phase issues - avoided by using StatefulWidget where needed
- Event images not uploaded to server - using placeholder URLs

### Design Decisions

- **No GetX controllers for simple screens:** Due to initialization timing issues, some screens (EventDetail, CreateEvent) use plain StatefulWidget instead of GetX controllers
- **Image upload:** Images are validated client-side but not uploaded to server (MockAPI limitation)
- **Responsive design:** All dimensions use MediaQuery percentages as required

---

## 🤖 AI Tools Used

### Claude AI (Anthropic)

**Purpose:** Code generation, architecture planning, debugging assistance

**Usage:**

- Generated boilerplate code for models, repositories, and screens
- Assisted with Flutter/Dart best practices
- Helped debug GetX controller initialization issues
- Provided architecture recommendations
- Generated form validation logic
- Created responsive UI layouts

**Intellectual Honesty:**

- All code was reviewed and understood before implementation
- Architecture decisions were made collaboratively
- Custom modifications made to fit project requirements
- Debugging and problem-solving done interactively

---

## 📱 App Flow

```
Launch App
    ↓
Auth Screen (Login/Signup)
    ↓
Home Screen (Events List)
    ├── Pull to refresh
    ├── Infinite scroll
    ├── Click event → Event Detail
    │                     ├── View details
    │                     └── Register for event
    └── FAB → Create Event
              ├── Fill form
              ├── Pick images
              └── Submit
```

---

## 🎨 Design System

### Color Palette

- **Primary:** `#6366F1` (Indigo)
- **Secondary:** `#EC4899` (Pink)
- **Background:** `#F9FAFB` (Light Gray)
- **Surface:** `#FFFFFF` (White)
- **Text Primary:** `#111827` (Dark Gray)
- **Text Secondary:** `#6B7280` (Gray)
- **Error:** `#EF4444` (Red)
- **Success:** `#10B981` (Green)

### Typography

- **Headings:** Poppins (Bold/SemiBold)
- **Body Text:** Inter (Regular/Medium)
- **Sizes:** H1(24px), H2(20px), H3(16px), Body(14px), Caption(12px)

---

## 📝 Development Notes

### State Management Pattern

- **GetX Controllers:** Used for complex state (AuthController, EventsController)
- **StatefulWidget:** Used for simple screens with local state (EventDetail, CreateEvent)
- **Reason:** GetX controller initialization during build phase caused navigation issues

### Error Handling Strategy

- Repository layer catches and throws exceptions
- UI layer displays errors using ScaffoldMessenger
- Optimistic updates with rollback on failure
- Loading states for all async operations

### Responsive Design

- All dimensions use `MediaQuery.of(context).size` percentages
- Example: `height * 0.05`, `width * 0.04`
- No fixed pixel values
- Adapts to different screen sizes

---

## 🔄 Future Enhancements

- [ ] Implement offline caching with SQLite/Hive
- [ ] Add unit and widget tests
- [ ] Implement CI/CD with GitHub Actions
- [ ] Add social authentication
- [ ] Implement deep linking
- [ ] Add event search and filters
- [ ] Integrate Google Maps for location
- [ ] Add event categories
- [ ] Implement push notifications
- [ ] Add user profile management
- [ ] Implement event favorites/bookmarks

---

## 📄 License

This project is part of a technical assessment for MySkool.

---

## 👤 Submission Information

**Developer:** Muhammad Hamza Asad
**Email:** m.hamza.asad.22@gmail.com  
**Date:** November 21, 2025  
**Position:** Fullstack Engineer

---

## 🙏 Acknowledgments

- ReqRes API for authentication endpoints
- MockAPI for event management endpoints
- Flutter community for excellent packages
- Claude AI for development assistance
