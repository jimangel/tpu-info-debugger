# TPU debug container

`tpu-info` installed in a container.

Why? You might want to run on a TPU machine with or without access to pip (Cloud NAT / private nodes).

## Running

```
TPU_NODE_NAME=$(kubectl get nodes -l cloud.google.com/gke-tpu-accelerator -o name | head -n 1 | cut -d'/' -f2)

kubectl debug node/${TPU_NODE_NAME} -it \
  --image=ghcr.io/jimangel/tpu-info-debugger:1764781170 \
  --profile=sysadmin \
  -- tpu-info
```

Sample output:

```
Libtpu version: unknown (libtpu not found)                                      
Accelerator type: v6e                                                           
                                                                                
TPU Chips                                      
┏━━━━━━━━━━━━━┳━━━━━━━━━━━━━━┳━━━━━━━━━┳━━━━━━┓
┃ Chip        ┃ Type         ┃ Devices ┃ PID  ┃
┡━━━━━━━━━━━━━╇━━━━━━━━━━━━━━╇━━━━━━━━━╇━━━━━━┩
│ /dev/vfio/0 │ TPU v6e chip │ 1       │ None │
│ /dev/vfio/1 │ TPU v6e chip │ 1       │ None │
│ /dev/vfio/2 │ TPU v6e chip │ 1       │ None │
│ /dev/vfio/3 │ TPU v6e chip │ 1       │ None │
└─────────────┴──────────────┴─────────┴──────┘
╭───────────────────────── Runtime Utilization Status ─────────────────────────╮
│ WARNING: Libtpu metrics unavailable. Is there a framework using the TPU? See │
│ tpu_info docs for more information.                                          │
╰──────────────────────────────────────────────────────────────────────────────╯
TPU Runtime Utilization                
┏━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Chip ┃ HBM Usage (GiB) ┃ Duty cycle ┃
┡━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━┩
│ 0    │ N/A             │ N/A        │
│ 1    │ N/A             │ N/A        │
│ 2    │ N/A             │ N/A        │
│ 3    │ N/A             │ N/A        │
└──────┴─────────────────┴────────────┘
╭─────────────────────── Buffer Transfer Latency Status ───────────────────────╮
│ WARNING: Buffer Transfer Latency metrics unavailable. Did you start a        │
│ MULTI_SLICE workload with `TPU_RUNTIME_METRICS_PORTS=8431,8432,8433,8434`?   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭──────────────────────── gRPC TCP Minimum RTT Status ─────────────────────────╮
│ WARNING: gRPC TCP Minimum RTT metrics unavailable. Did you start a           │
│ MULTI_SLICE workload with `TPU_RUNTIME_METRICS_PORTS=8431,8432,8433,8434`?   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────── gRPC TCP Delivery Rate Status ────────────────────────╮
│ WARNING: gRPC TCP Delivery Rate metrics unavailable. Did you start a         │
│ MULTI_SLICE workload with `TPU_RUNTIME_METRICS_PORTS=8431,8432,8433,8434`?   │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## Building

```
export REPO="repo/image:tag"
docker buildx build --platform linux/amd64 -t "${REPO}" --push . 
```
