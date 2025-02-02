#! /bin/dash

#######################
#   tigger-log Test   #
#######################

trap 'rm -fr $output $expected $my $cse;exit' INT TERM EXIT

tigger=$(pwd)
my="$(mktemp -d)"
cse="$(mktemp -d)"

############################################################
# Test tigger-log: error: tigger repository directory .tigger not found
############################################################

cd "$my" || exit 1
output=$(mktemp)
"$tigger"/tigger-log > "$output" 2>&1

cd "$cse" || exit 1
expected=$(mktemp)
2041 tigger-log > "$expected" 2>&1

if ! diff "$output" "$expected"; then
    echo "test05-1: FAILED" 1>&2
    exit 1
fi

############################################################
# Initializa empty tigger repository in .tigger
############################################################

cd "$my" || exit 1
"$tigger"/tigger-init 1>/dev/null

cd "$cse" || exit 1
2041 tigger-init 1>/dev/null

############################################################
# Test usage: tigger-log
############################################################

cd "$my" || exit 1
output=$(mktemp)
"$tigger"/tigger-log x > "$output" 2>&1

cd "$cse" || exit 1
expected=$(mktemp)
2041 tigger-log x > "$expected" 2>&1

if ! diff "$output" "$expected"; then
    echo "test05-2: FAILED" 1>&2
    exit 1
fi

############################################################
# add first commit
############################################################

cd "$my" || exit 1
echo "aaa" > a
"$tigger"/tigger-add a >/dev/null
"$tigger"/tigger-commit -m "x" >/dev/null
"$tigger"/tigger-branch new >/dev/null

cd "$cse" || exit 1
echo "aaa" > a
2041 tigger-add a >/dev/null
2041 tigger-commit -m "x" >/dev/null
2041 tigger-branch new >/dev/null

############################################################
# Test successfully print log 
############################################################

cd "$my" || exit 1
output=$(mktemp)
"$tigger"/tigger-log > "$output" 2>&1

cd "$cse" || exit 1
expected=$(mktemp)
2041 tigger-log > "$expected" 2>&1

if ! diff "$output" "$expected"; then
    echo "test05-3: FAILED" 1>&2
    exit 1
fi

echo "test05: ALL PASS" 1>&2