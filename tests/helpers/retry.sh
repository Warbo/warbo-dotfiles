#!/usr/bin/env bash

# Select a test a random to re-try

# To try and spend a fair proportion of time on each test, we divide up the
# probability of being chosen according to the time taken by the last run

# For n tests, taking time t(1), t(2), ..., we give test i probability:
# p(i) = 1 / (t(i) * sum(j, 1 / t(j)))
