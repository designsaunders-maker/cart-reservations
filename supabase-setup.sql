-- ============================================================
--  Chromebook Cart Reservations — Supabase Setup
--  Run this in your Supabase SQL Editor
--  (SQL Editor → New query → paste → Run)
-- ============================================================

CREATE TABLE IF NOT EXISTS cart_reservations (
  id               uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  cart_name        text        NOT NULL,          -- '5-1', '5-2', '6-1', '6-2'
  reservation_date date        NOT NULL,
  period_id        text        NOT NULL,          -- 'p1' through 'p8'
  period_label     text        NOT NULL,          -- 'Period 1', etc.
  period_time      text        NOT NULL,          -- '8:00–8:45', etc.
  reserved_by      text        NOT NULL,
  created_at       timestamptz DEFAULT now()
);

-- Prevent double-booking: one reservation per cart/date/period
ALTER TABLE cart_reservations
  ADD CONSTRAINT unique_cart_slot
  UNIQUE (cart_name, reservation_date, period_id);

-- Row Level Security (allows browser access without login)
ALTER TABLE cart_reservations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can read reservations"
  ON cart_reservations FOR SELECT USING (true);

CREATE POLICY "Public can create reservations"
  ON cart_reservations FOR INSERT WITH CHECK (true);

CREATE POLICY "Public can cancel reservations"
  ON cart_reservations FOR DELETE USING (true);

-- Optional: index for fast weekly lookups
CREATE INDEX idx_cart_reservations_lookup
  ON cart_reservations (cart_name, reservation_date);

-- ============================================================
--  Verification — run after the above to confirm setup
-- ============================================================
-- SELECT * FROM cart_reservations LIMIT 5;
