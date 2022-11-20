#!/bin/bash

# aws s3 cp \
# s3://mariya-20221119-assignment1/0486-GRAF-BIG-KNOB.pdf \
# s3://mariya-20221119-assignment1-copy/0486-GRAF-BIG-KNOB.pdf \
# --sse
   # aws s3 ls \
# s3://mariya-20221119-assignment1/0486-GRAF-BIG-KNOB.pdf \
# --output json

# aws s3api head-object \
# --bucket mariya-20221119-assignment1 \
# --key 0486-GRAF-BIG-KNOB.pdf --query 


limit_MB=5
limit_BYTE=$((limit_MB*1024*1024))

echo $limit_BYTE

aws s3api list-objects --bucket mariya-20221119-assignment1 --output json --query '[Contents[].{Key: Key, Size: Size}]' > output_all.json
aws s3api list-objects --bucket mariya-20221119-assignment1 --output json --query "[Contents[?Size>$limit_BYTE].{Key: Key, Size: Size}]" > output.json
 
 
 

 
 
 
  
 
 