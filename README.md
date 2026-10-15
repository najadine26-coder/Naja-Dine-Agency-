# Naja Restaurant — Homepage

Arabic-first (RTL) homepage for **Naja Restaurant — "Feel Fresh"**, Dammam, styled in the logo's red, charcoal and white. It's built with plain HTML, CSS and vanilla JavaScript, with GSAP + ScrollTrigger for the scroll animations. There's no build step and no framework.

## Brand identity

The colors come from the Naja logo (`assets/images/naja-sign.webp`):

| Token | Value | Use |
|---|---|---|
| `--brand-fill` | `#EE1D23` | Logo red: buttons and fills (white text on top) |
| `--brand` | `#FF4D45` | Logo red lifted slightly so small text on charcoal meets WCAG AA (5.7:1) |
| `--brand-deep` | `#7A0B10` | Deep red for glows and gradient ends |
| `--glow` | `#FFD9B8` | Warm halo of the illuminated sign |
| `--bg` / `--bg-2` | `#121212` / `#1A1A1A` | Charcoal, like the sign's wall |
| `--cream` / white | `#FFF8F2` / `#FFFFFF` | Text |

- "Naja" and the **"Feel Fresh"** tagline use **Kaushan Script**, a brush script close to the logo lettering. Under the tagline sits the logo's red swoosh, an inline SVG (`#i-swoosh`).
- The logo sign photo appears in the hero (desktop) and in the closing *Visit & Order* section, with a pulsing red glow.
- If you get a clean vector logo (SVG/PNG with a transparent background), you can drop it in `assets/images/` and point `najaImages.logoSign.src` at it in `js/config.js`.

## Run it locally

You need Node 18+ (or Python 3).

```bash
cd naja-restaurant
npm start                     # → http://localhost:8080  (zero-dependency static server)
# or
python3 -m http.server 8080   # alternative
```

`npm run check` syntax-checks every JavaScript file.

Opening `index.html` straight from disk (`file://`) also works. A local server is better because it matches production.

## Project structure

```
naja-restaurant/
├── index.html              Homepage markup: header, 8 sections, footer, lightbox
├── menu.html               Menu page markup (see "Menu page" below)
├── css/style.css           All shared styles (logical properties → genuine RTL/LTR mirroring)
├── css/menu.css            Menu-page-only styles, loaded after style.css
├── css/fonts.css           Self-hosted Fustat (Arabic) + Inter (English)
├── js/config.js            ★ Business details, image library, gallery order (home + menu page)
├── js/menu-data.js         ★ Categories, signature dishes, menu items (sample placeholders)
├── js/translations.js      ★ All Arabic/English copy
├── js/main.js              Language switching, rendering, menu filter/search, WhatsApp, lightbox (both pages)
├── js/animations.js        GSAP/ScrollTrigger cinematic motion (progressive enhancement)
├── js/vendor/              GSAP 3.12.5 + ScrollTrigger (self-hosted, no CDN dependency)
├── assets/fonts/           Fustat, Inter and Kaushan Script WOFF2 files (SIL Open Font License)
├── assets/images/          naja-sign.webp (logo sign) — add the restaurant's own photos here
└── scripts/serve.mjs       Local dev server
```

★ = files the restaurant/content editor normally changes.

## Homepage sections

1. **Cinematic Hero** (`#home`): full-screen photo, animated gold-gradient headline, drifting ambient glows, a cursor spotlight, layered parallax, and WhatsApp and Menu CTAs.
   - *Category marquee*: an animated band of gradient category names that leans with your scroll speed.
2. **Signature Dishes** (`#signature`): four 3D-tilt cards with a rotating gradient border on hover, a quantity stepper and WhatsApp ordering. On desktop (≥1024px) it becomes a pinned horizontal showcase. Phones and tablets get a normal vertical layout.
3. **Browse by Category** (`#categories`): large editorial category rows. On desktop a floating photo preview follows the cursor. Clicking a row filters the menu and jumps to it.
4. **Explore the Menu** (`#menu`): category filters, bilingual search that tolerates Arabic spelling variants (أ/ا, ة/ه, ى/ي, diacritics), an accessible empty state, and per-item WhatsApp ordering.
5. **The Naja Experience** (`#experience`): asymmetric layout with a scroll-linked clip reveal, parallax and a gradient headline.
   - *Cinematic banner*: a full-screen quote over a slow-zooming photo.
