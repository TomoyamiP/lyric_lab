const CACHE = "lyriclab-v1";
const OFFLINE_URL = "/offline.html";
const PRECACHE = ["/", OFFLINE_URL];

self.addEventListener("install", (event) => {
  event.waitUntil(caches.open(CACHE).then((c) => c.addAll(PRECACHE)));
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.map((k) => (k !== CACHE ? caches.delete(k) : null)))
    )
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  const req = event.request;
  if (req.method !== "GET") return;

  event.respondWith(
    fetch(req)
      .then((res) => {
        const resClone = res.clone();
        caches.open(CACHE).then((c) => c.put(req, resClone));
        return res;
      })
      .catch(() =>
        caches.match(req).then((cached) => cached || caches.match(OFFLINE_URL))
      )
  );
});
