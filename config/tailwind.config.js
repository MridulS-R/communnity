module.exports = {
  darkMode: 'class',
  content: [
    "./app/views/**/*.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js"
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          50:  '#eef4ff',
          100: '#d9e6ff',
          200: '#b3ccff',
          300: '#8db2ff',
          400: '#5c8cff',
          500: '#2a66ff',
          600: '#0b5fff',
          700: '#084bcc',
          800: '#063999',
          900: '#042566'
        }
      },
      fontFamily: {
        sans: ["Inter", "ui-sans-serif", "system-ui", "-apple-system", "Segoe UI", "Roboto", "Helvetica Neue", "Arial", "Noto Sans", "sans-serif"]
      }
    }
  },
  plugins: []
}
