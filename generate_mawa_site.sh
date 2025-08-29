#!/usr/bin/env bash
set -euo pipefail

BASE="mawa-site"
ZIPNAME="mawa-site.zip"

echo "Creating project folder: $BASE ..."
rm -rf "$BASE" "$ZIPNAME"
mkdir -p "$BASE"

# ---------------------------
# package.json
# ---------------------------
cat > "$BASE/package.json" <<'JSON'
{
  "name": "mawa-site",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.2.4",
    "react": "18.3.1",
    "react-dom": "18.3.1",
    "@formatjs/intl-localematcher": "0.5.4",
    "negotiator": "0.6.3"
  },
  "devDependencies": {
    "@types/negotiator": "^0.6.3",
    "autoprefixer": "10.4.19",
    "postcss": "8.4.38",
    "tailwindcss": "3.4.3"
  }
}
JSON

# ---------------------------
# next.config.js
# ---------------------------
cat > "$BASE/next.config.js" <<'JS'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: { appDir: true },
  images: { unoptimized: true }
}
module.exports = nextConfig;
JS

# ---------------------------
# tailwind.config.js
# ---------------------------
cat > "$BASE/tailwind.config.js" <<'JS'
module.exports = {
  content: ["./app/**/*.{js,jsx,ts,tsx}", "./components/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        mawa: {
          bg: '#0b0f17',
          blue: '#3b82f6',
          red: '#ef4444',
          white: '#f8fafc',
          card: '#0f1626'
        }
      },
      boxShadow: {
        glow: '0 0 0 6px rgba(59,130,246,0.08), 0 20px 40px rgba(11,17,24,0.6)'
      }
    }
  },
  plugins: []
}
JS

# ---------------------------
# postcss.config.js
# ---------------------------
cat > "$BASE/postcss.config.js" <<'JS'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {}
  }
}
JS

# ---------------------------
# README.md
# ---------------------------
cat > "$BASE/README.md" <<'MD'
# MAWA — Next.js site (Complete)

Quick start (local)
1. Place your visuals in `public/`: logo.jpg, banner.jpg (optional).
2. npm install
3. npm run dev -> http://localhost:3000

Deploy to Vercel
1. Push repo to GitHub.
2. Import to Vercel, build command: npm run build
3. Deploy.

This project includes:
- Hero with countdown (13 Sep 2025 00:00 UTC), animated crocodile SVG.
- Tokenomics, Roadmap, FAQ, How-to-buy, Social links.
- i18n (fr/en/zh).
MD

# ---------------------------
# .gitignore
# ---------------------------
cat > "$BASE/.gitignore" <<'IGN'
node_modules
.next
.env.local
.DS_Store
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.vercel
IGN

# ---------------------------
# folder structure
# ---------------------------
mkdir -p "$BASE/app/[lang]" "$BASE/components" "$BASE/public" "$BASE/dictionaries"

# ---------------------------
# globals.css
# ---------------------------
cat > "$BASE/app/globals.css" <<'CSS'
@tailwind base;
@tailwind components;
@tailwind utilities;

:root{
  --mawa-bg: #0b0f17;
  --mawa-blue: #3b82f6;
  --mawa-red: #ef4444;
  --mawa-white: #f8fafc;
  --mawa-card: #0f1626;
}

html, body, #__next { height: 100%; }
body {
  @apply bg-[color:var(--mawa-bg)] text-white antialiased;
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto;
}

.card { @apply bg-[color:var(--mawa-card)] border border-white/10 rounded-2xl p-6; }
.btn-primary { @apply bg-[color:var(--mawa-blue)] text-black px-5 py-2 rounded-2xl font-semibold shadow-glow transition-transform hover:scale-105; }

.countdown {
  display: inline-grid;
  grid-auto-flow: column;
  gap: 0.5rem;
  align-items: center;
}

.countdown .unit {
  min-width: 64px;
  padding: 0.75rem 1rem;
  border-radius: 0.75rem;
  background: linear-gradient(180deg, rgba(59,130,246,0.12), rgba(239,68,68,0.06));
  color: var(--mawa-white);
  text-align: center;
  font-weight: 700;
  font-size: 1.25rem;
  box-shadow: 0 6px 18px rgba(0,0,0,0.5);
}

.croc-wiggle {
  display: inline-block;
  transform-origin: center;
  animation: wiggle 3s ease-in-out infinite;
}

@keyframes wiggle {
  0% { transform: translateY(0) rotate(0deg); }
  25% { transform: translateY(-6px) rotate(-3deg); }
  50% { transform: translateY(0) rotate(0deg); }
  75% { transform: translateY(-6px) rotate(3deg); }
  100% { transform: translateY(0) rotate(0deg); }
}

/* hero overlay gradient touches */
.hero-accent {
  background: linear-gradient(90deg, rgba(59,130,246,0.06), rgba(255,255,255,0.02), rgba(239,68,68,0.05));
  padding: 1.25rem;
  border-radius: 1rem;
}
CSS

