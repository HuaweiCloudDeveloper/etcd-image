<p align="center">
  <h1 align="center">etcd Distributed Key-Value Storage System</h1>
  <p align="center">
    <a href="README.md"><strong>English</strong></a> | <strong>简体中文</strong>
  </p>
</p>

## Table of Contents

- [Repository Introduction](#repository-introduction)
- [Prerequisites](#prerequisites)
- [Image Specifications](#image-specifications)
- [Getting Help](#getting-help)
- [How to Contribute](#how-to-contribute)

## Repository Introduction
‌[etcd‌](https://github.com/etcd-io/etcd) etcd is an open-source distributed key-value store developed by the CoreOS team and is now a graduated project of the CNCF (Cloud Native Computing Foundation) (on the same level as Kubernetes and Prometheus). It is specifically designed to store and manage critical configuration data in distributed systems, providing strong consistency, high availability, and reliability, and is a core component of cloud-native systems such as Kubernetes.

**Core Features:**
1. Distributed Key-Value Storage: etcd is a high-performance, distributed key-value storage system that organizes data in a tree structure (similar to file system directories) and supports various data formats such as strings, JSON, and YAML. For example, /registry/services/specs/nginx can store configuration information for Kubernetes services. Data is manipulated through gRPC/HTTP APIs, providing strong consistency for read and write operations.
2. Raft Consistency Algorithm: Implements distributed consistency based on the Raft algorithm, where all data changes are synchronized from the Leader node to the Follower nodes, ensuring strong consistency within the cluster. Supports automatic Leader election, log replication, and fault recovery, typically deploying an odd number of nodes (e.g., 3, 5) to tolerate (N-1)/2 node failures.
3. Lease and TTL Mechanism: Provides lease functionality, allowing lifecycle (TTL) binding for key-value pairs, which are automatically deleted upon expiration. For example, Kubernetes uses the Lease mechanism to detect Node heartbeats, automatically triggering Pod reconstruction if a node goes offline. Supports lease renewal (KeepAlive), suitable for service registration, distributed locks, and other scenarios.
4. Transactional Operations: Supports atomic transactions, allowing multiple conditional checks (Compare) and operations (Then/Else) to be combined into a single transaction. For example, IF version=1 THEN update data ELSE fail, avoiding concurrent modification conflicts. Transactions are implemented based on MVCC (Multi-Version Concurrency Control), providing strong isolation.
5. Watch Listening Mechanism: Allows clients to listen for changes (additions, deletions, modifications) to keys or directories, obtaining changes in real-time through an event-driven mechanism. For example, Kubernetes Controllers use Watch etcd to monitor resource state changes, achieving automated coordination of declarative APIs. Supports historical event rollback and breakpoint continuation.
6. Multi-Version Concurrency Control (MVCC): Each modification of a key generates an incrementing version number (Revision), retaining historical version data, and supports querying snapshots by version number. For example, it can retrieve the value of the /foo key at a past moment, suitable for auditing, rollback, and other scenarios. Data compaction can clean up old versions to save space.
7. High Performance and Low Latency: The optimized storage engine (BoltDB) supports tens of thousands of writes per second, with read and write latency in milliseconds. Through batch submission, pipelining, and asynchronous mechanisms, it enhances throughput, suitable as the core metadata storage for systems like Kubernetes.
8. Security and Access Control: Supports TLS encrypted communication, client certificate authentication.

This project offers pre-configured [**`etcd-Distributed Key-Value Storage System`**](https://marketplace.huaweicloud.com/intl/hidden/contents/c21740ee-61b0-43d1-8ff4-0936547c1137)，images with etcd and its runtime environment pre-installed, along with deployment templates. Follow the guide to enjoy an "out-of-the-box" experience.

**Architecture Design:**

![](./images/img.png)

> **System Requirements:**
> - CPU: 4vCPUs or higher
> - RAM: 16GB or more
> - Disk: At least 50GB

## Prerequisites
[Register a Huawei account and activate Huawei Cloud](https://support.huaweicloud.com/usermanual-account/account_id_001.html)

## Image Specifications

| Image Version          | Description | Notes |
|------------------------| --- | --- |
| [etcd3.6.0-arm-v1.0](https://github.com/HuaweiCloudDeveloper/etcd-image/tree/etcd3.6.0-arm-v1.0?tab=readme-ov-file) | Deployed on Kunpeng servers with Huawei Cloud EulerOS 2.0 64bit |  |

## Getting Help
- Submit an [issue](https://github.com/HuaweiCloudDeveloper/etcd-image/issues)
- Contact Huawei Cloud Marketplace product support

## How to Contribute
- Fork this repository and submit a merge request.
- Update README.md synchronously based on your open-source mirror information.