#!/usr/bin/env bash

export GPU_FORCE_64BIT_PTR 0
export GPU_MAX_HEAP_SIZE 100
export GPU_USE_SYNC_OBJECTS 1
export GPU_MAX_ALLOC_PERCENT 100
export GPU_SINGLE_ALLOC_PERCENT 100

ethminer --farm-recheck 200 -U -S us1.ethermine.org:4444 -FS eu1.ethermine.org:4444 -O 0x42e02e3110da65ade5990b32fbe1be36e40fa747.rig1
