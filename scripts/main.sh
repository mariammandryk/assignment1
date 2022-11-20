#!/bin/bash

echo "THRESHOLD_MB: $THRESHOLD_MB"
threshold_BYTE=$(echo "$THRESHOLD_MB * 1024 * 1024" | bc) # using bc to tolerate decimal number in MB
# echo "threshold_BYTE: $threshold_BYTE"

aws s3api list-objects --bucket $SOURCE_BUCKET --output json --query "Contents[?Size>\`${threshold_BYTE}\`].{Key: Key, Size: Size}" |
    for row in $(jq -cr '.[] | @base64'); do
        {
            _jq() {
                echo "${row}" | base64 --decode | jq -r "${1}"
            }
            key=$(_jq '.Key')
            size=$(_jq '.Size')

            source_path="s3://${SOURCE_BUCKET}/${key}"
            destination_path="s3://${DESTINATION_BUCKET}/${key}"

            # echo "copying size of ${size} from ${source_path} to ${destination_path}" &&
            aws s3 cp "${source_path}" "${destination_path}" --sse &&
                echo "copied from ${source_path} to ${destination_path}"
        }
    done

# wait
