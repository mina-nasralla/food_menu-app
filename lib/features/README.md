# Features Folder

This folder contains all feature modules of the application.

Each feature follows the MVVM architecture pattern with Cubit for state management:

```
features/
  └── feature_name/
      ├── data/
      │   └── models/          # Data models (DTOs, entities)
      ├── domain/
      │   └── repos/           # Repository interfaces & implementations
      └── presentation/
          ├── views/           # UI screens
          ├── cubits/          # State management (uses repos)
          └── widgets/         # Reusable widgets
```

## Architecture Flow
- **Models** (data layer): Define data structures
- **Repositories** (domain layer): Handle business logic and data operations
- **Cubits** (presentation layer): Use repositories to manage state and expose it to views
- **Views** (presentation layer): Display UI and listen to cubit states

## Adding a New Feature

1. Create a new folder under `features/` with your feature name
2. Create the three main folders: `data/`, `domain/`, and `presentation/`
3. Add your models in `data/models/`
4. Add your repositories in `domain/repos/`
5. Add your cubits in `presentation/cubits/`
6. Add your views in `presentation/views/`
7. Add reusable widgets in `presentation/widgets/`
