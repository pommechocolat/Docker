#!/bin/bash

echo "startup Nuxeo"

service nuxeo start && tail -f /var/log/nuxeo/*