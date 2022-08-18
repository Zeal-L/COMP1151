#! /bin/dash

compare() {
    if ! diff "$1" "$2"; then
        echo "test08-$3: FAILED" 1>&2
        exitCode=1
    fi
}

trap 'rm -fr $output $expected $tempDir ;exit' INT TERM EXIT

mySlippy="python3 -s -S $(pwd)/slippy"
cseSlippy="2041 slippy"
tempDir="$(mktemp -d)"
cd "$tempDir" || exit 1

exitCode=0


############################################################
# Test insert command
############################################################

expected=$(mktemp)
seq 1 5 | $cseSlippy '   i   zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '   i   zeal' > "$output" 2>&1

compare "$output" "$expected" 1


############################################################
# Test slippy insert command with addresses
############################################################

expected=$(mktemp)
seq 11 19 | $cseSlippy '5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 11 19 | $mySlippy '5i zeal' > "$output" 2>&1

compare "$output" "$expected" 2


expected=$(mktemp)
seq 100 111 | $cseSlippy '/1.1/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 100 111 | $mySlippy '/1.1/i zeal' > "$output" 2>&1

compare "$output" "$expected" 2.1

expected=$(mktemp)
seq 100 111 | $cseSlippy '/.0./i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 100 111 | $mySlippy '/.0./i zeal' > "$output" 2>&1

compare "$output" "$expected" 3


############################################################
# Test slippy insert command with address /X/,X
############################################################

expected=$(mktemp)
seq 1 5 | $cseSlippy '/2/,5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '/2/,5i zeal' > "$output" 2>&1

compare "$output" "$expected" 4


expected=$(mktemp)
seq 1 5 | $cseSlippy -n '/2/,5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy -n '/2/,5i zeal' > "$output" 2>&1

compare "$output" "$expected" 4.1


expected=$(mktemp)
seq 1 5 | $cseSlippy '/2/,$i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '/2/,$i zeal' > "$output" 2>&1

compare "$output" "$expected" 5

############################################################
# Test slippy insert command with address X,/X/
############################################################

expected=$(mktemp)
seq 1 5 | $cseSlippy '2,/4/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '2,/4/i zeal' > "$output" 2>&1

compare "$output" "$expected" 6


expected=$(mktemp)
seq 1 5 | $cseSlippy -n '2,/4/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy -n '2,/4/i zeal' > "$output" 2>&1

compare "$output" "$expected" 7


expected=$(mktemp)
seq 1 5 | $cseSlippy '$,/4/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '$,/4/i zeal' > "$output" 2>&1

compare "$output" "$expected" 8

############################################################
# Test slippy insert command with address X,X
############################################################

expected=$(mktemp)
seq 1 5 | $cseSlippy '3,5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '3,5i zeal' > "$output" 2>&1

compare "$output" "$expected" 9


expected=$(mktemp)
seq 1 5 | $cseSlippy -n '3,5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy -n '3,5i zeal' > "$output" 2>&1

compare "$output" "$expected" 10


expected=$(mktemp)
seq 1 5 | $cseSlippy '$,5i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '$,5i zeal' > "$output" 2>&1

compare "$output" "$expected" 11

expected=$(mktemp)
seq 1 5 | $cseSlippy '2,$i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '2,$i zeal' > "$output" 2>&1

compare "$output" "$expected" 12

expected=$(mktemp)
seq 1 5 | $cseSlippy '$,$i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '$,$i zeal' > "$output" 2>&1

compare "$output" "$expected" 13

expected=$(mktemp)
seq 1 5 | $cseSlippy '5,1i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 5 | $mySlippy '5,1i zeal' > "$output" 2>&1

compare "$output" "$expected" 14

############################################################
# Test slippy insert command with address /X/,/X/
############################################################

expected=$(mktemp)
seq 1 100 | $cseSlippy '/44/,/66/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 100 | $mySlippy '/44/,/66/i zeal' > "$output" 2>&1

compare "$output" "$expected" 15


expected=$(mktemp)
seq 1 100 | $cseSlippy -n '/44/,/66/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 100 | $mySlippy -n '/44/,/66/i zeal' > "$output" 2>&1

compare "$output" "$expected" 15.1


expected=$(mktemp)
seq 1 100 | $cseSlippy '/44/,/-1/i zeal' > "$expected" 2>&1

output=$(mktemp)
seq 1 100 | $mySlippy '/44/,/-1/i zeal' > "$output" 2>&1

compare "$output" "$expected" 16


############################################################
# Exit with the correct exit code
############################################################

if [ $exitCode != 0 ]; then
    exit $exitCode
fi