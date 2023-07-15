#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

anonfilesdl="$(dirname "${__dir}")/anonfilesdl"
cd "${__dir}"
tmpdir='tmp'

echo '>>> Upload:'
uploaded="$(curl -s -F 'file=@hello.txt' 'https://api.anonfiles.com/upload')"
jq <<< "${uploaded}"
dlurl="$(jq -r '.data.file.url.full' <<< "${uploaded}")"
echo '>>> Done'

echo '>>> Download:'
rm -rf "${tmpdir}"
mkdir "${tmpdir}"
pushd "${tmpdir}" > /dev/null
"${anonfilesdl}" "${dlurl}"
shasum -c "${__dir}/hello.txt.sha256"
popd > /dev/null
rm -rf "${tmpdir}"
echo '>>> Done'
