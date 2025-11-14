# CLAUDE.md - AI Assistant Guide for radimklaska.github.io

## Repository Overview

This is a personal portfolio/CV website built with Jekyll and deployed to GitHub Pages. The site showcases professional experience, skills, and community involvement for Radim Klaška, a Drupal backend developer and DevOps specialist.

**Live Sites:**
- Production: https://klaska.net
- GitHub Pages: https://radimklaska.github.io

**Base Template:** Modified version of [online-cv](https://github.com/sharu725/online-cv) by Xiaoying Riley

## Technology Stack

### Core Technologies
- **Jekyll 4.3.4** - Static site generator
- **Ruby 3.3.6** - Runtime environment (see `.ruby-version`)
- **Bootstrap** - CSS framework (included in `assets/plugins/bootstrap/`)
- **SCSS/Sass** - Styling with custom theme skins
- **Liquid** - Templating language

### Build & Deployment
- **GitHub Actions** - CI/CD pipeline (`.github/workflows/jekyll-deploy.yml`)
- **GitHub Pages** - Primary hosting platform
- **Netlify** - Alternative deployment with PR preview capabilities (configured but optional)

### Dependencies
Key gems managed via `Gemfile`:
- `jekyll ~> 4.3.4`
- `minima ~> 2.5`
- `jekyll-feed ~> 0.17`

## Codebase Structure

```
radimklaska.github.io/
├── _config.yml              # Jekyll site configuration
├── _data/
│   └── data.yml            # ALL content data (profile, experience, skills, etc.)
├── _includes/              # Reusable HTML components
│   ├── sidebar.html        # Left sidebar with profile info
│   ├── career-profile.html # Career summary section
│   ├── experiences.html    # Work experience timeline
│   ├── skills.html         # Skills & proficiency bars
│   ├── education.html      # Education history
│   ├── contact.html        # Contact information
│   ├── language.html       # Language proficiencies
│   ├── business.html       # Business/custom section
│   ├── czda.html          # Czech Drupal Association section (CUSTOM)
│   ├── onewheel.html      # OneWheel reverse engineering section (CUSTOM)
│   ├── head.html          # HTML head section
│   ├── footer.html        # Site footer
│   ├── scripts.html       # JavaScript includes
│   └── analytics.html     # Google Analytics tracking
├── _layouts/
│   ├── default.html       # Main page template
│   └── compress.html      # HTML compression wrapper
├── _sass/                 # SCSS stylesheets
│   ├── _base.scss         # Base styles
│   ├── _mixins.scss       # SCSS mixins
│   ├── _responsive.scss   # Responsive design rules
│   ├── _print.scss        # Print stylesheet
│   └── skins/            # Theme color variations
│       ├── _blue.scss
│       ├── _turquoise.scss
│       ├── _green.scss
│       ├── _berry.scss
│       ├── _orange.scss
│       └── _ceramic.scss
├── assets/
│   ├── css/
│   │   └── main.scss      # Main stylesheet entry point
│   ├── js/
│   │   └── main.js        # JavaScript functionality
│   ├── images/            # Profile photos and project images
│   └── plugins/           # Third-party libraries (Bootstrap, etc.)
├── bin/
│   └── jekyll             # Bundler binstub for Jekyll
├── .github/
│   └── workflows/
│       └── jekyll-deploy.yml  # GitHub Actions deployment
├── .well-known/           # Domain verification files
├── index.html             # Homepage (includes sections from _includes/)
├── 404.html              # Custom 404 error page
├── Gemfile               # Ruby dependencies
├── Gemfile.lock          # Locked dependency versions
├── netlify.toml          # Netlify configuration (optional)
├── NETLIFY_SETUP.md      # Netlify setup instructions
├── .ruby-version         # Ruby version specification
├── .gitignore            # Git ignore rules
├── CNAME                 # Custom domain configuration
└── site.webmanifest      # PWA manifest
```

## Key Architecture Patterns

### 1. Data-Driven Content (`_data/data.yml`)

**CRITICAL:** All site content is centralized in `_data/data.yml`. This is the SINGLE SOURCE OF TRUTH for:
- Profile information (name, tagline, avatar)
- Career profile/summary
- Work experiences
- Skills and proficiency levels
- Education history
- Language proficiencies
- Contact information
- Sidebar configuration

**Pattern:**
```yaml
sidebar:
  education: False    # Controls sidebar placement of education section
  business: True      # Shows/hides business section in sidebar
  name: Radim Klaška
  tagline: Drupal Backend developer, Security, DevOps, Tinkerer
  avatar: radimklaska.jpg  # Located in assets/images/

experiences:
  - role: Drupal Backend developer & DevOps
    time: 2014 - Present
    company: Morpht Pty. Ltd.
    details: |
      Multi-line markdown description...
```

### 2. Modular Include System

Sections are componentized in `_includes/` and assembled in `index.html`:
- Each include file is self-contained and data-driven
- Includes read from `site.data.data.*` via Liquid templates
- Conditional rendering based on data presence

**Pattern in `index.html`:**
```liquid
{% include career-profile.html %}
{% unless site.data.data.sidebar.education %}
  {% include education.html %}
{% endunless %}
{% include experiences.html %}
{% include skills.html %}
{% include czda.html %}      # Custom section
{% include onewheel.html %}  # Custom section
```

### 3. Theme Skin System

The site supports multiple color themes via SCSS skins:
- Current theme: `blue` (set in `_config.yml: theme_skin: blue`)
- Available skins: blue, turquoise, green, berry, orange, ceramic
- Each skin defines color variables loaded into main stylesheet

**To change theme:** Edit `_config.yml` → `theme_skin: <color>`

## Development Workflows

### Local Development

```bash
# Clone repository
git clone git@github.com:radimklaska/radimklaska.github.io.git
cd radimklaska.github.io

# Install dependencies
bundle install

# Run local server (accessible at http://localhost:4000)
bundle exec jekyll serve

# Build for production
bundle exec jekyll build
```

**Important Settings (`_config.yml`):**
- `port: 4000` - Local server port
- `host: 0.0.0.0` - Allows external access
- `safe: false` - Enables custom plugins

### Content Updates

**To update any content:**
1. Edit `_data/data.yml` ONLY
2. Do NOT modify include files (they are templates)
3. Test locally with `bundle exec jekyll serve`
4. Commit and push to trigger deployment

**Example: Adding a new job experience**
```yaml
experiences:
  - role: New Role Title
    time: 2024 - Present
    company: Company Name
    details: |
      Job description in markdown format.
      - Bullet points work
      - Can include [links](https://example.com)
```

### Creating Custom Sections

The site has two custom sections as examples:
- `_includes/czda.html` - Czech Drupal Association
- `_includes/onewheel.html` - OneWheel reverse engineering

**To add a new custom section:**
1. Create new file in `_includes/your-section.html`
2. Follow the existing pattern with section classes
3. Add `{% include your-section.html %}` to `index.html`
4. Optionally add data to `_data/data.yml` if section is data-driven

## Deployment Process

### GitHub Pages Deployment

**Trigger:** Push to `main` branch

**Workflow:** `.github/workflows/jekyll-deploy.yml`
1. **Build Job:**
   - Checkout code
   - Setup Ruby (version from `.ruby-version`)
   - Install dependencies via Bundler (cached)
   - Build site with `bundle exec jekyll build`
   - Upload artifact

2. **Deploy Job:**
   - Deploy to GitHub Pages
   - Available at https://radimklaska.github.io
   - Custom domain: https://klaska.net (via `CNAME`)

**Note:** The workflow also runs on PRs targeting `main` but only builds (doesn't deploy).

### Netlify Deployment (Optional)

Configured via `netlify.toml`:
- Build command: `bundle exec jekyll build`
- Publish directory: `_site`
- Ruby version: 2.3.3 (note: different from local `.ruby-version`)
- Provides PR preview deployments

See `NETLIFY_SETUP.md` for detailed setup instructions.

## Key Conventions

### 1. Content Management

✅ **DO:**
- Edit content ONLY in `_data/data.yml`
- Use markdown formatting in multi-line fields (with `|` indicator)
- Keep avatar images in `assets/images/` at reasonable sizes
- Test changes locally before pushing

❌ **DON'T:**
- Hard-code content in include files
- Commit `_site/`, `.sass-cache/`, `.jekyll-cache/` (gitignored)
- Edit `Gemfile.lock` manually (use `bundle update`)

### 2. Styling Guidelines

✅ **DO:**
- Use existing SCSS variables and mixins from `_sass/`
- Create new skin files if adding color themes
- Follow responsive design patterns in `_responsive.scss`
- Use Bootstrap classes where applicable

❌ **DON'T:**
- Add inline styles in HTML
- Override Bootstrap core files (they're vendored)
- Break mobile responsiveness

### 3. Asset Management

**Images:**
- Profile/avatar: 100x100px (referenced in `data.yml`)
- Project images: Reasonable web sizes (optimized)
- Location: `assets/images/`
- Formats: PNG, JPG preferred

**Icons:**
- Favicon set included (multiple sizes)
- Touch icons for mobile (apple-touch-icon.png)
- PWA manifest: `site.webmanifest`

### 4. Git Workflow

**Branch Strategy:**
- `main` - Production branch (auto-deploys)
- `master` - Legacy branch (may exist, check recent commits)
- Feature branches: `feature/description` or `claude/...`

**Commit Messages:**
- Clear, descriptive
- Reference issue numbers if applicable
- Examples from history:
  - "Update all Ruby dependencies to latest versions"
  - "Merge pull request #X from branch-name"

### 5. Ruby & Dependencies

- Ruby version: Locked to `3.3.6` in `.ruby-version`
- Use `bundle exec` prefix for all Jekyll commands
- Update dependencies: `bundle update` (commits `Gemfile.lock`)
- Check for security updates regularly

## Common Operations for AI Assistants

### 1. Updating Professional Experience

```yaml
# In _data/data.yml
experiences:
  - role: [New/Updated Role]
    time: [Time Period]
    company: [Company Name]
    details: |
      [Description in markdown]
```

### 2. Adding Skills

```yaml
# In _data/data.yml
skills:
  toolset:
    - name: [Skill Name]
      level: [0-100]%
```

### 3. Changing Theme Color

```yaml
# In _config.yml
theme_skin: blue  # Options: blue, turquoise, green, berry, orange, ceramic
```

### 4. Updating Contact Information

```yaml
# In _data/data.yml
# Structure varies, check existing format
```

### 5. Adding Education Entries

```yaml
# In _data/data.yml
education:
  - degree: [Degree Name]
    university: [Institution]
    time: [Year or Period]
    details: |
      [Description]
```

### 6. Modifying Analytics

```yaml
# In _config.yml
analytics: UA-XXXXXXX-X  # Google Analytics tracking ID
```

## Important Files Reference

| File | Purpose | Modify? |
|------|---------|---------|
| `_data/data.yml` | All site content | ✅ YES - Primary content file |
| `_config.yml` | Jekyll configuration | ✅ YES - Settings only |
| `Gemfile` | Ruby dependencies | ⚠️ CAREFUL - Update versions only |
| `Gemfile.lock` | Locked versions | ❌ NO - Auto-generated |
| `_includes/*.html` | Template components | ⚠️ CAREFUL - Usually layout only |
| `_sass/*.scss` | Stylesheets | ✅ YES - For styling changes |
| `index.html` | Homepage structure | ⚠️ CAREFUL - Section order only |
| `.github/workflows/` | CI/CD config | ⚠️ CAREFUL - Advanced only |
| `netlify.toml` | Netlify config | ⚠️ CAREFUL - If using Netlify |
| `CNAME` | Custom domain | ⚠️ CAREFUL - Domain config only |

## Troubleshooting Guide

### Build Fails Locally

```bash
# Clear Jekyll cache
bundle exec jekyll clean

# Reinstall dependencies
rm -rf vendor/
bundle install

# Check Ruby version
ruby --version  # Should match .ruby-version

# Verbose build for debugging
bundle exec jekyll build --verbose
```

### GitHub Actions Deployment Fails

1. Check workflow logs in GitHub Actions tab
2. Verify `.ruby-version` matches workflow expectations
3. Ensure `Gemfile.lock` is committed
4. Check for YAML syntax errors in `_config.yml` or `_data/data.yml`

### Styling Issues

1. Check browser console for CSS errors
2. Clear browser cache
3. Verify theme skin exists in `_sass/skins/`
4. Rebuild with `bundle exec jekyll clean && bundle exec jekyll build`

### Content Not Updating

1. Check YAML syntax in `_data/data.yml` (indentation is critical)
2. Restart Jekyll server (`Ctrl+C`, then `bundle exec jekyll serve`)
3. Hard refresh browser (`Cmd+Shift+R` or `Ctrl+Shift+R`)
4. Verify include is added to `index.html`

## AI Assistant Guidelines

### When Editing Content

1. **Always validate YAML syntax** after editing `_data/data.yml`
   - Use proper indentation (2 spaces)
   - Escape special characters
   - Use `|` for multi-line content

2. **Test locally before committing**
   - Run `bundle exec jekyll serve`
   - Check http://localhost:4000
   - Verify responsive design on mobile

3. **Preserve existing structure**
   - Don't remove fields unless explicitly requested
   - Maintain consistency with existing entries
   - Follow markdown formatting conventions

### When Modifying Code

1. **Understand the impact**
   - Layout changes affect all instances
   - SCSS changes may affect multiple pages
   - Config changes require rebuild

2. **Maintain responsiveness**
   - Test on mobile breakpoints
   - Use existing Bootstrap classes
   - Check `_responsive.scss` for patterns

3. **Document changes**
   - Update this file if architecture changes
   - Add comments for complex logic
   - Commit messages should explain "why"

### When Updating Dependencies

1. **Check compatibility**
   - Jekyll 4.x breaking changes
   - Ruby version requirements
   - Plugin compatibility

2. **Test thoroughly**
   - Run `bundle exec jekyll build`
   - Check for deprecation warnings
   - Verify all includes render correctly

3. **Update lock file**
   - Always commit `Gemfile.lock` with `Gemfile`
   - Don't skip bundle install
   - Check GitHub Actions success

### Best Practices

✅ **Always:**
- Read `_data/data.yml` structure before editing
- Preserve existing formatting and style
- Test changes in local environment
- Check for YAML/Liquid syntax errors
- Validate HTML output
- Review responsive design
- Check browser console for errors

❌ **Never:**
- Delete `Gemfile.lock`
- Hard-code content in templates
- Break YAML indentation
- Skip local testing
- Commit generated files (`_site/`, caches)
- Modify vendor files directly

### Understanding the Content Flow

```
_data/data.yml
    ↓
Liquid Templates (_includes/*.html)
    ↓
Layout (_layouts/default.html)
    ↓
SCSS Processing (_sass/ + assets/css/main.scss)
    ↓
Jekyll Build
    ↓
Static Site (_site/)
    ↓
Deployment (GitHub Pages / Netlify)
```

## Custom Sections Pattern

The site has two custom sections demonstrating the pattern for adding personalized content beyond the standard CV template:

### Czech Drupal Association Section
- **File:** `_includes/czda.html`
- **Purpose:** Showcase community leadership
- **Pattern:** Custom HTML/Liquid with image and description
- **Activated:** Included in `index.html`

### OneWheel Reverse Engineering Section
- **File:** `_includes/onewheel.html`
- **Purpose:** Highlight technical hobby/side project
- **Pattern:** Similar to CZDA, demonstrates personal interests
- **Activated:** Included in `index.html`

**To create similar sections:**
1. Copy one of these files as a template
2. Modify content (can reference `site.data.data.*` if needed)
3. Add image to `assets/images/`
4. Include in `index.html` at desired position

## Version History

- **Current Jekyll:** 4.3.4
- **Current Ruby:** 3.3.6
- **Last Updated:** 2025-11-14
- **Original Template:** Based on online-cv by Xiaoying Riley

## Additional Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Liquid Template Language](https://shopify.github.io/liquid/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Bootstrap 3 Documentation](https://getbootstrap.com/docs/3.3/)
- [Original Template](https://github.com/sharu725/online-cv)

## Quick Reference Commands

```bash
# Development
bundle install                 # Install dependencies
bundle exec jekyll serve       # Start local server
bundle exec jekyll build       # Build static site
bundle exec jekyll clean       # Clean generated files

# Dependency Management
bundle update                  # Update all gems
bundle update jekyll          # Update specific gem
bundle outdated               # Check for outdated gems

# Git Operations
git status                    # Check repository status
git add _data/data.yml        # Stage content changes
git commit -m "Update content" # Commit changes
git push origin main          # Deploy to production

# Testing
bundle exec jekyll serve --livereload  # Auto-reload on changes
bundle exec jekyll serve --drafts      # Include draft posts
bundle exec jekyll build --verbose     # Verbose build output
```

---

**Last Updated:** 2025-11-14
**Maintainer:** Radim Klaška
**Purpose:** Guide AI assistants in understanding and modifying this codebase effectively
