#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

__self="${BASH_SOURCE[0]}"
__dir="$(cd "$(dirname "${__self}")" > /dev/null && pwd)"
__file="${__dir}/$(basename "${__self}")"

dlurl='https://anonfiles.com/g806l9Iby0/jmmb_avatar_png'

anonfilesdl="$(dirname "${__dir}")/anonfilesdl"
tmpdir="${__dir}/tmp"

rm -rf "${tmpdir}"
mkdir "${tmpdir}"
pushd "${tmpdir}" > /dev/null

"${anonfilesdl}" "${dlurl}"
shasum -c "${__dir}/jmmb avatar.png.sha256"

popd > /dev/null
rm -rf "${tmpdir}"
