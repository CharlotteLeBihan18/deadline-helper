-- Deadline Bot database (Supabase / PostgreSQL)

create table public.deadlines (
  id          bigint generated always as identity not null,
  course      text not null default 'Unknown course',
  title       text not null,
  due_at      timestamp with time zone not null,
  source      text not null default 'text',      -- text, photo, pdf or web
  added_by    text null,
  conflict    boolean not null default false,    -- another date was already saved for this deadline
  reminded    boolean not null default false,
  created_at  timestamp with time zone not null default now(),
  constraint deadlines_pkey primary key (id)
);

create index if not exists deadlines_due_at_idx on public.deadlines using btree (due_at);

create table public.subscribers (
  chat_id      bigint not null,                   -- Telegram chat id
  first_name   text null,
  created_at   timestamp with time zone not null default now(),
  remind_hour  integer not null default 8,        -- 0 to 23, Paris time
  remind_plan  text not null default 'normal',    -- chill, normal, planner, early, intense, countdown or off
  constraint subscribers_pkey primary key (chat_id)
);
