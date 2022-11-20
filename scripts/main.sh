#!/bin/bash

echo "threshold_MB: $threshold_MB"
threshold_BYTE=$(echo "$threshold_MB * 1024 * 1024" | bc) # using bc to tolerate decimal number in MB
echo "threshold_BYTE: $threshold_BYTE"

aws s3api list-objects --bucket $source_bucket --output json --query "[Contents[?Size>\`${threshold_BYTE}\`].{Key: Key, Size: Size}]"
