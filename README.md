# dactyl-cc-zmk
My ZMK config for [my dactyl-cc keyboard](https://imgur.com/gallery/yXrFuQ6).

## ZMK Studio

This config now enables ZMK Studio in firmware (`CONFIG_ZMK_STUDIO=y`) and disables
the Studio lock screen (`CONFIG_ZMK_STUDIO_LOCKING=n`).

The GitHub Actions build for `dactyl_cc_left` also uses the
`studio-rpc-usb-uart` snippet, which is required for Studio RPC transport.

## Local build script

Run:

```bash
./scripts/build-local.sh
```

This builds both halves with Docker and always writes fresh UF2 files to:

- `.build/dactyl_cc_left.uf2`
- `.build/dactyl_cc_right.uf2`

Existing files at those paths are overwritten on each build, so `.build/`
always contains the latest firmware for each half.
