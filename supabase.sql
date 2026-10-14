-- Run once in Supabase Dashboard > SQL Editor.
-- Private bucket; each user can only touch files under their own <user-id>/ folder.
insert into storage.buckets (id, name, public) values ('graphite-files','graphite-files',false)
on conflict (id) do nothing;

create policy "graphite own select" on storage.objects for select to authenticated
  using (bucket_id='graphite-files' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "graphite own insert" on storage.objects for insert to authenticated
  with check (bucket_id='graphite-files' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "graphite own update" on storage.objects for update to authenticated
  using (bucket_id='graphite-files' and (storage.foldername(name))[1]=auth.uid()::text);
create policy "graphite own delete" on storage.objects for delete to authenticated
  using (bucket_id='graphite-files' and (storage.foldername(name))[1]=auth.uid()::text);
