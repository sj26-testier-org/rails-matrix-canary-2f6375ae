set -euo pipefail
case "$TEST_VARIANT" in
  amber-17) expected=seventeen ;;
  violet-83) expected=eighty-three ;;
  *) printf 'UNEXPECTED_MATRIX_VARIANT %s\n' "$TEST_VARIANT"; exit 3 ;;
esac
revision=$(git rev-parse HEAD)
test "$revision" = "$GITHUB_SHA"
actual=$(cat "cases/$TEST_VARIANT.txt")
if [[ $actual != "$expected" ]]; then
  printf 'MATRIX_ASSERTION_FAILED %s expected=%s actual=%s sha=%s\n' "$TEST_VARIANT" "$expected" "$actual" "$revision"
  exit 7
fi
printf 'MATRIX_TEST_OK %s sha=%s\n' "$TEST_VARIANT" "$revision"
