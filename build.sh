#!/usr/bin/env bash
# Fabrique un zip prêt à envoyer pour chaque portail de jeux.
#   ./build.sh            -> dist/caddie-rush-{web,poki,crazygames,gamedistribution}.zip
#   GD_ID=xxxx ./build.sh -> renseigne l'identifiant GameDistribution
set -euo pipefail
cd "$(dirname "$0")"
rm -rf dist && mkdir -p dist
for portal in web poki crazygames gamedistribution; do
  tmp="dist/$portal"
  mkdir -p "$tmp"
  cp -r index.html assets vendor "$tmp/"
  name=$portal; [ "$portal" = web ] && name=auto
  cat > "$tmp/config.js" <<CFG
window.CR_PORTAL = '$name';
window.CR_GD_ID = '${GD_ID:-}';
window.CR_GD_REWARDED = ${GD_REWARDED:-false};
CFG
  (cd "$tmp" && python3 -c "
import zipfile, os
with zipfile.ZipFile('../caddie-rush-$portal.zip', 'w', zipfile.ZIP_DEFLATED) as z:
    for root, _, files in os.walk('.'):
        for f in files:
            p = os.path.join(root, f)
            z.write(p, os.path.relpath(p, '.'))
")
  rm -rf "$tmp"
done
ls -lh dist
