# Artem Onuchin · modern religious art

A personal portfolio for dharma art projects: digital works made with the same purpose as thangkas and statues, as supports that carry the blessing of the lineage.

Live (temporary URL until a domain is bought): https://onuchin-artem.github.io/portfolio-site/

## Works on the page

| Work | Link | Source of truth for its URL |
|------|------|-----------------------------|
| Heruka Mandala (3D, password-gated) | https://5-deities-mandala.pages.dev | `../heruka/docs/STATUS.md` ("private showcase: …") |
| The Source (Джерело), album | https://soundcloud.com/artem-onuchin/sets/the-source-dzherelo | SoundCloud |
| Думки у ретрітній хатинці (Hōjōki) | https://hojoki.org.ua | `../hojoki/web/build_web.py` (`SITE_URL`) |

## Layout

```
site/                 everything that is published (GitHub Pages deploys this folder)
  index.html          the page: plain HTML, no build step
  style.css           styles; one dark "shrine" look
  fonts.css           @font-face for the self-hosted Ysabeau subsets
  assets/fonts/       Ysabeau variable WOFF2 (latin, latin-ext, cyrillic, cyrillic-ext, symbols, math) + OFL
  assets/img/         work images, hero mandala, og-image (1200×630), favicon
  robots.txt, sitemap.xml
tools/check.sh        freshness check (links + work URLs + TODO list)
tools/git-hooks/      pre-commit runs the check
.github/workflows/    Pages deploy on push to main (paths: site/**)
```

**Font:** Ysabeau (Christian Thalmann, SIL OFL). It covers full IAST (ā ī ū ṛ ṃ ṅ ñ ṭ ḍ ṇ ś ṣ ḥ), ō/ö/ü, Ukrainian Cyrillic and arrows. Titles are set in spaced capitals.

## Develop

```bash
git config core.hooksPath tools/git-hooks   # once per clone
python3 -m http.server -d site 8000         # http://localhost:8000
```

## Before every commit: freshness check

The pre-commit hook runs `tools/check.sh`:
1. every external link on the page answers (401 from the gated mandala counts as alive);
2. each work's URL matches what its own repo says (sibling checkouts in `../`). For example, when the mandala gets its own domain, record it in heruka's STATUS.md and the check will flag the old link here;
3. lists the `TODO(...)` placeholders still on the page.

Bypass once (for example, offline): `SKIP_CHECK=1 git commit …`

## Open items (TODO)

- **copy**: all text is a first draft. Rewrite it in Artem's own words.
- **support**: create the Patreon and Buy Me a Coffee accounts, then replace the "soon" placeholders.
- **umami**: add a website in cloud.umami.is (same account as Hojoki), put its ID in `index.html`, uncomment the script. Events are already tagged with `data-umami-event` (Open work, Request access, Write to me).
- **about**: portrait photo, short bio.
- **album**: final release links (Bandcamp/streaming), and per-song dedications once the order is final.
- **domain**: buy it, add `site/CNAME`, update canonical, og:url, JSON-LD, robots.txt and sitemap.xml.

## SEO plan (future)

Done now: page title and description, canonical, Open Graph and Twitter card with a 1200×630 image, JSON-LD (`Person` with `Book`, `MusicAlbum` and `CreativeWork`), `robots.txt`, `sitemap.xml`, semantic headings, descriptive alt text, self-hosted fonts, lazy images.

Next:
1. **Domain first.** Every other step builds on the final URL. Then point `canonical`, `og:url`, JSON-LD, the sitemap and robots at it, and keep the github.io URL redirecting (GitHub does this automatically with a CNAME).
2. **Search Console + Bing Webmaster Tools.** Verify the domain, submit the sitemap, and watch coverage and queries.
3. **One page per work** (`/heruka/`, `/the-source/`, `/hojoki/`), each with its own title, description, OG image and JSON-LD. One page per song of The Source, each about its lineage master, gives search engines eight more specific pages (for example, "Milarepa song").
4. **Cross-links.** Link to this site from hojoki.org.ua, the mandala's loading or dedication screen, the SoundCloud profile and track descriptions, and the GitHub profile. Add those URLs to the JSON-LD `sameAs`.
5. **Name variants as real text.** Search uses both "Chakrasamvara" and "Cakrasaṃvara", "Ghantapa" and "Ghaṇṭāpa", "Hojoki" and "Hōjōki". Use one form in the body text and the other once (in a note or an alt text), not as hidden keywords.
6. **Performance stays an SEO factor.** Convert the JPEGs to AVIF/WebP with `<picture>`, keep LCP under 2 s (the hero mandala is the LCP element, so preload it), and check Core Web Vitals in Search Console.
7. **Ukrainian audience.** Hojoki's readers search in Ukrainian. Consider a short Ukrainian page (`/uk/`) with `hreflang` once the English copy is final.
8. **Content cadence.** Short notes from the work (a new mandala zone, a finished song) give the site fresh, specific pages. An optional `/notes/` section is the simplest way to do it.

## License

Text and images © 2026 Artem Onuchin. Ysabeau: SIL Open Font License 1.1 (`site/assets/fonts/OFL-Ysabeau.txt`).