# ---------------------------
# dictionaries (fr/en/zh)
# ---------------------------
cat > "$BASE/dictionaries/fr.json" <<'JSON'
{
  "buy_url": "https://jup.ag/swap/SOL-MAWA",
  "social": {
    "telegram": "https://t.me/mawasolana",
    "x": "https://x.com/Mawathecroco"
  },
  "nav": {
    "about": "À propos",
    "tokenomics": "Tokenomics",
    "roadmap": "Roadmap",
    "buy": "Acheter"
  },
  "hero": {
    "tag": "Mêmecoin sérieux",
    "title": "MAWA — Force, Élégance, Communauté",
    "description": "MAWA est un memecoin sur Solana avec une mascotte crocodile, branding premium et vision long terme.",
    "tokenomics_btn": "Tokenomics",
    "contract": "Contrat SPL"
  },
  "home": {
    "vision_title": "Vision",
    "vision_text": "MAWA combine culture memecoin et exécution professionnelle. Identité forte, liquidité verrouillée et tokenomics transparents.",
    "highlights_title": "Points clés",
    "supply": "Supply : 1,000,000,000",
    "lp_lock": "LP lock : 12 months",
    "tax": "Taxe : 2%"
  }
}
JSON

cat > "$BASE/dictionaries/en.json" <<'JSON'
{
  "buy_url": "https://jup.ag/swap/SOL-MAWA",
  "social": {
    "telegram": "https://t.me/mawasolana",
    "x": "https://x.com/Mawathecroco"
  },
  "nav": {
    "about": "About",
    "tokenomics": "Tokenomics",
    "roadmap": "Roadmap",
    "buy": "Buy"
  },
  "hero": {
    "tag": "The Serious Memecoin",
    "title": "MAWA — Strength, Elegance, Community",
    "description": "MAWA is a memecoin on Solana with a crocodile mascot, premium branding and a long-term vision.",
    "tokenomics_btn": "Tokenomics",
    "contract": "SPL Contract"
  },
  "home": {
    "vision_title": "Vision",
    "vision_text": "MAWA combines memecoin culture with professional execution. Strong identity, locked liquidity and transparent tokenomics.",
    "highlights_title": "Highlights",
    "supply": "Supply: 1,000,000,000",
    "lp_lock": "LP lock: 12 months",
    "tax": "Tax: 2%"
  }
}
JSON

cat > "$BASE/dictionaries/zh.json" <<'JSON'
{
  "buy_url": "https://jup.ag/swap/SOL-MAWA",
  "social": {
    "telegram": "https://t.me/mawasolana",
    "x": "https://x.com/Mawathecroco"
  },
  "nav": {
    "about": "关于",
    "tokenomics": "代币经济学",
    "roadmap": "路线图",
    "buy": "购买"
  },
  "hero": {
    "tag": "严肃的模因币",
    "title": "MAWA — 力量、优雅、社区",
    "description": "MAWA 是在 Solana 上的模因币，拥有鳄鱼吉祥物、高端品牌与长期愿景。",
    "tokenomics_btn": "代币经济学",
    "contract": "SPL 合约"
  },
  "home": {
    "vision_title": "愿景",
    "vision_text": "MAWA 将模因文化与专业执行相结合。强烈身份、流动性锁定与透明的代币经济学。",
    "highlights_title": "亮点",
    "supply": "总量：1,000,000,000",
    "lp_lock": "流动性锁定：12 个月",
    "tax": "税率：2%"
  }
}
JSON

# ---------------------------
# dictionaries index
# ---------------------------
cat > "$BASE/dictionaries/index.js" <<'JS'
import 'server-only'

const dictionaries = {
  en: () => import('./en.json').then((m) => m.default),
  fr: () => import('./fr.json').then((m) => m.default),
  zh: () => import('./zh.json').then((m) => m.default)
}
export const getDictionary = async (locale) => dictionaries[locale]() 
JS

# ---------------------------
# middleware.js for i18n redirect
# ---------------------------
cat > "$BASE/middleware.js" <<'JS'
import { match } from '@formatjs/intl-localematcher'
import Negotiator from 'negotiator'

let locales = ['fr', 'en', 'zh']
let defaultLocale = 'fr'

function getLocale(request) {
  const negotiatorHeaders = {}
  request.headers.forEach((value, key) => (negotiatorHeaders[key] = value))
  const languages = new Negotiator({ headers: negotiatorHeaders }).languages()
  return match(languages, locales, defaultLocale)
}

export function middleware(request) {
  const { pathname } = request.nextUrl
  const pathnameIsMissingLocale = locales.every(
    (locale) => !pathname.startsWith(`/${locale}/`) && pathname !== `/${locale}`
  )

  if (pathnameIsMissingLocale) {
    const locale = getLocale(request)
    return Response.redirect(
      new URL(`/${locale}${pathname.startsWith('/') ? '' : '/'}${pathname}`, request.url)
    )
  }
}

