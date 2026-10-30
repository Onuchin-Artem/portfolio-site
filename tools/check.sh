#!/usr/bin/env bash
# Freshness check, run before every commit (tools/git-hooks/pre-commit).
# 1. every external link on the page answers;
# 2. each work's URL still matches what its own repo says it is (sibling checkouts in ../);
# 3. lists the TODO placeholders still on the page.
# Skip once with SKIP_CHECK=1 git commit ... (e.g. offline).
set -u
cd "$(dirname "$0")/.."
PAGE=site/index.html
PROJECTS=${PROJECTS:-$(cd .. && pwd)}
fail=0
SELF=$(sed -n 's/.*rel="canonical" href="\([^"]*\)".*/\1/p' "$PAGE")

echo "== links"
for url in $(grep -o 'href="https://[^"]*"' "$PAGE" | sed 's/^href="//; s/"$//' | sort -u | grep -vF "$SELF"); do
  code=$(curl -s -o /dev/null -L --max-time 20 -A "Mozilla/5.0 portfolio-check" -w '%{http_code}' "$url")
  case "$code" in
    2??|3??) echo "  ok   $code $url" ;;
    401) echo "  ok   401 $url (password-gated)" ;;
    *) echo "  FAIL $code $url"; fail=1 ;;
  esac
done

echo "== work URLs vs their repos"
expect() {  # $1 = label, $2 = URL the source of truth gives
  if [ -z "$2" ]; then echo "  ?    $1: could not read its URL from the repo"; return; fi
  if grep -q "href=\"$2/\?\"" "$PAGE"; then echo "  ok   $1: $2"
  else echo "  FAIL $1: its repo says $2, the page links something else"; fail=1; fi
}
if [ -d "$PROJECTS/hojoki" ]; then
  expect hojoki "$(sed -n 's/^SITE_URL = "\(.*\)"/\1/p' "$PROJECTS/hojoki/web/build_web.py")"
fi
if [ -d "$PROJECTS/heruka" ]; then
  # the showcase URL as STATUS.md states it; a custom domain, once bought, should be recorded there
  expect heruka "$(grep -o 'private showcase: https://[^ )]*' "$PROJECTS/heruka/docs/STATUS.md" | head -1 | sed 's/^private showcase: //; s/[.,]$//')"
fi

echo "== placeholders still on the page"
grep -o 'TODO([a-z]*)[^-]*' "$PAGE" | sed 's/^/  /' || echo "  none"

if [ "$fail" -ne 0 ]; then echo "check FAILED: update the page (or SKIP_CHECK=1 to bypass once)"; exit 1; fi
echo "check passed"
