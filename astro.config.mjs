// @ts-check
import { defineConfig } from 'astro/config';

const isProd = process.env.NODE_ENV === 'production';

// https://astro.build/config
export default defineConfig({
  site: 'https://blackbird014.github.io',
  base: isProd ? '/my-cv-site' : '',
});
