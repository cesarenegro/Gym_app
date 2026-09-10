---
name: Kinetic Obsidian
colors:
  surface: '#131314'
  surface-dim: '#131314'
  surface-bright: '#3a393a'
  surface-container-lowest: '#0e0e0f'
  surface-container-low: '#1c1b1c'
  surface-container: '#201f20'
  surface-container-high: '#2a2a2b'
  surface-container-highest: '#353436'
  on-surface: '#e5e2e3'
  on-surface-variant: '#c5c9ac'
  inverse-surface: '#e5e2e3'
  inverse-on-surface: '#313031'
  outline: '#8f9378'
  outline-variant: '#444932'
  surface-tint: '#b0d500'
  primary: '#ffffff'
  on-primary: '#2a3400'
  primary-container: '#caf300'
  on-primary-container: '#596c00'
  inverse-primary: '#536600'
  secondary: '#c6c6cb'
  on-secondary: '#2f3034'
  secondary-container: '#46464b'
  on-secondary-container: '#b5b4ba'
  tertiary: '#ffffff'
  on-tertiary: '#303033'
  tertiary-container: '#e4e1e5'
  on-tertiary-container: '#656467'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#caf300'
  primary-fixed-dim: '#b0d500'
  on-primary-fixed: '#171e00'
  on-primary-fixed-variant: '#3e4c00'
  secondary-fixed: '#e3e2e7'
  secondary-fixed-dim: '#c6c6cb'
  on-secondary-fixed: '#1a1b1f'
  on-secondary-fixed-variant: '#46464b'
  tertiary-fixed: '#e4e1e5'
  tertiary-fixed-dim: '#c8c6c9'
  on-tertiary-fixed: '#1b1b1e'
  on-tertiary-fixed-variant: '#47464a'
  background: '#131314'
  on-background: '#e5e2e3'
  surface-variant: '#353436'
typography:
  display-hero:
    fontFamily: Space Grotesk
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 52px
    letterSpacing: -0.04em
  display-hero-mobile:
    fontFamily: Space Grotesk
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.03em
  headline-editorial-lg:
    fontFamily: Space Grotesk
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-editorial-md:
    fontFamily: Space Grotesk
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  metric-numeral-lg:
    fontFamily: Space Grotesk
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  metric-numeral-md:
    fontFamily: Space Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.02em
  body-lead:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 26px
    letterSpacing: -0.01em
  body-default:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 22px
    letterSpacing: 0em
  body-compact:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
    letterSpacing: 0.01em
  tag-uppercase:
    fontFamily: Space Grotesk
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.12em
  tab-label:
    fontFamily: Space Grotesk
    fontSize: 10px
    fontWeight: '600'
    lineHeight: 12px
    letterSpacing: 0.1em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter-xs: 0.25rem
  gutter-sm: 0.5rem
  gutter-md: 1rem
  gutter-lg: 1.5rem
  gutter-xl: 2rem
  margin-mobile: 1.25rem
  margin-tablet: 2rem
  margin-desktop: 3rem
  safe-bottom-nav: 5.25rem
---

## Brand & Style

This design system expresses high-performance discipline merged with the restraint of luxury print editorial. It rejects cartoonish gamification, neon clutter, and generic SaaS patterns in favor of cinematic weight, architectural grid structure, and clinical precision.

### Personality & Tone
- **Elite Discipline:** Focused, uncompromised, and engineered. Every screen feels intentional and calibrated.
- **Athletic Editorial:** Layouts adopt the rhythm of high-end sports quarterlies—oversized display typography, intentional negative space, precise micro-labels, and monolithic photographic treatments.
- **Tactile Modernity:** Dark obsidian surfaces layered with razor-thin hairline borders, deep contrast ratios, and controlled bursts of electric acid lime that signal immediate physical action or live telemetry.

### Design Movement
- **Architectural Minimalism × Dark Cinema:** Deep charcoal backdrops (`#0A0A0B`), high tonal hierarchy, strict typographic grid lines, hairline keylines, and sharp image framing with selective grain and high contrast.

## Colors

The system uses a dark palette defined by volcanic blacks and clinical grays, punctured by an electric high-visibility volt accent. Acid lime is reserved exclusively for vital actions, live sensor/training status, primary interactive targets, and select typographic markers.

