#! /bin/bash
TEMP_DIR=$(mktemp -d)
PACKAGES_DIR="${TEMP_DIR}/packages"

mkdir -p ${PACKAGES_DIR}

for SPEC in *.goospec; do
    echo "goopack ${SPEC}"
    goopack -output_dir ${PACKAGES_DIR} ${SPEC}
done

exa -alg --tree ${TEMP_DIR}
gsutil -m rsync -r "${TEMP_DIR}/" "gs://playplay-tools/googet/"
rm -rf ${TEMP_DIR}
