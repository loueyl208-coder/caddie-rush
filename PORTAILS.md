# Publier Caddie Rush sur les portails de jeux

## Fabriquer les zips

```bash
./build.sh                     # crée dist/caddie-rush-{web,poki,crazygames,gamedistribution}.zip
GD_ID=ton_id ./build.sh        # avec l'identifiant GameDistribution
```

Chaque zip contient le jeu complet (environ 620 Ko) : `index.html`, `config.js`, `assets/`, `vendor/` (Three.js intégré, aucun téléchargement externe).

## Ce qui est déjà branché dans le jeu

| Portail | Kit chargé | Pubs entre les parties | Pubs récompensées | Sauvegarde |
|---|---|---|---|---|
| Poki | `poki-sdk.js` v2 | `commercialBreak` | `rewardedBreak` | navigateur |
| CrazyGames | SDK v3 | `requestAd('midgame')` | `requestAd('rewarded')` | module `data` du SDK |
| GameDistribution | `main.min.js` | `showAd()` | `showAd('rewarded')` (à activer : `GD_REWARDED=true`) | navigateur |

- Début et fin de partie signalés au portail (`gameplayStart` / `gameplayStop`), chargement terminé signalé.
- Pendant une pub : jeu en pause et son coupé. Son coupé aussi quand l'onglet est caché.
- Pas de pub avant la toute première course.
- Pubs récompensées : doubler ses courses en fin de course, continuer après un crash (Descente), +15 courses dans le vestiaire.
- Si le kit ne se charge pas (bloqueur de pub), le jeu marche normalement sans pub.
- Le portail est choisi par `config.js` (le zip de chaque portail est déjà réglé). Pour tester : `index.html?portal=poki`.
- Jeu en français et en anglais (langue du navigateur, bouton dans le menu).

## À faire de ton côté

1. Créer un compte développeur sur chaque portail et envoyer le bon zip.
2. Tester avec les outils de test du portail (Poki Inspector, QA Tool CrazyGames, panneau GameDistribution).
3. Préparer les visuels demandés (icônes, vignettes, vidéo de gameplay) avec une image originale.