6. **Food Gallery** (`#gallery`): asymmetric grid with an accessible lightbox. The lightbox has prev/next/close buttons, Esc, arrow keys (mirrored in RTL), touch swipe and a focus trap.
7. **How to Order** (`#how-to-order`): three steps (choose → send on WhatsApp → restaurant confirms). A gradient timeline draws itself as you scroll.
   - *"Order Now" marquee*: an outlined band running in the reverse direction.
8. **Visit & Order** (`#visit`): gradient wordmark that opens up on arrival, CTAs, address, hours, phone and WhatsApp.

The footer, the gold scroll-progress bar and the mobile bottom action bar support these sections.

**Motion summary:** word-by-word blur reveals on headings, animated gradient text, drifting aurora glows, magnetic large buttons and the cursor spotlight (desktop), velocity-skewed marquees, pinned horizontal dishes, parallax and clip reveals. All of it switches off under `prefers-reduced-motion`.

## Menu page (`menu.html`)

The header, footer, language switcher, WhatsApp logic, lightbox and design tokens are shared with the homepage. The "Menu" link in both pages' navigation opens it. It has six parts:

1. **Menu hero** (`#menu-hero`): "قائمة الطعام" / "Explore Our Menu", a View Dishes button and scroll parallax.
2. **Sticky category bar** (`#menu-categories`): stays under the header while you browse the dishes and scrolls sideways on phones. It's built from `najaMenuCategories` with item counts, and **categories with no items are hidden automatically**, so the bar only shows what's really on the menu.
3. **Search & filters** (`#menu-search`): the same Arabic-tolerant search as the homepage, a live result count, and a removable "Category: …" chip.
4. **Food menu grid** (`#menu-dishes`): cards with photo, Arabic and English names, description, price and a WhatsApp Order button. It shows 1 column on small phones, 2 from 560px, 3 from 1024px and 4 from 1440px. Sample dishes carry a "Sample dish" badge and "Sample price" note.
5. **Featured gallery** (`#featured-gallery`): six images from `najaMenuGallery` in `js/config.js`, with the shared lightbox.
6. **Order** (`#order`): WhatsApp, Call and Directions buttons plus address, hours, phone and WhatsApp details. Unlike the homepage, anything not configured is **hidden** instead of disabled. If nothing is configured, a "details will be published soon" note shows.

**Dish photos:** give a menu item `image: "<key from najaImages>"` only when that photo really shows the dish. Items without one show a branded "Photo coming soon" frame. Right now only the grills, the classic burger, the pizza and the steak reuse library photos, and those are still Unsplash placeholders.

**Structured data:** the menu page publishes the same Restaurant JSON-LD as the homepage. Menu items are added as `hasMenu` only once they're marked `placeholder: false`, so no sample dish or price is ever published as real.

**Language:** switching language keeps the same dish in view. Links between the two pages carry `?lang=en`, so the choice survives even when localStorage is blocked.

## ⚠️ Before launch: details still to be supplied

Nothing below has been invented. Until it's filled in, the matching buttons are **disabled**. Clicking one shows a short message explaining it's unavailable; it never opens a broken link.

| What | Where (`js/config.js`) | Effect when empty |
|---|---|---|
| WhatsApp number | `whatsapp: "9665XXXXXXXX"` (international, digits only) | All "Order on WhatsApp" buttons are disabled |
| Phone | `phone: "+9665XXXXXXXX"` | "Call Now" is disabled |
| Address | `address: { ar: "", en: "" }` | Shows "To be announced" |
| Google Maps link | `googleMapsUrl: "https://maps.app.goo.gl/…"` | "Get Directions" is disabled |
| Opening hours | `openingHours: [...]` (example in file) | Shows "To be announced" |
| Social profiles | `social: { instagram: "", … }` | The "Follow" column is hidden |
| Site URL | `siteUrl` | Not added to structured data |
| Arabic name spelling | `nameAr: "مطعم نجا"` | Please confirm the official spelling |

