import { defineConfig } from 'vite';
import { svelte } from '@sveltejs/vite-plugin-svelte';
import postcss from './postcss.config.js';
import { resolve } from "path";

export default defineConfig({
    css: {
        postcss,
    },

    plugins: [
        svelte({
            hot: false,                // 🔥 FULL FIX FOR HMR ERROR
            compilerOptions: {
                dev: false            // Disable dev-only flags for production build
            }
        })
    ],

    base: './', // required for FiveM NUI

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
                assetFileNames: `[name].[ext]`
            }
        }
    }
});
