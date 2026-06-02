# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this app does

DestinationPicker is a Rails 7.2 app that lets users browse and randomly select travel destinations (sub-national regions, not countries). Each destination is a geographic region (e.g., "Bajío", "Canadian West") with associated flags, languages, and major cities. The home page offers two paths: browse all destinations or get a random one.

## Commands

```bash
# Start the server
bin/rails server

# Run all tests
bin/rails test

# Run a single test file
bin/rails test test/models/destination_test.rb

# Run a single test by line number
bin/rails test test/models/destination_test.rb:10

# Database setup (first time)
bin/rails db:create db:schema:load

# Seed flags (downloads ISO country codes from the web, then loads into DB)
rake seed_flags:process

# Seed regions and languages from the CSV
rake seed_destinations:seed_dependencies

# Seed destinations from the production CSV
rake seed_destinations:generate_destinations

# Seed destinations from the sample CSV (dev)
rake seed_destinations:generate_destinations -- -d
```

## Architecture

**Data model:** `Destination` is the central model. Each destination belongs to a `Region` (macroregion like "North America"), has a primary `Language` and optional secondary `Language`, and one or two `Flag` records. `Flag` uses a 2-character ISO country code as its primary key (string, not integer). Destinations can span multiple countries (flag_primary + flag_secondary) and multiple states/provinces (stored as a comma-separated string in `divisions`). Multiple cities are stored slash-delimited in the `city` column and split by `Destination#cities`.

**Flag emoji rendering:** `Flag#get_flag_emoji` converts the 2-letter ISO code to Unicode regional indicator symbols by adding offset 127397 to each character's codepoint. This produces country flag emoji without storing emoji directly.

**Seeding:** The database is populated entirely from CSV files in `public/lists/`. `destinations_list.csv` is the production source; `sample_upload.csv` is a small dev subset. The rake tasks in `lib/tasks/seed_data.rake` handle the full pipeline: download ISO country codes → seed flags → seed regions/languages → seed destinations. `activerecord-copy` gem is used for bulk-inserting flags via PostgreSQL COPY protocol.

**No authentication, no admin UI** — this is a read-only browsing app. All write operations happen through rake tasks.

**Routes:** Three public routes — `/` (home), `/destinations` (index list), `/select` (random redirect), `/destinations/:id` (show).

**JavaScript:** Uses importmap + Hotwire (Turbo + Stimulus). Currently minimal JS.

**Database:** PostgreSQL required. Dev DB: `destination_picker_dev`, test DB: `destination_picker_test`.