### Palette Architecture (Dark Default)
- **Obsidian Core (Background):** `#0A0A0B` — Base canvas for all mobile and edge-to-edge experiences.
- **Carbon Layer 1 (Surface Default):** `#141416` — Recessed utility modules, table backgrounds, and unselected structural items.
- **Carbon Layer 2 (Surface Elevated):** `#1B1B1E` — Floating action sheets, bottom sheets, active cards, and modal sheets.
- **Hairline Border:** `#26262B` — 1px structural strokes that define grids and visual boundaries without adding visual weight.
- **Primary Text:** `#F5F5F7` — High-legibility off-white for titles, values, and essential metrics.
- **Secondary / Slate Text:** `#8E8E93` — Muted labels, metadata, units of measurement, and unselected states.
- **Performance Volt (Primary Accent):** `#D4FF00` — Singular accent for primary CTAs, active tab indicators, metric targets achieved, and system alerts.

### Alternative Light Palette (Editorial Ivory)
- **Background:** `#F5F3EC`
- **Surface:** `#EAE6DC`
- **Elevated:** `#FFFFFF`
- **Hairline Border:** `#DDD8CB`
- **Primary Text:** `#111112`
- **Secondary Text:** `#6E6E73`
- **Accent Interactive:** `#111112` (with `#D4FF00` retained as a badge/highlight layer with `#111112` text).

### Application Rules
- **The 90/8/2 Rule:** 90% Obsidian/Carbon tones, 8% Crisp White and Slate typography, 2% Performance Volt.
- Never use volt for general body copy or decorative borders.
- Gradient fills are prohibited across UI elements; all surfaces remain solid, flat, or subtly blurred through glass overlays.

## Typography

The typography pairs the sharp, technical geometries of Space Grotesk for editorial headlines, metrics, and uppercase tracking tags with the utilitarian clarity of Inter for sustained body text, metadata, and instructional descriptions.

### Typographic Hierarchy Rules
- **Headlines & Editorial Titles:** Set in Space Grotesk. Titles follow sentence case in narratives or tight all-caps in section indexing (e.g., `PROGRAM PROTOCOL // 04`).
- **Telemetry & Numbers:** Large numerical readouts (heart rate, wattage, split times, membership IDs) use Space Grotesk with tabular figures (`tnum`) enabled to prevent layout shifting during real-time updates.
- **Labels & Tags:** Always set in Space Grotesk, uppercase, with wide letter spacing (`0.12em`). These act as precision index tags.
- **Body & Captions:** Inter ensures neutral, high-legibility rendering against high-contrast, dark backdrops. Avoid ultra-thin weights below 14px to preserve accessibility.

## Layout & Spacing

The layout is built upon an asymmetric editorial grid system that alternates between edge-to-edge cinematic imagery and structured content bays separated by hairline divisions.

### Grid Architecture
- **Mobile (Core Target):** 4-column layout with `1.25rem` (20px) outer margins and `0.75rem` (12px) gutters. Top header and status layers honor dynamic island and notch clearances.
- **Tablet / Large Screens:** 8-column layout with `2rem` (32px) margins and `1rem` (16px) gutters. Content limits to a maximum width of `840px` for reading streams or opens into asymmetric 5:3 split viewports for training session dashboards.

### Editorial Composition Patterns
- **Asymmetric Dailies:** Day-to-day metrics use alternating module widths (e.g., 65% width hero workout card aligned left, 35% telemetry column aligned right).
- **Hairline Dividers:** Spacing rhythm relies on explicit `1px` structural borders (`#26262B`) rather than empty whitespace gaps alone, providing a blueprint-like, engineered layout.
- **Floating AI Trigger Anchor:** Anchored dynamically at `bottom: 5.75rem` and `right: 1.25rem`, clearing the lower tab-bar system.

## Elevation & Depth

This system avoids soft drop shadows and diffuse neomorphism. Visual depth is engineered through planar shifts, deliberate tonal stepping, and hairline edge boundaries.

