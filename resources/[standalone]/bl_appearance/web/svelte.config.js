

import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import postcss from './postcss.config.js';
import { resolve } from 'path';

export default defineConfig({
    css: {
        postcss,
    },
    plugins: [
        svelte({
            compilerOptions: {
                dev: false,   // No HMR in build mode
            },
            hot: false,       // Force disable old HMR flag
        })
    ],

    base: './',

    resolve: {
        alias: {
            '@assets': resolve("./src/assets"),
            '@components': resolve("./src/components"),
            '@providers': resolve("./src/providers"),
            '@stores': resolve("./src/stores"),
            '@utils': resolve("./src/utils"),
            '@typings': resolve("./src/typings"),
            '@enums': resolve('./src/enums'),
            '@lib': resolve('./src/lib'),
        },
    },

    server: {
        hmr: false,     // Important — FiveM does NOT support HMR
        port: 3000,
    },

    build: {
        emptyOutDir: true,
        outDir: '../build',
        assetsDir: './',

        rollupOptions: {
            output: {
                entryFileNames: `[name].js`,
                chunkFileNames: `[name].js`,
                assetFileNames: `[name].[ext]`,
            },
        },
    },
});
