# Marvel Flutter App

This is a Flutter project that implements a master-detail pattern using the Marvel API. The app allows users to explore Marvel characters and view specific details about each one.

## Technologies and Libraries

- **Flutter**: Cross-platform mobile application development framework.
- **Provider**: ^6.0.1 - For state management.
- **HTTP**: ^1.2.1 - To make HTTP requests.
- **Dio**: ^5.0.0 - Another HTTP request library with more features.
- **Crypto**: ^3.0.1 - For cryptographic operations needed for authentication with the Marvel API.
- **Flutter Dotenv**: ^5.0.2 - To handle environment variables.

## Features

- **Character List**: Displays a list of Marvel characters using the API.
- **Character Detail**: Shows a detailed view with more information when a character is selected.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ManuGMoya/marvel_flutter.git
    ```
2. Navigate to the project directory:
    ```bash
    cd marvel_flutter
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Create a `.env` file in the root of the project with the following variables (you can get your keys from the [Marvel Developer Portal](https://developer.marvel.com/)):
    ```env
    MARVEL_PUBLIC_KEY=your_public_key
    MARVEL_PRIVATE_KEY=your_private_key
    ```

## Usage

Run the application on an emulator or physical device:
```bash
flutter run
```

## Project Structure
- **lib/** Contains the application's source code.
- **models/** Data models used in the application.
- **providers/** Providers for state management.
- **screens/** Application screens.
- **services/** Services to interact with the Marvel API.
- **widgets/** Reusable UI components.
- **main.dart** Entry point of the application.
- 
## Contributions
Contributions are welcome. Please open an issue or submit a pull request for any improvements or corrections.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Links
- **Marvel API**: https://developer.marvel.com/
- **GitHub Repository**:

