# **MyBuddyDemo**

This repository contains the implementation of the eBuddy iOS technical test. The app demonstrates Firebase integration, SwiftUI components, and MVVM architecture.

## **Features**
1. **Firebase Integration**
   - Firestore, Storage, and Auth setup.
   - Mock development and staging environments.
2. **Data Handling**
   - User data fetched from Firestore, filtered by gender, rating, activity, and service pricing.
   - Profile image upload and background upload task support.
3. **UI and State Management**
   - Figma design converted to SwiftUI.
   - Dark mode support.
   - Global state management using `@EnvironmentObject`.
4. **Firestore Queries**
   - Compound queries with multiple sorting and filtering criteria.

## **Getting Started**
### **Prerequisites**
- Xcode 15+
- Swift 5.7+
- Firebase account with a configured project.

### **Setup**
1. Clone the repository:
   ```bash
   git clone https://github.com/chrisFerdian/MyBuddyDemo.git
   ```
2. Install Firebase:
   - Add your `GoogleService-Info.plist` file to the project.
   - Configure Firestore and Firebase Storage.

3. Run the app:
   ```bash
   open eBuddyTest.xcodeproj
   ```

## **App Workflow**
1. **Fetch and Display Users**:
   - Users are displayed with their details (email, phone, gender).
   - Apply sorting and filtering (e.g., recently active, highest rating, female users).
2. **Upload Profile Image**:
   - Upload an image to Firebase Storage.
   - Display the uploaded image in the UI.

## **Code Structure**
- **Model**: Defines the `UserInfo` data structure.
- **ViewModel**: Handles data fetching, state management, and interaction logic.
- **View**: SwiftUI components for user interface and interaction.

## **To-Do**
- Improve error handling for Firebase operations.
- Add unit tests for ViewModel and Firebase repository.
---
