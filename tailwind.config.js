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
