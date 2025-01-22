# Very Good Coffee

## Important

This repository contains one or more submodules. After cloning this repository, run:

```shell
flutter pub get
```

## Project Architecture

The image below represents the application architecture designed for:

- Scalability (Multiple teams working on different features in a decoupled way)
- Code reusability across multiple projects

![Architecture Diagram](https://github.com/Bwolfs2/very_good_coffee/blob/main/assets/arquitecture.png)

---

### Blend

The Blend package is our Design System, where we will place all widgets that can be reused in more than one screen or module.

---

### Core

The Core package is responsible for implementing essential functions such as Crashlytics, analytics, HTTP client, etc.

---

### Root App

The Flutter root app is responsible for building the entire application, assembling all components into a single artifact.

---

### Local Data

Since it hasn't been clearly defined how we will manage local data, the local_data_abstractions package was created to provide abstractions used in the repositories. Additionally, the drift_local_data_impl package offers an implementation using Drift. This approach allows for future flexibility, enabling the creation of implementations using other packages such as Hive, SharedPreferences, or any other solution. To achieve this, one would only need to create a new package that implements the interface defined in local_data_abstractions and adjust the dependency injection accordingly. This strategy facilitates future maintenance and evolution of the app.

---

## Structure

We are using a Clean Architecture approach, separating concerns into three different packages:

```
├── main.dart
└── src
    ├── data
    │   ├── repositories
    │   └── mappers (for complex JSON parsing)
    ├── domain
    │   ├── models/entities
    │   ├── failures
    │   ├── use_cases (for future growth)
    │   └── repositories (abstract)
    └── view
        └── pages
            ├── page
            └── bloc
```

---

### Domain

The innermost layer of the system, containing **ONLY** business rules. This layer should not depend on external packages. In the domain layer, you'll find:

- **Use Cases**: System functionalities that implement business rules (e.g., Filter List, Sort List).
- **Models/Entities**: Objects representing business rules (e.g., MessageEntity, CreditCardEntity, EventEntity). Generally, entities will consist of backend requests/responses.

### Data

The layer responsible for connecting to data sources (API, SQLite, Local storage, etc.). The data layer mainly consists of:

- **Mappers**: Classes that convert raw responses (XML, JSON, Maps) into Dart models/entities (with fromMap, fromJson methods).
- **Data Sources (Implementation)**: Implementations of the infrastructure's Data Source contract, which can be any source of data (REST API, SQLite, Local storage, etc.).

## Presentation

The presentation layer is responsible for Flutter-specific code, which includes:

- **Components/Widgets**
- **Pages/Views**
- **Blocs/Cubits**

> The presentation layer is the only layer that can contain Flutter-specific code (classes derived from the Flutter package).

---

## Tests

- [x] Unit Tests
- [ ] Widget Tests (to be done later)
- [ ] Integration Tests (to be done later)

If you are not familiar with unit testing in Flutter, these resources will help you:

- [Official Documentation](https://docs.flutter.dev/cookbook/testing/unit/introduction)
- [Creating Mocks in Dart using Mocktail](https://pub.dev/packages/mocktail)
- [Flutter Testing Guide for Beginners](https://www.youtube.com/watch?v=hUAUAkIZmX0&list=PLB6lc7nQ1n4jN2u4rMmb-3tdJ_cQBs-YS)
- [Flutter Explained - Unit Testing](https://www.youtube.com/watch?v=C1kzJH8SiuE&t=701s)
