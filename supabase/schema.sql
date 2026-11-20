-- Run in Supabase SQL Editor. Each row is isolated to its authenticated owner.
create extension if not exists pgcrypto;
create table if not exists public.contacts (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 name text not null, phone text, organization text, workspace text not null default 'Networking', notes text default '',
 created_at timestamptz not null default now(),
 constraint contacts_workspace check (workspace in ('Personal','Networking','Waterynation','Projects','Travoy Hub'))
);
create table if not exists public.chat_groups (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 name text not null, workspace text not null default 'Networking', notes text default '',
 created_at timestamptz not null default now(),
 constraint groups_workspace check (workspace in ('Personal','Networking','Waterynation','Projects','Travoy Hub'))
);
create table if not exists public.tasks (
 id uuid primary key default gen_random_uuid(), user_id uuid not null references auth.users(id) on delete cascade,
 title text not null, workspace text not null default 'Projects', assignee text default '',
 due_date date, status text not null default 'todo', notes text default '', created_at timestamptz not null default now(),
 constraint tasks_workspace check (workspace in ('Personal','Networking','Waterynation','Projects','Travoy Hub')),
 constraint tasks_status check (status in ('todo','doing','done'))
);
create index if not exists contacts_owner_idx on public.contacts(user_id);
create index if not exists chat_groups_owner_idx on public.chat_groups(user_id);
create index if not exists tasks_owner_idx on public.tasks(user_id);
alter table public.contacts enable row level security;
alter table public.chat_groups enable row level security;
alter table public.tasks enable row level security;
-- Avoid permissive grants across owners; each policy checks auth.uid().
create policy "contacts_owner" on public.contacts for all to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "groups_owner" on public.chat_groups for all to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
create policy "tasks_owner" on public.tasks for all to authenticated using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));
