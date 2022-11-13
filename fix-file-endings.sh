#!/bin/bash
for target_config in configs/default/*.config;
do
    FILE_NAME="configs/default/$(basename ${target_config})"
    awk 'NF {p=1} p' <<< "$(< "${FILE_NAME}")" > ${FILE_NAME}
done
echo "done."
