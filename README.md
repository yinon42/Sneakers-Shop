# Sneakers.Shop

Sneakers.Shop is a SwiftUI-based iOS application for browsing and purchasing sneakers. The app includes Firebase integration for authentication and order history, and allows users to manage their shopping cart with quantity support.

## Link to app demo video
https://drive.google.com/file/d/1PlZHPLRR8EcM7hA8g_EKkkIXEf7BUDAz/view?usp=sharing

## Link to full project zip file
https://drive.google.com/file/d/136XB2pmWtBYNYLoMCp5Cy8r5DbkIpGrC/view?usp=sharing

## Features

- Browse a wide selection of sneakers with images and details.
- Add sneakers to a cart with quantity tracking per product.
- View and manage cart contents.
- Checkout simulation that stores orders in Firestore.
- View order history with product details and timestamps.
- User authentication with Firebase (email & password).
- Persistent login and logout support.

## Technologies Used

- SwiftUI: Modern declarative UI framework for iOS.
- Firebase Firestore: Realtime NoSQL database for storing user data and orders.
- Firebase Authentication: Simple authentication via email and password.
- Firebase Storage (planned): For uploading sneaker images, if needed.

## Screenshots

![image](https://github.com/user-attachments/assets/602ab10d-b21a-41bf-9b1d-8dfcf675775a)
![image](https://github.com/user-attachments/assets/71d063ee-a82e-4944-8f8f-8c7fb8f3ad95)

## Installation

1. Clone the repository.
2. Install dependencies if needed (e.g., Firebase via Swift Package Manager).
3. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
4. Add an iOS app and download `GoogleService-Info.plist` to the root directory.
5. Enable Firebase Authentication (email/password).
6. Set Firestore database rules appropriately.
7. Run the app via Xcode (iOS 15+ recommended).

## Firestore Collections

- `orders` – stores user order documents with fields like:
  - `userId` (String)
  - `timestamp` (Timestamp)
  - `items` (Array of product objects)
  - `totalPrice` (Double)

## Planned Features

- Apple Pay integration for real purchases.
- User profile with editable info.
- Admin panel for managing product inventory.

## Notes

- Make sure to set up Firestore indexes if needed (Firebase will prompt via error link).
- Images are stored locally via Asset Catalog (not Firebase Storage yet).
- The cart indicator counts total quantities, not unique items.

---

Happy shopping with Sneakers.Shop! 👟