export const config = {
  matcher: ['/((?!api|_next/static|_next/image|favicon.ico|logo.jpg|banner.jpg).*)'],
}
JS

# ---------------------------
# Layout & Home (app router)
# ---------------------------
cat > "$BASE/app/[lang]/layout.jsx" <<'JSX'
import '../globals.css'
import Header from '../../components/Header'
import Footer from '../../components/Footer'
import { getDictionary } from '../../dictionaries'

export const metadata = {
  title: 'MAWA — The Serious Meme Revolution',
  description: 'MAWA — A serious memecoin with a crocodile mascot, premium branding, and a strong community.'
}

export default async function RootLayout({ children, params }) {
  const dict = await getDictionary(params.lang)
  return (
    <html lang={params.lang}>
      <body>
        <Header lang={params.lang} nav={dict.nav} buy_url={dict.buy_url} />
        <main className="min-h-screen">
          {children}
        </main>
        <Footer />
      </body>
    </html>
  )
}
JSX

cat > "$BASE/app/[lang]/page.jsx" <<'JSX'
import { getDictionary } from '../../dictionaries'
import HeroSection from '../../components/HeroSection'
import AboutSection from '../../components/AboutSection'
import RoadmapSection from '../../components/RoadmapSection'
import TokenomicsSection from '../../components/TokenomicsSection'
import FAQSection from '../../components/FAQSection'
import HowToBuySection from '../../components/HowToBuySection'
import SocialSection from '../../components/SocialSection'

export default async function Home({ params: { lang } }) {
  const dict = await getDictionary(lang)
  return (
    <div>
      <section className="section">
        <div className="container">
          <HeroSection buyUrl={dict.buy_url} lang={lang} dictHero={dict.hero} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <AboutSection dict={dict} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <HowToBuySection buyUrl={dict.buy_url} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <TokenomicsSection dict={dict.tokenomics} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <RoadmapSection dict={dict.roadmap} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <FAQSection dict={dict.faq} />
        </div>
      </section>

      <section className="section">
        <div className="container">
          <SocialSection social={dict.social} />
        </div>
      </section>
    </div>
  )
}
JSX

# ---------------------------
# Components
# ---------------------------

# Header
cat > "$BASE/components/Header.jsx" <<'JSX'
import Link from 'next/link'
import LanguageSwitcher from './LanguageSwitcher'

export default function Header({ lang, nav, buy_url }){
  return (
    <header className="w-full border-b border-white/10 bg-mawa-bg/80 backdrop-blur-sm sticky top-0 z-40">
      <div className="max-w-7xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href={`/${lang}`} className="flex items-center gap-3">
          <img src="/logo.jpg" alt="MAWA Logo" className="w-10 h-10 rounded-full"/>
          <span className="font-semibold text-xl">MAWA</span>
        </Link>

        <nav className="hidden md:flex gap-6 items-center text-sm">
          <Link href={`/${lang}/about`}>{nav.about}</Link>
          <Link href={`/${lang}/tokenomics`}>{nav.tokenomics}</Link>
          <Link href={`/${lang}/roadmap`}>{nav.roadmap}</Link>
          <a className="btn-primary" href={buy_url} target="_blank" rel="noopener noreferrer">{nav.buy}</a>
          <LanguageSwitcher currentLang={lang} />
        </nav>
        <div className="md:hidden">
          <LanguageSwitcher currentLang={lang} />
        </div>
      </div>
    </header>
  )
}
JSX

# Footer
cat > "$BASE/components/Footer.jsx" <<'JSX'
export default function Footer(){
  return (
    <footer className="w-full border-t border-white/10 mt-12">
      <div className="max-w-7xl mx-auto px-6 py-8 flex flex-col md:flex-row items-center justify-between gap-4 text-sm text-white/70">
        <div>© {new Date().getFullYear()} MAWA — Not financial advice</div>
        <div className="flex gap-4">
          <a href="https://x.com/Mawathecroco" target="_blank" rel="noreferrer" className="hover:underline">X / Twitter</a>
          <a href="https://t.me/mawasolana" target="_blank" rel="noreferrer" className="hover:underline">Telegram</a>
          <a href="#" className="hover:underline">Discord</a>
        </div>
      </div>
    </footer>
  )
}
JSX

# LanguageSwitcher
cat > "$BASE/components/LanguageSwitcher.jsx" <<'JSX'
import Link from 'next/link'

