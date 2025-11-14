# Netlify Setup Guide

This repository is configured to work with Netlify for automatic PR preview deployments.

## What's Configured

- `netlify.toml` - Netlify build configuration
- `.ruby-version` - Ruby version specification for consistent builds
- Jekyll build commands optimized for Netlify

## Initial Setup (One-Time)

1. **Sign up for Netlify** (if you haven't already)
   - Go to https://www.netlify.com/
   - Sign up with your GitHub account (recommended)

2. **Connect Your Repository**
   - Click "Add new site" → "Import an existing project"
   - Choose "GitHub" as your Git provider
   - Select the `cowosedlice/cowosedlice.cz` repository
   - Netlify will automatically detect the `netlify.toml` configuration

3. **Deploy Settings** (should be auto-detected)
   - Build command: `bundle exec jekyll build`
   - Publish directory: `_site`
   - These are already configured in `netlify.toml`

4. **Click "Deploy site"**

## What You Get

### Production Deployment
- Your main branch deploys to a URL like: `https://cowosedlice.netlify.app`
- You can add a custom domain later if desired

### PR Previews (The Magic!)
- Every pull request automatically gets a preview deployment
- Preview URL format: `https://deploy-preview-[PR-NUMBER]--cowosedlice.netlify.app`
- Netlify bot will comment on your PRs with the preview link
- Previews update automatically when you push new commits

### Branch Deployments
- Other branches can also have their own URLs
- Useful for testing features before creating a PR

## Workflow Example

1. Create a feature branch: `git checkout -b feature/new-content`
2. Make your changes and commit
3. Push to GitHub: `git push -u origin feature/new-content`
4. Open a Pull Request on GitHub
5. **Netlify automatically builds and comments with preview URL**
6. Review the preview, make changes if needed
7. Merge PR when ready
8. Production site updates automatically

## Managing Netlify

- Dashboard: https://app.netlify.com/
- View deploy logs, manage domains, configure environment variables, etc.

## Keeping GitHub Pages (Optional)

You can run both services simultaneously:
- **Netlify**: For PR previews and testing
- **GitHub Pages**: For production (if you prefer)

Just configure GitHub Pages to deploy from your main branch as usual.

## Notes

- Ruby version 2.3.3 is specified (matching your Travis CI setup)
- Build time is typically 1-2 minutes for Jekyll sites
- Netlify free tier includes:
  - Unlimited PR previews
  - 300 build minutes/month
  - 100 GB bandwidth/month
  - More than enough for most projects

## Troubleshooting

### Build Fails
- Check the deploy logs in Netlify dashboard
- Ensure `bundle install` and `bundle exec jekyll build` work locally
- Verify Ruby version matches

### Preview URL Doesn't Work
- Wait a few minutes for build to complete
- Check PR comments for Netlify status
- Review build logs for errors

## Further Reading

- Netlify Docs: https://docs.netlify.com/
- Jekyll on Netlify: https://docs.netlify.com/integrations/frameworks/jekyll/
