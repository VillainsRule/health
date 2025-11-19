#!/bin/sh

check() {
  name="$1"
  repo="$2"
  test="$3"

  git clone "$repo"
  out="$(bun "$test" 2>/dev/null)"
  if printf "%s" "$out" | grep -q "works!"; then
    result="PASS"
  else
    result="FAIL"
  fi
  rm -rf "$name"
  printf "%s: %s\n" "$name" "$result" >> health.txt
}

: > health.txt

check "searchtify" "https://github.com/VillainsRule/searchtify" "searchtify/tests/does-it-work.js"
check "AppleMusic" "https://github.com/VillainsRule/AppleMusic" "AppleMusic/tests/does-it-work.js"
check "YoutubeMusic" "https://github.com/VillainsRule/YoutubeMusic" "YoutubeMusic/tests/does-it-work.js"
