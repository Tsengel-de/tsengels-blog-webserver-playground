#!/usr/bin/env bash

sudo certbot renew --force-renewal

nginx -t && nginx -s reload

