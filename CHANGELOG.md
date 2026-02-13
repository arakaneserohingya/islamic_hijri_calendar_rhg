## 1.0.0

**Major Release** - Complete redesign with multi-language support and modern UI

### ✨ New Features

- **Multi-Language Support**: Full localization for Rohingya, English, and Arabic
  - Localized month names and weekday names
  - Localized numerals (Hanifi, Arabic, Western)
  - Localized UI strings ("Calendar Events", "No events this month")
  - Dynamic text direction (LTR for English, RTL for Arabic/Rohingya)

- **Islamic Events Display**: Automatic detection and display of important Islamic dates
  - Beautiful event cards with date boxes
  - Localized event names in all supported languages
  - Events for Ramadan, Eid al-Fitr, Eid al-Adha, Mawlid, and more

- **Modern UI Redesign**: Professional, cohesive interface
  - Unified events section with integrated header
  - Refined typography and spacing
  - Subtle shadows and borders for depth
  - Improved visual hierarchy

- **Responsive Design**: Adapts to different screen sizes
  - Column layout for mobile (< 600px)
  - Row layout for tablets and larger screens (≥ 600px)

### 🔧 Enhancements

- Improved calendar grid styling with rounded corners
- Better color theming and customization
- Enhanced font support with Google Fonts integration
- Smoother month navigation

### 💥 Breaking Changes

- Added required `locale` parameter (values: 'en', 'ar', 'rhg')
- Widget layout changed to accommodate events display
- Some color parameters may render differently with new UI

### 🐛 Bug Fixes

- Fixed settings dialog closing issue
- Improved state management for language switching
- Better handling of previous/next month dates

---

## 0.0.4

* Users can set only the English calendar or show it with the Hijri calendar.

## 0.0.3

* Enhanced code documentation with DartDoc comments.

## 0.0.2

* Update README.md.

## 0.0.1

* Version 1.0.0 introduces dual-language day names, Hijri month display, custom font support (including Google Fonts), light/dark mode options, color customization, and intuitive calendar navigation.