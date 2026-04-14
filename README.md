# Chromebook Cart Reservations

Faculty-facing reservation tool for Brookwood's four Chromebook carts (5-1, 5-2, 6-1, 6-2).
Auto-advances each week — no manual updates needed. Persists all reservations to Supabase.

---

## One-time Setup

### 1. Supabase — create the table

1. Go to your **brookwood-dashboard** Supabase project
2. Open **SQL Editor → New query**
3. Paste the contents of `supabase-setup.sql` and click **Run**
4. Confirm the `cart_reservations` table appears in **Table Editor**

### 2. Get your Supabase credentials

In your Supabase project:
- Go to **Settings → API**
- Copy **Project URL** (looks like `https://xxxx.supabase.co`)
- Copy **anon / public** key (long JWT string)

### 3. Add credentials to index.html

Open `index.html` and find the `CONFIG` block near the bottom:

```javascript
const CONFIG = {
  supabaseUrl: 'YOUR_SUPABASE_URL',    // ← replace this
  supabaseKey: 'YOUR_SUPABASE_ANON_KEY', // ← replace this
};
```

### 4. Update the period schedule

In the same file, find the `PERIODS` array and update the times to match
Brookwood's actual schedule. The `id` values (`p1`–`p8`) don't need to change.

### 5. Push to GitHub

```bash
git init
git add .
git commit -m "Initial Chromebook cart reservations app"
git remote add origin https://github.com/YOUR_ORG/chromebook-carts.git
git push -u origin main
```

### 6. Deploy to Vercel

1. Go to [vercel.com](https://vercel.com) → **Add New Project**
2. Import your GitHub repo
3. Vercel auto-detects this as a static site — no build settings needed
4. Click **Deploy**
5. (Optional) Add a custom domain or share the `.vercel.app` URL in your faculty portal

Every future `git push` auto-deploys — no manual steps.

---

## Updating the period schedule

Edit the `PERIODS` array in `index.html`, commit, and push. Vercel redeploys in ~30 seconds.

## Viewing all reservations

In your Supabase dashboard → **Table Editor → cart_reservations** — full history of every reservation ever made, sortable and filterable.

---

## Stack

| Layer    | Service              | Why                              |
|----------|----------------------|----------------------------------|
| Frontend | Static HTML + JS     | No build step, easy to maintain  |
| Database | Supabase (Postgres)  | Free tier, real-time, your org   |
| Hosting  | Vercel               | Auto-deploys from GitHub         |
