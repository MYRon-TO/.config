#!/bin/bash

wpa_cli disable_network 0
sleep 3s
wpa_cli enable_network 0