export default function LanguageSwitcher({ currentLang }) {
  const languages = [
    { code: 'fr', name: '🇫🇷' },
    { code: 'en', name: '🇬🇧' },
    { code: 'zh', name: '🇨🇳' },
  ]

  return (
    <div className="flex items-center gap-2 bg-mawa-card border border-white/10 rounded-full p-1">
      {languages.map((lang) => (
        <Link
          key={lang.code}
          href={`/${lang.code}`}
          className={`w-8 h-8 rounded-full grid place-items-center text-sm transition-colors ${
            currentLang === lang.code ? 'bg-mawa-blue text-black font-semibold' : 'hover:bg-white/10'
          }`}
        >
          {lang.name}
        </Link>
      ))}
    </div>
  )
}
JSX

# Countdown component (client)
cat > "$BASE/components/Countdown.jsx" <<'JSX'
'use client'
import { useEffect, useState } from 'react'

export default function Countdown({ targetISO }) {
  const target = new Date(targetISO).getTime()
  const [now, setNow] = useState(Date.now())
  useEffect(() => {
    const t = setInterval(()=> setNow(Date.now()), 1000)
    return () => clearInterval(t)
  }, [])

  const diff = Math.max(0, target - now)
  const sec = Math.floor((diff/1000)%60)
  const min = Math.floor((diff/1000/60)%60)
  const hr = Math.floor((diff/1000/60/60)%24)
  const days = Math.floor(diff/1000/60/60/24)

  const pad = (n) => String(n).padStart(2,'0')

  return (
    <div className="mt-6 hero-accent rounded-xl inline-flex items-center gap-4">
      <div className="countdown">
        <div className="unit">
          <div className="text-xs text-white/70">DAYS</div>
          <div className="text-2xl">{pad(days)}</div>
        </div>
        <div className="unit">
          <div className="text-xs text-white/70">HRS</div>
          <div className="text-2xl">{pad(hr)}</div>
        </div>
        <div className="unit">
          <div className="text-xs text-white/70">MINS</div>
          <div className="text-2xl">{pad(min)}</div>
        </div>
        <div className="unit">
          <div className="text-xs text-white/70">SECS</div>
          <div className="text-2xl">{pad(sec)}</div>
        </div>
      </div>
    </div>
  )
}
JSX

# HeroSection (uses Countdown and crocodile SVG)
cat > "$BASE/components/HeroSection.jsx" <<'JSX'
'use client'
import Link from 'next/link'
import Countdown from './Countdown'

export default function HeroSection({ buyUrl, lang, dictHero }) {
  // target: 13 September 2025 00:00:00 UTC
  const targetISO = '2025-09-13T00:00:00Z'

  return (
    <section id="hero" className="grid lg:grid-cols-5 gap-8 items-center">
      <div className="lg:col-span-3">
        <div className="inline-flex items-center gap-3 px-3 py-1 rounded-full bg-white/5 text-xs">Mêmecoin sérieux</div>
        <h1 className="mt-6 text-4xl md:text-6xl font-extrabold leading-tight">
          MAWA — <span className="text-[color:var(--mawa-blue)]">Force</span>, <span className="text-[color:var(--mawa-white)]">Élégance</span>, <span className="text-[color:var(--mawa-red)]">Communauté</span>
        </h1>
        <p className="mt-4 text-white/80 max-w-xl">{dictHero?.description ?? 'MAWA — A serious memecoin with a crocodile mascot.'}</p>

        <div className="mt-6 flex gap-3">
          <a href={buyUrl} target="_blank" rel="noreferrer" className="btn-primary">Acheter sur Jupiter</a>
          <Link href={`/${lang}/tokenomics`} className="px-5 py-2 rounded-2xl border border-white/10">Tokenomics</Link>
        </div>

        {/* Countdown */}
        <div>
          <Countdown targetISO={targetISO} />
        </div>

        <div className="mt-4 text-xs text-white/60">Contrat SPL : <span className="font-mono bg-white/5 px-2 py-1 rounded">SOON...</span></div>
      </div>

      <div className="lg:col-span-2 flex justify-center lg:justify-end">
        <div className="w-full max-w-sm">
          {/* Crocodile SVG (animated wiggle) */}
          <div className="grid place-items-center">
            <svg className="croc-wiggle w-72 h-48" viewBox="0 0 240 140" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="MAWA Crocodile">
              <defs>
                <linearGradient id="g1" x1="0" x2="1">
                  <stop offset="0%" stopColor="#3b82f6"/>
                  <stop offset="50%" stopColor="#ffffff"/>
                  <stop offset="100%" stopColor="#ef4444"/>
                </linearGradient>
              </defs>
              <rect width="100%" height="100%" rx="12" fill="none"/>
              <!-- simple stylized crocodile head (respectful & premium) -->
              <g transform="translate(20,20)">
                <ellipse cx="90" cy="45" rx="78" ry="36" fill="#0b7a3b"/>
                <ellipse cx="120" cy="30" rx="26" ry="14" fill="#1f9a4a"/>
                <rect x="24" y="38" width="120" height="12" rx="6" fill="#0b6b34"/>
                <circle cx="140" cy="20" r="6" fill="#fff"/>
                <circle cx="140" cy="20" r="2.8" fill="#0f1724"/>
                {/* belt plate */}
                <rect x="60" y="64" width="40" height="10" rx="3" fill="url(#g1)"/>
                <text x="80" y="72" fontSize="7" textAnchor="middle" fill="#041422" fontWeight="700">MAWA</text>
              </g>
            </svg>
          </div>
        </div>
      </div>
    </section>
  )
}
JSX

