# JNGLBK Data

## Structure
- `data/`
  - `index.json`: Categories metadata (UI, colors, icons)
  - `<category>.json`: Items for each category
  - `schemas/`: JSON Schemas
    - `item.schema.json`
    - `index.schema.json`
- `icons/`
  - `categories/`: Category icons used in index
  - `items/<category>/`: Item images for each category
- `scripts/`
  - `validate.py`: Validates data files and asset paths

## Conventions
- Items: `id`, `slug`, `name.{en,hi,gu}`, `media.image`, `meta.category`, `meta.order`, `tags[]`, `accessibility.altText.{en,hi,gu}`
- `slug`: auto-generated from `name.en`
- `meta.order`: sequential starting at 1
- Image paths: `icons/categories/*.png` (index), `icons/items/<category>/*.png` (items)
- Tags: lowercase, unique per item

## Validation
Run validation before committing changes:
```bash
python3 scripts/validate.py
```

## Adding a new item
1. Add image to `icons/items/<category>/`.
2. Add item entry to `data/<category>.json` with the required fields.
3. Run the validator.

## Adding a new category
1. Add icon to `icons/categories/<name>.png`.
2. Add category entry to `data/index.json`.
3. Create `data/<name>.json` and populate items.
4. Run the validator.

