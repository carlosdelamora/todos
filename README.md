 The app helps users create a to-do list. Its home screen is a placeholder that allows navigation to the list screen. Once on the list screen, users can add, delete, and edit tasks. It also allows toggling between hiding completed tasks or active ones. Additionally, users can drag cells in the list to mark tasks as complete or rearrange their order.



https://github.com/user-attachments/assets/62856444-94b6-473e-8f29-2844a0d45e9e
https://github.com/user-attachments/assets/5799e184-9e4e-4fdd-b087-4aa2ff1ac9c0



 # Technical Considerations

 - Written using Xcode 16 and Swift 5.10.
 - The app has a minimum deployment target of iOS 17.
 - It is written 100% in SwiftUI.
 - The app runs on both iPhone and iPad. On iPhone, orientation is locked to portrait, while on iPad, both landscape and portrait orientations are supported.
 - Uses Swift Package Manager (SPM) to modularize the networking layer and import a third-party library for dependency injection.
 - Contains unit tests for some of the ViewModels.
 - Includes basic UI tests.
 - A custom font is imported to closely match the design specifications.

 # Architectural Decisions

 We use the **MVVM** (Model-View-ViewModel) pattern to manage the separation between the view layer and the model. The view models have their dependencies injected, with all dependencies conforming to protocols, allowing for unit testing of the view models.

 Additionally, the networking layer is its own module, which is imported into the app. Given more time, we would have applied the same modularization to UI components.

# Design Liberties

We took the liberty of deviating from the design by removing the "Add Task" button from the scrollable area and pinning it to the bottom of the screen, so it is always accessible for adding tasks.