# AboutSection
cat > "$BASE/components/AboutSection.jsx" <<'JSX'
export default function AboutSection({ dict }) {
  return (
    <section id="about" className="py-16 bg-transparent text-white">
      <div className="text-center max-w-3xl mx-auto">
        <h2 className="text-3xl font-bold mb-4">{dict?.home?.vision_title ?? 'Vision'}</h2>
        <p className="text-white/80">{dict?.home?.vision_text ?? 'MAWA combines memecoin culture with execution.'}</p>
      </div>
    </section>
  )
}
JSX

# HowToBuySection
cat > "$BASE/components/HowToBuySection.jsx" <<'JSX'
export default function HowToBuySection({ buyUrl }) {
  return (
    <section id="howtobuy">
      <div className="card">
        <h3 className="text-xl font-semibold">How to buy</h3>
        <ol className="mt-3 list-decimal pl-5 text-white/80">
          <li>Install a Solana wallet (Phantom).</li>
          <li>Get SOL and connect to Jupiter.</li>
          <li>Swap SOL for MAWA on Jupiter: <a href={buyUrl} target="_blank" rel="noreferrer" className="underline">Buy on Jupiter</a>.</li>
        </ol>
      </div>
    </section>
  )
}
JSX

# TokenomicsSection
cat > "$BASE/components/TokenomicsSection.jsx" <<'JSX'
export default function TokenomicsSection({ dict }) {
  const distribution = dict?.distribution ?? [
    {label:'Liquidity (DEX)', value:'78%'},
    {label:'Vested', value:'2%'},
    {label:'Migrating supply', value:'20%'}
  ]
  const params = dict?.parameters ?? { supply:'1,000,000,000', decimals:'9', mint_authority:'renounced', lp_lock:'12 months', tax:'2%' }
  return (
    <section id="tokenomics">
      <h2 className="text-3xl font-bold mb-6">{dict?.title ?? 'Tokenomics'}</h2>
      <div className="grid md:grid-cols-2 gap-6">
        <div className="card">
          <h4 className="font-semibold mb-3">Distribution</h4>
          <ul className="text-white/80 space-y-2">
            {distribution.map((d, i) => (
              <li key={i} className="flex justify-between"><span>{d.label}</span><span>{d.value}</span></li>
            ))}
          </ul>
        </div>
        <div className="card">
          <h4 className="font-semibold mb-3">MAWA token parameters</h4>
          <ul className="text-white/80 space-y-2">
            <li>Supply: {params.supply}</li>
            <li>Decimals: {params.decimals}</li>
            <li>Mint authority: {params.mint_authority}</li>
            <li>LP lock: {params.lp_lock}</li>
            <li>Tax: {params.tax}</li>
          </ul>
        </div>
      </div>
    </section>
  )
}
JSX

# RoadmapSection
cat > "$BASE/components/RoadmapSection.jsx" <<'JSX'
export default function RoadmapSection({ dict }) {
  const phases = dict?.phases ?? [
    {phase:'Phase 1: Foundation', status:'COMPLETED', desc:'Premium branding, site launched, initial community.'},
    {phase:'Phase 2: Community Growth', status:'IN PROGRESS', desc:'Social expansion, engagement.'},
    {phase:'Phase 3: Jupiter Launch', status:'PLANNED', date:'2025-09-13', desc:'Official launch on Jupiter, initial liquidity.'},
    {phase:'Phase 4: DEX Expansion', status:'PLANNED', desc:'Listings on major Solana DEXs.'},
    {phase:'Phase 5: CEX Listings', status:'PLANNED', desc:'Centralized exchange listings.'},
    {phase:'Phase 6: Ecosystem Development', status:'PLANNED', desc:'Merch, NFTs, rewards.'}
  ]
  return (
    <section id="roadmap">
      <h2 className="text-3xl font-bold mb-6">{dict?.title ?? 'The MAWA Journey'}</h2>
      <div className="space-y-6">
        {phases.map((p, i)=>(
          <div key={i} className="card">
            <div className="flex items-center justify-between">
              <h4 className="font-semibold">{p.phase}</h4>
              <div className="text-sm text-white/70">{p.status}{p.date ? ` • ${p.date}` : ''}</div>
            </div>
            <p className="mt-2 text-white/80">{p.desc}</p>
          </div>
        ))}
      </div>
    </section>
  )
}
JSX

