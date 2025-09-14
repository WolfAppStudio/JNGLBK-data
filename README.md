# JNGLBK Educational Content API

A comprehensive educational content API providing multilingual learning materials for children, including alphabets, numbers, colors, animals, and more.

## 🌟 Features

- **Multilingual Support**: English, Hindi, and Gujarati
- **Rich Media**: Images and audio for each item
- **Accessibility**: Alt-text and screen reader support
- **Categorized Content**: Well-organized learning categories
- **Kid-Friendly**: Designed specifically for children's education

## 📁 Project Structure

```
api/
├── data/                    # JSON data files
│   ├── alphabets.json      # A-Z alphabet learning
│   ├── numbers.json        # 1-9 number learning
│   ├── colors.json         # Color recognition
│   ├── animals.json        # Animal identification
│   ├── birds.json          # Bird species
│   ├── vehicles.json       # Transportation
│   ├── shapes.json         # Geometric shapes
│   ├── body-parts.json     # Human body parts
│   ├── occupations.json    # Professional occupations
│   └── index.json          # Master index/configuration
├── assets/
│   ├── images/             # Visual assets organized by category
│   │   ├── alphabets/      # Alphabet-related images
│   │   ├── numbers/        # Number representation images
│   │   ├── colors/         # Color swatches and examples
│   │   ├── animals/        # Animal illustrations
│   │   ├── birds/          # Bird illustrations
│   │   ├── vehicles/       # Vehicle illustrations
│   │   ├── shapes/         # Shape illustrations
│   │   ├── body-parts/     # Body part illustrations
│   │   └── occupations/    # Occupation illustrations
│   └── audio/              # Audio pronunciations
│       ├── en/             # English audio files
│       ├── hi/             # Hindi audio files
│       └── gu/             # Gujarati audio files
└── backup/                 # Backup and legacy files
```

## 🚀 API Usage

### Base URL
```
https://your-domain.com/api/
```

### Endpoints

#### Get All Categories
```http
GET /api/data/index.json
```

#### Get Category Data
```http
GET /api/data/{category}.json
```

**Available Categories:**
- `alphabets` - A-Z learning with examples
- `numbers` - 1-9 numerical learning
- `colors` - Color identification
- `animals` - Animal recognition
- `birds` - Bird species
- `vehicles` - Transportation types
- `shapes` - Geometric shapes
- `body-parts` - Human anatomy
- `occupations` - Professional roles

#### Get Assets
```http
GET /api/assets/images/{category}/{filename}
GET /api/assets/audio/{language}/{filename}
```

## 📊 Data Structure

Each category follows a consistent JSON structure:

```json
[
  {
    "id": "unique_identifier",
    "name": {
      "en": "English Name",
      "hi": "हिंदी नाम",
      "gu": "ગુજરાતી નામ"
    },
    "media": {
      "image": "assets/images/category/item.png"
    },
    "audio": {
      "en": "assets/audio/en/item-en.mp3",
      "hi": "assets/audio/hi/item-hi.mp3",
      "gu": "assets/audio/gu/item-gu.mp3"
    },
    "meta": {
      "category": "category_name",
      "order": 1,
      "letter": "A"  // for alphabets
    },
    "tags": ["tag1", "tag2", "kids"],
    "voiceSupport": {
      "en": true,
      "hi": true,
      "gu": true
    },
    "accessibility": {
      "altText": {
        "en": "Descriptive alt text",
        "hi": "वर्णनात्मक alt टेक्स्ट",
        "gu": "વર્ણનાત્મક alt ટેક્સ્ટ"
      }
    }
  }
]
```

## 🌐 Implementation Examples

### JavaScript/TypeScript
```javascript
// Fetch alphabets data
const response = await fetch('/api/data/alphabets.json');
const alphabets = await response.json();

// Get specific item
const letterA = alphabets.find(item => item.id === 'A');
console.log(letterA.name.en); // "Apple"

// Play audio
const audio = new Audio(letterA.audio.en);
audio.play();
```

### React Component
```jsx
import { useState, useEffect } from 'react';

function AlphabetLearning() {
  const [alphabets, setAlphabets] = useState([]);
  const [language, setLanguage] = useState('en');

  useEffect(() => {
    fetch('/api/data/alphabets.json')
      .then(res => res.json())
      .then(setAlphabets);
  }, []);

  return (
    <div className="alphabet-grid">
      {alphabets.map(item => (
        <div key={item.id} className="alphabet-card">
          <img
            src={item.media.image}
            alt={item.accessibility.altText[language]}
          />
          <h3>{item.name[language]}</h3>
          <audio controls>
            <source src={item.audio[language]} type="audio/mpeg" />
          </audio>
        </div>
      ))}
    </div>
  );
}
```

### CDN and Caching Strategy

#### Recommended HTTP Headers
```
# For data files (frequent updates)
Cache-Control: public, max-age=3600, must-revalidate

# For images (rare updates)
Cache-Control: public, max-age=31536000, immutable

# For audio files (rare updates)
Cache-Control: public, max-age=31536000, immutable
```

#### CloudFlare/CDN Setup
```javascript
// Cache configuration
const cacheConfig = {
  '/api/data/*': { maxAge: '1h', mustRevalidate: true },
  '/api/assets/images/*': { maxAge: '1y', immutable: true },
  '/api/assets/audio/*': { maxAge: '1y', immutable: true }
};
```

## 🎯 Use Cases

1. **Educational Apps**: Mobile and web applications for children's learning
2. **Language Learning**: Multi-language pronunciation and vocabulary
3. **Accessibility Tools**: Screen reader and accessibility applications
4. **Interactive Games**: Educational gaming content
5. **Curriculum Development**: Structured learning materials

## 🛠️ Development

### Local Development
```bash
# Serve the API locally
npx http-server . -p 8080 --cors

# Access at http://localhost:8080/api/
```

### Validation
```bash
# Validate JSON structure
for file in api/data/*.json; do
  echo "Validating $file"
  jq empty "$file" && echo "✅ Valid" || echo "❌ Invalid"
done
```

## 📱 Mobile Optimization

- All images optimized for web delivery
- Progressive loading support
- Compressed audio files for faster loading
- Responsive image sizing

## 🌍 Internationalization (i18n)

The API supports three languages:
- **English (en)**: Primary language
- **Hindi (hi)**: Devanagari script support
- **Gujarati (gu)**: Gujarati script support

### Language Switching
```javascript
function switchLanguage(lang) {
  // Update all displayed content
  document.querySelectorAll('[data-lang]').forEach(el => {
    const key = el.dataset.lang;
    el.textContent = currentItem.name[lang];
  });

  // Update audio source
  audioElement.src = currentItem.audio[lang];
}
```

## 🔒 Security & Best Practices

- All content is family-friendly and educational
- No user-generated content
- Static JSON files for security
- CORS headers configured for web applications
- Content-Type validation recommended

## 📈 Performance Optimization

### Image Optimization
- Use WebP format where supported
- Implement lazy loading
- Serve appropriate sizes for different devices

### Audio Optimization
- Compressed audio files (64kbps recommended)
- Preload critical audio files
- Use audio sprites for better performance

### Data Loading
- Implement pagination for large datasets
- Use service workers for offline caching
- Bundle related data for fewer requests

## 🤝 Contributing

1. Maintain consistent JSON structure
2. Ensure all three languages are supported
3. Optimize images before adding
4. Test audio files across browsers
5. Update this README for any structural changes

## 📄 License

This educational content is provided for learning purposes. Please ensure proper attribution when using in educational applications.

---

**Version**: 2.0.0
**Last Updated**: September 2025
**Maintained by**: JNGLBK Team