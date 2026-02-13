# Contributing to Islamic Hijri Calendar (Rohingya Edition)

Thank you for your interest in contributing to the Islamic Hijri Calendar package! We welcome contributions from the community.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.22.0)
- Dart SDK (>=3.4.3)
- Git
- A code editor (VS Code, Android Studio, or IntelliJ IDEA recommended)

### Setting Up Development Environment

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/islamic_hijri_calendar_rhg.git
   cd islamic_hijri_calendar_rhg
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   cd example
   flutter pub get
   cd ..
   ```

4. **Run the example app**
   ```bash
   cd example
   flutter run
   ```

## 📝 How to Contribute

### Reporting Bugs

Before creating a bug report, please check existing issues to avoid duplicates.

**When reporting a bug, include:**
- A clear, descriptive title
- Steps to reproduce the issue
- Expected behavior vs actual behavior
- Screenshots (if applicable)
- Flutter version (`flutter --version`)
- Device/platform information
- Code sample demonstrating the issue

### Suggesting Features

We love feature suggestions! Please:
- Check if the feature has already been suggested
- Provide a clear use case
- Explain how it benefits users
- Include mockups or examples if applicable

### Submitting Pull Requests

1. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes**
   - Follow the code style guidelines below
   - Add tests if applicable
   - Update documentation as needed

3. **Test your changes**
   ```bash
   # Run tests
   flutter test
   
   # Run the example app
   cd example
   flutter run
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add new feature" # or "fix: resolve bug"
   ```

   **Commit message format:**
   - `feat:` for new features
   - `fix:` for bug fixes
   - `docs:` for documentation changes
   - `style:` for formatting changes
   - `refactor:` for code refactoring
   - `test:` for adding tests
   - `chore:` for maintenance tasks

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository on GitHub
   - Click "New Pull Request"
   - Select your fork and branch
   - Fill in the PR template with details

## 💻 Code Style Guidelines

### Dart Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` to check for issues
- Format code with `dart format .`
- Use meaningful variable and function names
- Add DartDoc comments for public APIs

**Example:**
```dart
/// Displays an Islamic Hijri calendar with customizable styling.
///
/// The [locale] parameter determines the language for month names,
/// weekdays, and numerals. Supported values are 'en', 'ar', and 'rhg'.
///
/// Example:
/// ```dart
/// IslamicHijriCalendar(
///   locale: 'en',
///   isHijriView: true,
///   highlightBorder: Colors.blue,
/// )
/// ```
class IslamicHijriCalendar extends StatefulWidget {
  // ...
}
```

### File Organization

- Keep files focused and single-purpose
- Place widgets in `lib/src/`
- Export public APIs through `lib/islamic_hijri_calendar_rhg.dart`
- Keep example code in `example/lib/`

### Testing

- Write tests for new features
- Ensure existing tests pass
- Aim for good test coverage
- Place tests in `test/` directory

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart
```

## 🌍 Localization Contributions

We especially welcome contributions for:
- Improving Rohingya translations
- Adding new Islamic events
- Enhancing RTL support
- Fixing language-specific issues

### Adding a New Language

1. Add month names in `lib/src/hijri_month_week_names.dart`
2. Add weekday names in the same file
3. Add numerals conversion
4. Update UI strings
5. Test thoroughly with the new language

## 📚 Documentation

- Update README.md for new features
- Add entries to CHANGELOG.md
- Update API.md for API changes
- Include code examples
- Add screenshots for UI changes

## ✅ Pull Request Checklist

Before submitting your PR, ensure:

- [ ] Code follows the style guidelines
- [ ] All tests pass (`flutter test`)
- [ ] No analyzer warnings (`flutter analyze`)
- [ ] Code is formatted (`dart format .`)
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated (for significant changes)
- [ ] Example app demonstrates the changes (if applicable)
- [ ] Commit messages follow the convention
- [ ] PR description clearly explains the changes

## 🤝 Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md).

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 💬 Questions?

If you have questions, feel free to:
- Open an issue for discussion
- Contact the maintainers
- Check existing documentation

---

Thank you for contributing to the Islamic Hijri Calendar package! 🎉
