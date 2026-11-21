# KURSI WARS

KURSI WARS is a browser-first 3D arena brawler. It runs in Chrome and Edge on desktop and mobile browsers. CPU play has no account or server requirement. The frontend is a Vite static site; private-room multiplayer is a separate Node.js and Socket.IO service.

## Play locally

1. Install Node.js 20 LTS or newer.
2. Run `INSTALL.bat` once, or run `npm install` in this folder.
3. Run `START-WINDOWS.bat`. The game opens at `http://localhost:5173`.
4. Choose **Enter the Arena**, pick a fighter, and use the controls below. CPU play works offline after dependencies have been installed.

To run the processes manually, use `npm run dev` for the web client and `npm run server` for the room service. The default socket endpoint is `http://localhost:3001`.

## Controls

| Action | Keyboard | Mobile |
| --- | --- | --- |
| Move | W A S D | Direction buttons |
| Punch / heavy / kick | J / K / L | PUNCH / HEAVY / KICK |
| Special / ultimate | U / I | SPECIAL / ULT |
| Guard / dodge / jump | E / Shift / Space | GUARD / direction / (keyboard) |
| Pause | Esc | Pause button |

Local two-player uses WASD and J/K/L/U/I for Player 1, arrow keys and 1/2/3/4/5 for Player 2. Mobile matches are designed for landscape orientation.

## Modes and game systems

- CPU fight, training, story entry, tournament entry, local two-player, and fighter collection are accessible from the main menu. The fight loop uses movement, range-checked strikes, attack cooldowns, blocking, special and ultimate meters, a CPU opponent, and match results.
- The 20 original, satirical fighters and arena dressing are generated from Three.js geometry at runtime. Character art and animation are original procedural 3D meshes and pose motion; this release does not include externally sourced GLB rigs, recorded dialogue, or licensed likeness assets.
- CPU wins add XP and coins to a browser-local profile. No account or progression backend is required for CPU play.
- Online rooms use six-character invite codes. A connected room starts when the second browser joins. The server owns health, meters, attack cooldowns, and bounded movement updates. This is an early room-based multiplayer implementation; public matchmaking, reconnect recovery, persistent accounts, and ranked leaderboards are not included.
- Online mode needs the separate service deployed and the frontend built with its public URL. Without that deployment, the menu reports that online play is unavailable; it never substitutes a local or simulated opponent.

## Build

```powershell
npm install
npm run build
npm run preview
```

`BUILD.bat` runs the production build on Windows. Static files are written to `dist/`.

## Public deployment

The included `render.yaml` describes a Render static site and separate Node web service. It can also be used as a guide for equivalent hosts.

1. Put this `outputs` project in a Git repository and connect it to Render.
2. Deploy the `kursi-wars-multiplayer` web service first. It starts with `npm run server` and exposes `/health`.
3. Set its `CLIENT_ORIGIN` to the final HTTPS website origin, for example `https://kursi-wars-web.onrender.com` (no trailing slash). The service accepts a comma-separated origin list if you use a preview site too.
4. Deploy the `kursi-wars-web` static site. Set its build-time `VITE_SOCKET_URL` to the multiplayer service's HTTPS URL, such as `https://kursi-wars-multiplayer.onrender.com`. Socket.IO negotiates secure WebSocket (`wss`) from HTTPS pages.
5. Redeploy the site after changing `VITE_SOCKET_URL`; Vite embeds this value in the static build. Open the site URL, create a room in one browser, and join its code from another internet connection.

On other hosts, use `npm run build` and publish `dist/` on an HTTPS static host. Run `npm run server` as a persistent Node service with `PORT` set by the host. Set `CLIENT_ORIGIN` and build with `VITE_SOCKET_URL` as above. Do not point the public client at an HTTP server; browsers block insecure WebSockets from secure sites.

There is no public website URL configured in this project yet: hosting ownership, DNS, and deployment credentials were not provided. Once deployed to hosting accounts, the site URL can be shared directly and players will not need Node or a local server.

## Configuration

Copy `.env.example` as a reference. For local development, the socket URL defaults to `http://localhost:3001`. Production frontend configuration is supplied at Vite build time as `VITE_SOCKET_URL`; backend access control uses `CLIENT_ORIGIN`. The `.env.example` values are placeholders and no secrets are required.

## Project map

- `src/main.js` — menu, fighter roster, selection, combat loop, CPU logic, and progression.
- `src/style.css` — responsive desktop, mobile, selection, and battle interface.
- `server/src/server.js` — Express health route and Socket.IO room / combat state.
- `render.yaml` — separate static-site and multiplayer-service configuration.
- `START-WINDOWS.bat`, `INSTALL.bat`, `BUILD.bat` — Windows setup and launch helpers.
