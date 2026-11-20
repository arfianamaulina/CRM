# WA Intelligence CRM v1.0 (Vercel + Supabase)

An actual Next.js starter with Supabase email authentication and per-user CRUD for Contacts, Groups and Tasks, five workspace filters, search, task status and a responsive dashboard.

## Setup
1. Create a Supabase project at https://supabase.com/dashboard.
2. Open **SQL Editor**, paste `supabase/schema.sql`, and run it **once** on a new project.
3. In Supabase **Project Settings > API / API Keys**, copy the project URL and **publishable (anon) key**. Never use a service-role or secret key in NEXT_PUBLIC variables.
4. Copy `.env.example` to `.env.local` and fill the values.
5. Run `npm install`, then `npm run dev`, then open http://localhost:3000.
6. Create an account via **Daftar akun**. If Supabase email confirmation is enabled, confirm via the email link before logging in.

## Deploy to Vercel
1. Push the unzipped project directory to a **private GitHub repository** (do not push `.env.local`).
2. At https://vercel.com/new import that repository and choose the Next.js framework preset.
3. In **Environment Variables**, set `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` to the same values used locally.
4. Click **Deploy**. Once deployed, open the Vercel URL and register/log in.
5. In Supabase **Authentication > URL Configuration**, set **Site URL** to your production Vercel domain. Add relevant redirect URLs if your auth flow changes later.

## Current scope
- Real Supabase authentication and owner-only row-level security (RLS).
- Contacts: name, phone, organization, workspace, notes; add/list/search/delete.
- Groups: name, workspace, notes; add/list/search/delete.
- Tasks: title, PIC, deadline, workspace, notes, status; add/list/search/update status/delete.
- Overview stats and five workspace filters.
- No WhatsApp connection, chat sync, AI summary, broadcasts, or bot yet. No demo records presented as real data.
- Contact phone numbers are manually entered; avoid uploading personal data without appropriate permissions.

## Security and limitations
- Supabase public anon/publishable key is intentionally client-side; RLS protects rows. Never expose `service_role`.
- For a personal-only deployment, consider restricting signup in Supabase Authentication after creating your account. Without restriction, others may create isolated accounts on your public site.
- This is an MVP, not an independently security-audited production application. Add stronger authentication, backups, consent controls, edit forms, audit logs and rate limiting before broader use.
- If SQL policy names already exist, run the schema on a fresh project or adapt migration statements.
