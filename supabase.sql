-- Ejecuta este archivo una sola vez en Supabase > SQL Editor.
create table if not exists public.dashboard_publications (
  id text primary key,
  payload jsonb not null,
  source_files jsonb not null default '[]'::jsonb,
  published_at timestamptz not null default now(),
  published_by uuid default auth.uid()
);
alter table public.dashboard_publications enable row level security;

-- Los administradores se registran aquí por su UUID de Authentication.
create table if not exists public.dashboard_admins (
  user_id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
alter table public.dashboard_admins enable row level security;

create or replace function public.is_dashboard_admin()
returns boolean language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.dashboard_admins where user_id = auth.uid());
$$;
grant execute on function public.is_dashboard_admin() to authenticated;

create policy "read current dashboard" on public.dashboard_publications
for select to anon, authenticated using (id = 'current');
create policy "admins publish dashboard" on public.dashboard_publications
for insert to authenticated with check (id = 'current' and public.is_dashboard_admin());
create policy "admins update dashboard" on public.dashboard_publications
for update to authenticated using (id = 'current' and public.is_dashboard_admin())
with check (id = 'current' and public.is_dashboard_admin());

insert into storage.buckets (id, name, public) values ('reportes-excel','reportes-excel',false)
on conflict (id) do nothing;
create policy "admins upload daily reports" on storage.objects for insert to authenticated
with check (bucket_id = 'reportes-excel' and public.is_dashboard_admin());
create policy "admins read daily reports" on storage.objects for select to authenticated
using (bucket_id = 'reportes-excel' and public.is_dashboard_admin());
