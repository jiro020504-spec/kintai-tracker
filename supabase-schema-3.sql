-- kintai-tracker: migration 3 -- 時間外対応 (off-hours work) records
-- Run this once in the Supabase SQL Editor
-- (https://supabase.com/dashboard/project/timytwkdfmchzojvzjzq/sql/new),
-- after supabase-schema.sql and supabase-schema-2.sql have been run.
--
-- Adds the category "時間外対応" and three columns used only by that category:
--   minutes      : worked minutes (no start/end time needed)
--   counterparty : who it was for (T&G, JE, 職人 ...)
--   method       : メール / 電話 / LINE / 打合せ / その他

alter table public.kintai_records drop constraint if exists kintai_records_category_check;

alter table public.kintai_records
  add constraint kintai_records_category_check
  check (category in ('通常出勤', '代休', '在宅対応', '休日出勤', '外出', '時間外対応'));

alter table public.kintai_records add column if not exists minutes integer not null default 0;
alter table public.kintai_records add column if not exists counterparty text not null default '';
alter table public.kintai_records add column if not exists method text not null default '';
