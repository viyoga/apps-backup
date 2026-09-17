#!/usr/bin/env bash
# prettyzap-toggle.sh
# Instantly toggle PrettyZap and switch to workspace 5.
# --theme=system is hardcoded in the systemd service, so no readiness
# gate is needed — the Noctalia theme is always correct on launch.

prettyzap --toggle
sleep 0.1
