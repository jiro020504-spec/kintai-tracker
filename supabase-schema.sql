-- kintai-tracker: Supabase schema addition
-- Run this once in the SAME Supabase project already used by
-- acraft-dashboard's SQL Editor
-- (https://supabase.com/dashboard/project/timytwkdfmchzojvzjzq/sql/new).
--
-- This reuses the has_valid_passcode() function already created for
-- acraft-dashboard (same shared passcode, same project) -- it is NOT
-- redefined here. If that function does not exist yet in this
-- project, run acraft-dashboard's supabase-schema.sql first.

create table if not exists public.kintai_records (
  id text primary key,
  work_date date not null,
  category text not null check (category in ('通常出勤', '代休', '在宅対応', '休日出勤')),
  start_time time,
  end_time time,
  has_break boolean not null default true,
  memo text not null default '',
  tags text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists kintai_records_work_date_idx on public.kintai_records(work_date);

alter table public.kintai_records enable row level security;

drop policy if exists "passcode gate" on public.kintai_records;
create policy "passcode gate" on public.kintai_records
  for all to anon
  using (public.has_valid_passcode())
  with check (public.has_valid_passcode());

grant select, insert, update, delete on public.kintai_records to anon;