# FAQSection
cat > "$BASE/components/FAQSection.jsx" <<'JSX'
export default function FAQSection({ dict }) {
  const items = dict?.items ?? [
    {q:'Why choose MAWA?', a:'MAWA stands out with premium branding, long-term vision, locked liquidity (12 months) and transparent tokenomics.'},
    {q:'Why a crocodile?', a:'Crocodiles symbolize resilience, patience and strength.'},
    {q:'When is launch?', a:'Official launch planned for 13 September 2025. Follow socials for exact timing.'},
    {q:'Is liquidity locked?', a:'Yes — locked for 12 months with verifiable on-chain lock.'},
    {q:'How to join?', a:'Join us on X/Twitter and Telegram.'},
    {q:'Tokenomics & fees?', a:'Supply 1,000,000,000. Distribution: Liquidity 78%, Vested 2%, Migrating supply 20%. Tax: 2%.'}
  ]
  return (
    <section id="faq">
      <h2 className="text-3xl font-bold mb-6">{dict?.title ?? 'FAQ'}</h2>
      <div className="grid gap-4">
        {items.map((it, idx)=>(
          <details key={idx} className="card">
            <summary className="font-semibold cursor-pointer">{it.q}</summary>
            <p className="mt-2 text-white/80">{it.a}</p>
          </details>
        ))}
      </div>
    </section>
  )
}
JSX

# SocialSection
cat > "$BASE/components/SocialSection.jsx" <<'JSX'
export default function SocialSection({ social }) {
  return (
    <section id="social">
      <div className="card text-center">
        <h3 className="text-xl font-semibold mb-3">Join the community</h3>
        <div className="flex items-center justify-center gap-4">
          <a href={social?.x ?? '#'} target="_blank" rel="noreferrer" className="px-4 py-2 rounded bg-white/5">X / Twitter</a>
          <a href={social?.telegram ?? '#'} target="_blank" rel="noreferrer" className="px-4 py-2 rounded bg-white/5">Telegram</a>
        </div>
      </div>
    </section>
  )
}
JSX

# ---------------------------
# public placeholders
# ---------------------------
cat > "$BASE/public/placeholder.txt" <<'TXT'
Place your assets in this folder:
- logo.jpg : site logo (round)
- banner.jpg : hero/banner visual
You can replace placeholder assets with real images.
TXT

# small favicon svg
cat > "$BASE/public/favicon.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64">
  <defs><linearGradient id="g" x1="0" x2="1"><stop offset="0" stop-color="#3b82f6"/><stop offset="1" stop-color="#ef4444"/></linearGradient></defs>
  <rect width="64" height="64" rx="12" fill="#0b0f17"/>
  <text x="32" y="40" font-size="22" text-anchor="middle" fill="url(#g)" font-family="Inter, system-ui">M</text>
</svg>
SVG

# ---------------------------
# finish & zip
# ---------------------------
echo "Creating zip archive $ZIPNAME ..."
cd "$BASE"
zip -r "../$ZIPNAME" . > /dev/null
cd ..

echo "Done. Project created: $BASE and archive $ZIPNAME"
echo ""
echo "Next steps:"
echo "1) cd $BASE"
echo "2) npm install"
echo "3) npm run dev"
echo ""
echo "Notes: - Place your logo.jpg / banner.jpg in public/ before deploying for full visuals."

# ---------- continue script: finish components, public svgs, zip ----------
# (append to the script you've already started)

# Overwrite HeroSection with improved multilingual & safe logic
cat > "$BASE/components/HeroSection.jsx" <<'JSX'
'use client'
import Link from 'next/link'
import Countdown from './Countdown'

