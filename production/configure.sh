#!/bin/bash

./scripts/install-packages.sh
./config-version.sh
./scripts/config-terrama2.sh
./scripts/config-report.sh
./scripts/config-postgres.sh
./scripts/config-nginx.sh