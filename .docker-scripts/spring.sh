#!/bin/bash

bundle install --path=vendor/bundle -j4
bundle exec spring server