The **mobile bottom bar** (Call / WhatsApp) only appears once a phone or WhatsApp number exists. The **JSON-LD** structured data only includes values that are actually configured. It never contains ratings, reviews, coordinates or awards.

### WhatsApp message format

Every WhatsApp link is built from the config and encoded with `encodeURIComponent()`. The message is written in the visitor's current language:

```
Hello Naja Restaurant,
I'd like to order:
• Naja Classic Burger × 3
Displayed price: SAR 42 each
Please confirm availability and the final total. Thank you.
```

## Menu & prices (placeholders)

Every dish, description, category and price in `js/menu-data.js` is a **sample**. The site labels them that way ("Sample menu", "Sample price"). To go live:

1. Replace the items with the real menu. Each item needs `name.ar/en`, `desc.ar/en`, `category` and `price` (a number in SAR, or `null` to hide the price).
2. Set `placeholder: false` on each verified item.
3. Remove or edit the `menu.notice` / `sig.copy` / `footer.disclaimer` strings in `js/translations.js`.
4. To hide every price until they're confirmed, set `showSamplePrices: false` in `config.js`.

Categories nobody uses can be removed from `najaMenuCategories`.

## Images

All image URLs live in **`js/config.js → najaImages`**. They're Unsplash placeholders, **not photos of Naja Restaurant**. To replace one, drop your file in `assets/images/` and change its `src`, e.g. `src: "assets/images/hero.jpg"`, then update the `alt` text in both languages.

- The **hero** image URL is also hard-coded in `index.html` (`<link rel="preload">` and the hero `<img>`) so it loads first, before any JavaScript runs. **Update both places** when you change it.
- Unsplash URLs get responsive `srcset`s automatically. Local images are served as-is, so export them at sensible sizes (hero ≈ 2200px wide, others ≈ 1200px).
- If an image fails to load, its frame shows an elegant dark/gold pattern instead of a broken icon.
- Images below the fold are lazy-loaded.

**Availability note:** the development sandbox couldn't reach `images.unsplash.com` (network policy), so the supplied URLs weren't fetched from there. They're standard Unsplash photo IDs and load normally in a browser. Check them once in a real browser, and replace them with the restaurant's photography before production.

## Language

- Arabic is the default (`lang="ar" dir="rtl"`) and uses **Fustat**. English uses `lang="en" dir="ltr"` and **Inter**. Both fonts are self-hosted in `assets/fonts/`, so the site doesn't depend on Google Fonts.
- The switcher remembers the choice (localStorage) and supports deep links: `?lang=en`.
- All copy lives in `js/translations.js`. In markup, text uses `data-i18n="key"`, attributes use `data-i18n-attr="aria-label:key"`, and `data-i18n-alt="key"` shows the *other* language as a gold echo line under a heading.

## Motion & accessibility

- Only the Signature Dishes section is pinned, and only on desktop. Every other section scrolls normally, and the footer is always reachable.
- `prefers-reduced-motion` turns off pinning, parallax, tilt and reveals entirely.
- If GSAP fails to load, the page stays fully visible and usable, because animations only ever *add* to the default layout.
- The page has a skip link, visible gold focus rings, keyboard-operable controls, an `aria-live` menu result count, `aria-pressed` category buttons and a focus-trapped lightbox and mobile menu.
- It was tested for horizontal overflow at 320, 375, 430, 768, 1024, 1440 and 1920px in both languages.

## Notes

- GSAP is free for this use under its standard license (https://gsap.com/standard-license).
- Pages so far: Home (`index.html`) and Menu (`menu.html`). Separate About / Contact pages aren't included yet.
