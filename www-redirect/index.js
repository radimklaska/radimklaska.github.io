// www.<host> -> https://<host>, 301, path and query kept. The target is the request's
// own hostname without "www.", so a new site needs no change here.
// Explained on https://cfsite.klaska.net/hosting/#www
export default {
  fetch(request) {
    const url = new URL(request.url);
    if (!/^www\./i.test(url.hostname)) {
      // Only the www custom domain is routed here; anything else would loop.
      return new Response("Not Found", { status: 404 });
    }
    url.protocol = "https:";
    url.hostname = url.hostname.slice(4);
    url.port = "";
    return Response.redirect(url.href, 301);
  },
};
