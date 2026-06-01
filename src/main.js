import { createApp } from 'vue'
import PrimeVue from 'primevue/config'
import { definePreset } from '@primeuix/themes'
import Aura from '@primeuix/themes/aura'
import 'primeicons/primeicons.css'
import App from './App.vue'

// WTA brand palette — CW Blue primary, DM Sans, WTA surface/text greys
const WTAPreset = definePreset(Aura, {
  primitive: {
    green: {
      50:  '#f0fdf6',
      100: '#dcfcea',
      200: '#b7f5d1',
      300: '#7ae8ab',
      400: '#3dd37e',
      500: '#18794E',
      600: '#146642',
      700: '#105335',
      800: '#0c4028',
      900: '#082d1c',
      950: '#041a10'
    },
    orange: {
      50:  '#fffbeb',
      100: '#fef3c7',
      200: '#fde68a',
      300: '#fcd34d',
      400: '#fbbf24',
      500: '#c97a00',
      600: '#a86500',
      700: '#875000',
      800: '#663d00',
      900: '#4a2c00',
      950: '#2d1a00'
    },
    red: {
      50:  '#fff1f2',
      100: '#ffe4e5',
      200: '#fecdd0',
      300: '#fda4a8',
      400: '#fb7177',
      500: '#CE2C31',
      600: '#aa2429',
      700: '#881c20',
      800: '#661519',
      900: '#450e11',
      950: '#280709'
    }
  },
  semantic: {
    primary: {
      50:  '#f0eeff',
      100: '#e0ddff',
      200: '#c1bbff',
      300: '#9b93ff',
      400: '#7870f0',
      500: '#4D49E4',
      600: '#371EE1',
      700: '#2d17b8',
      800: '#1D1765',
      900: '#160f4e',
      950: '#0D0A2F'
    },
    colorScheme: {
      light: {
        primary: {
          color: '#371EE1',
          hoverColor: '#2d17b8',
          activeColor: '#1D1765',
          contrastColor: '#ffffff'
        },
        surface: {
          0:   '#ffffff',
          50:  '#FBFCFD',
          100: '#F8F9FA',
          200: '#DEE2E6',
          300: '#CED4DA',
          400: '#ADB5BD',
          500: '#6C757D',
          600: '#495057',
          700: '#343A40',
          800: '#212529',
          900: '#121618',
          950: '#0a0c0d'
        },
        highlight: {
          background: '#EDF1FF',
          focusBackground: '#e0ddff',
          color: '#371EE1',
          focusColor: '#2d17b8'
        }
      }
    }
  }
})

const app = createApp(App)

app.use(PrimeVue, {
  theme: {
    preset: WTAPreset,
    options: {
      darkModeSelector: '.dark-mode'
    }
  }
})

app.mount('#app')
