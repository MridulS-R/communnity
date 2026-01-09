# CommInnity Data — Rails Website

Modern, compliance-first website for an India-first B2B data company.

Key features
- Products: Datasets, Enrichment API, Monitoring/Signals
- Data Catalog with search/filters and dataset detail pages
- Quality & Methodology and Compliance pages
- Lead capture form (works via DB persistence), success toasts
- Ready for deployment on Render (web service + PostgreSQL)

Tech
- Ruby on Rails 7.1, PostgreSQL, Puma
 - Tailwind via tailwindcss-rails (asset pipeline; no Node required)

Local setup
1) Ruby 3.2.2 recommended (`.ruby-version` provided)
2) Set up Postgres and a database named `comminnity_development` (or set `DATABASE_URL`)
3) Install gems and setup DB:
   bundle install
   bundle exec rails db:setup
   bundle exec rails s

Routes
- `/` Home
- `/products`, `/products/datasets`, `/products/api`, `/products/monitoring`
- `/catalog` and `/catalog/:slug`
- `/api` (API docs landing)
- `/solutions`, `/quality`, `/compliance`, `/pricing`
- `/about`, `/careers`, `/contact`
- `/signup`, `/login`

Lead capture
- Form posts to `POST /leads`
- Model: `Lead` with basic validations (name, email, company, role, use_case, consent)
- Success UX: redirect with notice

Mock data
- `app/data/datasets.json` with ~12 datasets (industries, geographies, fields, quality metrics)

Render deployment
1) Push to GitHub/GitLab
2) In Render:
   - New + -> Blueprint -> point to repo
   - Ensure `render.yaml` is detected
   - Create the PostgreSQL database and web service
3) Set environment variable `RAILS_MASTER_KEY` (create with `rails credentials:edit` locally; copy value)
4) Deploy. Render will run `bin/render-build.sh` to install gems and migrate.

Notes
- Tailwind is integrated via `tailwindcss-rails` with a brand palette under `brand-50..900`. Use classes like `btn-brand`, `btn-brand-outline`, and `link-brand`.
- No authentication; `/signup` and `/login` are placeholders for lead capture.
- For purpose limitation/opt-out, edit `/compliance`, `/privacy` as needed.
