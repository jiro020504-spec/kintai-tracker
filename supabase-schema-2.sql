-- kintai-tracker: migration 2 -- add "外出" as a valid category
-- Run this once in the Supabase SQL Editor
-- (https://supabase.com/dashboard/project/timytwkdfmchzojvzjzq/sql/new),
-- after supabase-schema.sql has already been run.

alter table public.kintai_records drop constraint if exists kintai_records_category_check;

alter table public.kintai_records
  add constraint kintai_records_category_check
  check (category in ('通常出勤', '代休', '在宅対応', '休日出勤', '外出'));
