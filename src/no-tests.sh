#!/bin/bash
set -Eeuo pipefail

# On github, when running oca-repo-addons-template, if some modules
# are hard to install (because of complex and long test-requirements.txt)
# you may just skip them in tests.
# Yes I know it's sad to not test everything from a ci, but one may run the tests
# elsewhere (local, project)

# hide all not testable addons
if [ -z "${GITHUB_WORKSPACE:-}" ] ; then
	ls -d */ -d .*/ | grep --invert-match -f no-tests.regex | git sparse-checkout set --stdin
else
	ls -d */ -d .*/ | grep -f no-tests.regex | xargs rm -rf
fi
