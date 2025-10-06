# Ober task2

A Flutter test project

## Getting Started

This project demonstrates:
- Selecting source and destination.
- Measuring Distance and Fare between them.
- Get Source and Destination addresses.
- Search address and getting suggestion.
- Get selected address location.
- Generate drivers around user location.


The project leverages **Bloc** for state management and **Clean Architecture** .

---

## Features and Packages

### measuring distance and address
- This feature uses Flutter with GetX for state management, flutter_map and latlong2 for map rendering and geographic calculations, and geolocator for obtaining the device’s current location.
- Distance between the selected points is calculated using latlong2 utilities, while **OSRM (Open Source Routing Machine) API with user-agent : flutter_map_app** is used to fetch the route. Reverse geocoding to get human-readable addresses is handled via HTTP requests to appropriate services. This combination ensures accurate distance measurement, route drawing, and address retrieval for pickup and drop-off points.

### State Management
- Managed with `Bloc`, enabling reactive and predictable state updates .

### flutter map
- showing map to user , showing marker layer and TileLayer `flutter_map`.

### lat long
- used for geographic calculations and handling latitude/longitude points. `latlong2`.

### geolocator
- package for working with the device’s location and getting current location `geolocator`.

### dartz
- Functional programming package that helps handle success and failure cases more elegantly using the Either type. It’s used to return results from asynchronous operations (like API calls) in a predictable, type-safe way — for example, Either<Failure, RoutePathModel> ensures clear separation of error handling and successful responses.


### get_it
- A service locator package that simplifies dependency injection. It allows registering and accessing classes (e.g., repositories, use cases, or BLoCs) globally without passing instances manually through constructors. This promotes cleaner architecture and easier testing..


### Dio
- A powerful HTTP client for Dart/Flutter used for making API requests, handling headers, timeouts, interceptors, and errors efficiently `Dio`.
---


## Project Structure

```
lib/
├── main.dart                  # Entry point
├── core/                      # Constants, utilities, and shared widgets
├── feature/
│   └── map_feature/
│       ├── data/              # JSON form data and models
│       ├── domain/            # Entities and repository interfaces
│       └── presentation/
│           ├── manager/       # Bloc and state management
│           └── pages/         # UI screens

```

---

## Installation

Clone the repository:
```bash
git clone https://github.com/rezvanmj/ober_task2.git
cd task2
```
x
Install dependencies:
```bash
flutter pub get
```

Run the project:
```bash
flutter run
```

---
