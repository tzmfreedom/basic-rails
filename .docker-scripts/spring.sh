#!/bin/bash

until bundle check >/dev/null
do
  echo "Error: bundle check is failed. retry bundle check..."
  sleep 5
done
bundle exec spring server
