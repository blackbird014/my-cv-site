// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://blackbird014.github.io',
  base: '/my-cv-site',
  outDir: './dist',
  build: {
    format: 'file'
  }
});