export default function HeroSection({ buyUrl, lang = 'fr', dictHero = {}, banner = '/banner.svg' }) {
  // target: 13 September 2025 00:00:00 UTC
  const targetISO = '2025-09-13T00:00:00Z'

  // allow title as array or string (safe)
  const rawTitle = dictHero?.title ?? (typeof dictHero === 'string' ? dictHero : null)
  let titleParts = []
  if (Array.isArray(dictHero?.title)) titleParts = dictHero.title
  else if (typeof rawTitle === 'string') titleParts = rawTitle.split(',').map(s => s.trim())
  else if (typeof dictHero === 'string') titleParts = String(dictHero).split(',').map(s => s.trim())
  else titleParts = ['Force','Élégance','Communauté']

  // colors mapping (use CSS variables from globals)
  const colors = dictHero?.colors ?? ['--mawa-blue','--mawa-white','--mawa-red']

  const renderColoredTitle = () => (
    <>
      {titleParts.map((word, i) => (
        <span key={i} style={{ color: `var(${colors[i] || colors[i%colors.length]})` }}>
          {word}{i < titleParts.length - 1 ? ', ' : ''}
        </span>
      ))}
    </>
  )

  return (
    <section id="hero" className="grid lg:grid-cols-5 gap-8 items-center py-8">
      <div className="lg:col-span-3">
        <div className="inline-flex items-center gap-3 px-3 py-1 rounded-full bg-white/5 text-xs">
          {dictHero?.tag ?? 'Mêmecoin sérieux'}
        </div>

        <h1 className="mt-6 text-4xl md:text-6xl font-extrabold leading-tight text-white">
          MAWA — {renderColoredTitle()}
        </h1>

        <p className="mt-4 text-white/80 max-w-xl">
          {dictHero?.description ?? 'MAWA — A serious memecoin with a crocodile mascot.'}
        </p>

        <div className="mt-6 flex gap-3">
          {buyUrl && (
            <a href={buyUrl} target="_blank" rel="noreferrer" className="btn-primary">
              {dictHero?.buy_button ?? (lang === 'fr' ? 'Acheter sur Jupiter' : dictHero?.buy_button ?? 'Buy on Jupiter')}
            </a>
          )}
          <Link href={`/${lang}/tokenomics`} className="px-5 py-2 rounded-2xl border border-white/10">
            {dictHero?.tokenomics_btn ?? (lang === 'fr' ? 'Tokenomics' : 'Tokenomics')}
          </Link>
        </div>

        <div className="mt-6">
          <Countdown targetISO={targetISO} />
        </div>

        <div className="mt-4 text-xs text-white/60">
          {dictHero?.contract_label ?? (lang === 'fr' ? 'Contrat SPL' : 'SPL Contract')} :{' '}
          <span className="font-mono bg-white/5 px-2 py-1 rounded">{dictHero?.contract_value ?? 'SOON...'}</span>
        </div>
      </div>

      <div className="lg:col-span-2 flex justify-center lg:justify-end">
        <div className="w-full max-w-sm grid place-items-center">
          {banner ? (
            <img src={banner} alt={dictHero?.banner ?? 'Bannière MAWA'} className="w-full h-auto rounded-lg shadow-lg" />
          ) : null}
        </div>
      </div>
    </section>
  )
}
JSX

# TokenomicsSection
cat > "$BASE/components/TokenomicsSection.jsx" <<'JSX'
export default function TokenomicsSection({ dict = {} }) {
  // Accept dict.tokenomics or fallback to dict.home fields
  const t = dict || {}
  const params = t.params || t || {}
  const percentages = t.percentages || { liquidity: '78%', vested: '2%', migrating: '20%' }

  return (
    <section id="tokenomics" className="py-16">
      <div className="max-w-4xl mx-auto text-white">
        <h2 className="text-3xl font-bold mb-6">{t.title ?? 'Tokenomics'}</h2>

        <div className="grid md:grid-cols-2 gap-6">
          <div className="card">
            <h3 className="font-semibold">Distribution</h3>
            <ul className="mt-4 text-white/80 space-y-2">
              <li>Liquidity (DEX): <strong>{percentages.liquidity}</strong></li>
              <li>Vested: <strong>{percentages.vested}</strong></li>
              <li>Migrating supply: <strong>{percentages.migrating}</strong></li>
            </ul>
          </div>

          <div className="card">
            <h3 className="font-semibold">{t.params_title ?? 'MAWA token parameters'}</h3>
            <ul className="mt-4 text-white/80 space-y-2">
              <li>{params.supply ?? 'Supply: 1,000,000,000'}</li>
              <li>{params.decimals ?? 'Decimals: 9'}</li>
              <li>{params.mint ?? 'Mint authority: renounced'}</li>
              <li>{params.lock ?? 'LP lock: 12 months'}</li>
              <li>{params.tax ?? 'Tax: 2%'}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>
  )
}
JSX

