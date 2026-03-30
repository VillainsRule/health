#!/bin/sh

check() {
  name="$1"
  repo="$2"
  test="$3"

  git clone "$repo"
  out="$(bun "$test" 2>&1)"
  if printf "%s" "$out" | grep -q "works!" && ! printf "%s" "$out" | grep -q "Error"; then
    result="PASS"
  else
    result="FAIL"
    printf "%s\n" "$out" >&2
  fi
  rm -rf "$name"
  printf "%s: %s\n" "$name" "$result" >> health.txt
}

: > health.txt

check "searchtify" "https://github.com/VillainsRule/searchtify" "searchtify/tests/does-it-work.js"
check "AppleMusic" "https://github.com/VillainsRule/AppleMusic" "AppleMusic/tests/does-it-work.js"
check "YoutubeMusic" "https://github.com/VillainsRule/YoutubeMusic" "YoutubeMusic/tests/does-it-work.js"
