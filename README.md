[![Deploy to Cloudflare](https://github.com/radimklaska/radimklaska.github.io/actions/workflows/deploy.yml/badge.svg?branch=main)](https://github.com/radimklaska/radimklaska.github.io/actions/workflows/deploy.yml)

# radimklaska.github.io | klaska.net

Simple Jekyll site based on https://github.com/sharu725/online-cv

## Visit the site

* Production domain: https://klaska.net
* Hosting: Cloudflare Worker (see `wrangler.jsonc`), deployed by `.github/workflows/deploy.yml`

## Run site locally

* See: https://jekyllrb.com/docs/#instructions
* `git clone git@github.com:radimklaska/radimklaska.github.io.git`
* `cd radimklaska.github.io`
* `bundle exec jekyll serve`
* With Cloudflare's redirects and 404 handling: `npm install && bundle exec jekyll build && npx wrangler dev`
