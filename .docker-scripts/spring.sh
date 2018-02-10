#!/bin/bash

until bundle check >/dev/null
do
  echo "Error: bundle check is failed. retry bundle check..."
  sleep 5
done
rm -rf /tmp/spring-0
bundle exec spring server
