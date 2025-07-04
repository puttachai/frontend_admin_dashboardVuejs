/** @type {import('tailwindcss').Config} */
export default {
    content: [
      "./index.html",
      "./src/**/*.{vue,js,ts,jsx,tsx}"
    ],
    theme: {
      extend: {
        fontFamily: {
          josefin: ['"Josefin Sans"', 'sans-serif'],
        },
        screens: {
          xs: "320px",
          sm: "375px",
          smls: "430px",
          sml: "500px",
          md: "667px",
          mdl: "768px",
          lg: "960px",
          lgl: "1024px",
          xl: "1280px",
        },
      },
    },
    plugins: [],
  }
  