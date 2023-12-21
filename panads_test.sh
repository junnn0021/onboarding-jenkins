#!/bin/bash

docker exec js-jenkins /bin/bash -c \
  "{ echo;  echo -n 'Time = ' && date '+%Y-%m-%d %H:%M:%S'; } && \
  source /opt/conda/etc/profile.d/conda.sh && \
  conda activate test && \
  python /pandas_test.py" >> /home/log/test.log

echo 'Results saved successfully.'