# RoadmapSection
cat > "$BASE/components/RoadmapSection.jsx" <<'JSX'
export default function RoadmapSection({ dict = {} }) {
  const roadmap = dict?.phases || {
    1: { title: 'Phase 1: Foundation', status: 'COMPLETED', desc: 'Premium branding, site launched, initial community.' },
    2: { title: 'Phase 2: Community Growth', status: 'IN PROGRESS', desc: 'Social expansion, engagement.' },
    3: { title: 'Phase 3: Jupiter Launch', status: 'PLANNED • 2025-09-13', desc: 'Official launch on Jupiter, initial liquidity.' },
    4: { title: 'Phase 4: DEX Expansion', status: 'PLANNED', desc: 'Listings on major Solana DEXs.' },
    5: { title: 'Phase 5: CEX Listings', status: 'PLANNED', desc: 'Centralized exchange listings.' },
    6: { title: 'Phase 6: Ecosystem Development', status: 'PLANNED', desc: 'Merch, NFTs, rewards.' }
  }

  return (
    <section id="roadmap" className="py-16">
      <div className="max-w-5xl mx-auto text-white">
        <h2 className="text-3xl font-bold mb-6">{dict?.title ?? 'The MAWA Journey'}</h2>
        <div className="space-y-6">
          {Object.keys(roadmap).map((k) => {
            const p = roadmap[k]
            return (
              <div key={k} className="card">
                <div className="flex items-center justify-between">
                  <div>
                    <h3 className="font-semibold">{p.title}</h3>
                    <p className="text-sm text-white/70">{p.desc}</p>
                  </div>
                  <div className="text-sm font-bold text-white/80">{p.status}</div>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </section>
  )
}
JSX

# FAQSection
cat > "$BASE/components/FAQSection.jsx" <<'JSX'
export default function FAQSection({ dict = {} }) {
  const items = dict?.items || [
    { q: 'Why choose MAWA?', a: 'MAWA stands out with premium branding, long-term vision, locked liquidity (12 months) and transparent tokenomics.' },
    { q: 'Why a crocodile?', a: 'Crocodiles symbolize resilience, patience and strength.' },
    { q: 'When is launch?', a: 'Official launch planned for 13 September 2025. Follow socials for exact timing.' },
    { q: 'Is liquidity locked?', a: 'Yes — locked for 12 months with verifiable on-chain lock.' },
    { q: 'How to join?', a: 'Join us on X/Twitter and Telegram.' },
    { q: 'Tokenomics & fees?', a: 'Supply 1,000,000,000. Distribution: Liquidity 78%, Vested 2%, Migrating supply 20%. Tax: 2%.' }
  ]

  return (
    <section id="faq" className="py-16">
      <div className="max-w-4xl mx-auto text-white">
        <h2 className="text-3xl font-bold mb-6">{dict?.title ?? 'FAQ'}</h2>
        <div className="space-y-4">
          {items.map((it, idx) => (
            <details key={idx} className="card">
              <summary className="font-semibold cursor-pointer">{it.q}</summary>
              <div className="mt-2 text-white/80">{it.a}</div>
            </details>
          ))}
        </div>
      </div>
    </section>
  )
}
JSX

# SocialSection
cat > "$BASE/components/SocialSection.jsx" <<'JSX'
export default function SocialSection({ social = {} }) {
  return (
    <section id="social" className="py-12">
      <div className="max-w-4xl mx-auto text-white text-center">
        <h3 className="text-xl font-semibold mb-4">Join the community</h3>
        <div className="flex justify-center gap-6">
          <a href={social.x ?? 'https://x.com'} target="_blank" rel="noreferrer" className="hover:underline">X / Twitter</a>
          <a href={social.telegram ?? 'https://t.me'} target="_blank" rel="noreferrer" className="hover:underline">Telegram</a>
        </div>
      </div>
    </section>
  )
}
JSX

# ---------------------------
# public small svg placeholders (logo, banner, favicon)
# ---------------------------
cat > "$BASE/public/logo.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="256" height="256" viewBox="0 0 100 100">
  <rect width="100" height="100" rx="16" fill="#0b7a3b"/>
  <text x="50" y="57" font-size="30" font-family="Arial" fill="#fff" text-anchor="middle">MA</text>
</svg>
SVG

cat > "$BASE/public/banner.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="400" viewBox="0 0 1200 400">
  <defs>
    <linearGradient id="g" x1="0" x2="1">
      <stop offset="0" stop-color="#3b82f6"/>
      <stop offset="0.5" stop-color="#fff"/>
      <stop offset="1" stop-color="#ef4444"/>
    </linearGradient>
  </defs>
  <rect width="1200" height="400" rx="20" fill="url(#g)"/>
  <text x="600" y="220" font-size="48" font-family="Arial" fill="#041422" text-anchor="middle">MAWA — Banner</text>
</svg>
SVG

cat > "$BASE/public/favicon.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"><rect width="16" height="16" rx="3" fill="#3b82f6"/><text x="8" y="11" font-size="9" font-family="Arial" fill="#fff" text-anchor="middle">M</text></svg>
SVG

# Create a minimal app/head to include favicon
mkdir -p "$BASE/app/[lang]"
cat > "$BASE/app/[lang]/head.jsx" <<'JSX'
export default function Head() {
  return (
    <>
      <meta charSet="utf-8" />
      <meta name="viewport" content="width=device-width,initial-scale=1" />
      <link rel="icon" href="/favicon.svg" />
    </>
  )
}
JSX

# ---------------------------
# finish: zip the project
# ---------------------------
cd "$BASE"
zip -r "../$ZIPNAME" . > /dev/null
cd ..

echo "Done. Project created in '$BASE' and zipped as '$ZIPNAME'."
echo "Next steps:"
echo "  cd $BASE"
echo "  npm install"
echo "  npx next dev"
echo ""
echo "Replace public/banner.svg and public/logo.svg with your real images (banner.jpg, logo.jpg) if available."
