#!/bin/sh

run_test() {
  out="$(bun "$1" 2>&1)"
  printf "%s" "$out" | grep -q "works!" && ! printf "%s" "$out" | grep -q "Error"
}

check() {
  name="$1"
  repo="$2"
  test="$3"

  git clone "$repo"
  if run_test "$test"; then
    result="PASS"
  else
    printf "retrying %s...\n" "$name" >&2
    if run_test "$test"; then
      result="PASS"
    else
      result="FAIL"
      printf "FAILED: %s\n" "$name" >&2
    fi
  fi
  rm -rf "$name"
  printf "%s: %s\n" "$name" "$result" >> health.txt
}

: > health.txt

check "searchtify" "https://github.com/VillainsRule/searchtify" "searchtify/tests/does-it-work.js"
check "AppleMusic" "https://github.com/VillainsRule/AppleMusic" "AppleMusic/tests/does-it-work.js"
check "YoutubeMusic" "https://github.com/VillainsRule/YoutubeMusic" "YoutubeMusic/tests/does-it-work.js"