### Tonal Stratification
1. **Base Floor (`#0A0A0B`):** System canvas, underlays, and base scroll regions.
2. **Surface Layer 1 (`#141416`):** Embedded metric cards, calendar tiles, list rows, inactive selector blocks.
3. **Surface Layer 2 (`#1B1B1E`):** Dynamic modals, elevated drawer trays, sliding metric details.
4. **Overlay Chrome (`#0A0A0B` at 85% opacity with `backdrop-filter: blur(20px)`):** Bottom tab navigation and sticky navigation headers.

### Edge Definition
- Rather than diffuse shadows, elevated layers use a subtle perimeter stroke: `1px solid #26262B`.
- When an active state requires elevated priority (e.g., in-progress workout drawer), apply a focused keyline illumination: `1px solid #D4FF00` or an inner outline rather than an external blur.

## Shapes

The design system employs a restrained corner treatment (`roundedness: 1`). Corners are strictly architectural: 4px for standard UI elements and badges, 8px for larger cinematic media cards and bottom sheets.

### Corner Tokens
- **Micro UI & Badges:** `4px` (`rounded-sm`). Applies to tags, telemetry pills, session stat boxes, and inputs.
- **Cards & Media Bays:** `8px` (`rounded-md`). Used on workout cards, facility booking modules, and modal containers.
- **Action Pills (Select Elements):** `9999px` (fully rounded) is reserved strictly for primary floating CTA buttons, user avatar circles, and the floating `✦ GYM AI` launcher.

## Components

### Buttons & Interactive Triggers
- **Primary Action Pill:** Background `#D4FF00`, text `#0A0A0B`, font `Space Grotesk` 12px bold, all-caps, tracking `0.1em`. Padding `14px 24px`. Rounded `9999px`. Active press scales to `0.98`.
- **Secondary Ghost Keyline:** Background transparent, border `1px solid #26262B`, text `#F5F5F7`. Hover/focus border switches to `#8E8E93`.
- **Destructive/Critical:** Background `#1B1B1E`, text `#FF3B30`, border `1px solid rgba(255, 59, 48, 0.2)`.

### Floating AI Trigger (`✦ GYM AI`)
- **Structure:** Compact capsule pill positioned above the tab bar.
- **Styling:** Background `#141416` with a `1px solid #D4FF00` border, `backdrop-filter: blur(12px)`.
- **Typography:** `✦ GYM AI` in Space Grotesk Bold, 11px uppercase, tracking `0.12em`. Spark icon and text colored `#D4FF00`.

### Navigation Bar (5-Tab System)
- **Tabs:** `HOME`, `TRAIN`, `BOOK`, `COMMUNITY`, `PROFILE`.
- **Height & Frame:** Fixed `64px` height + device safe bottom area padding. Background `#0A0A0B` at 92% opacity with `20px` backdrop blur, bordered with a top hairline `1px solid #26262B`.
- **State Behavior:**
  - Active: Icon and label colored `#D4FF00`. Underneath, an active indicator dot (3px) in `#D4FF00`.
  - Inactive: Icon and label colored `#8E8E93`.

### Cards & Editorial Modules
- **Cinematic Media Card:** Full-bleed dark photography with a gradient scrim (`linear-gradient(180deg, rgba(10,10,11,0) 40%, #0A0A0B 100%)`). 8px corner radius, wrapped with a 1px `#26262B` stroke. Typography overlays directly on the scrim.
- **Telemetry Tile:** Solid `#141416` fill, `1px solid #26262B`, 4px radius. Top row features micro-label (`tag-uppercase`) in `#8E8E93`, middle row holds large numerical stat in `#F5F5F7` with unit in `#8E8E93`, bottom status accent in `#D4FF00`.

### Form Controls & Inputs
- **Text Inputs:** Background `#141416`, border `1px solid #26262B`, height `48px`, padding `0 16px`, corner radius `4px`. Placeholder text `#8E8E93`. Active focus transitions border to `#D4FF00` with no exterior glow ring.
- **Checkboxes & Radios:** Minimal geometric squares (`18x18px`) with `2px` corners. Checked state fills `#D4FF00` with obsidian `#0A0A0B` checkmark icon.

### Chips & Filters
- **Status Filter:** Height `32px`, padding `0 14px`, 4px corner radius. Inactive: `#141416` background, `#8E8E93` text, hairline border `#26262B`. Active: `#D4FF00` background, `#0A0A0B` text, font weight 600.