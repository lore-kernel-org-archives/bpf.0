Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9A3624B3
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 15:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252471; cv=none; b=FmTmdlhIunAwr0PlI88T8OTqnIAn8vmOPYNgW8nWjSgdteUNW+qS8EOQpfUuMFUu2n2KL+KnfesZ14hH9DDDSzNxx3QMor0z/KmXfngwdCGTTXMCzzbNoziT8la8sGgQONpW7EmzC64flEoN3MC7c89zKv4u4IZWeMyeCne7pqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252471; c=relaxed/simple;
	bh=yUD4g+SxHKKINML7HkkhW2yjXHQkQkPPLiBpzDnZfJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cKLeNPm6m6/neDEYUuKQJpSVtUF6S3lnwuuEtyJwkJn4dVeTvx56ywmW3v3l4ql3j2jYANm8RyUMmixR4BP0hRVZMr5XZmLdob7gfyvhY6qsM+pHgXs7uppi/5vmz0vhkXN4jgGiBOPD1wSVbmDJyRSLIQl70Bq6eG2liInny30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxM7czTg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxM7czTg"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-837b39eb078so1403863b3a.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252469; x=1778857269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7EGp7niBWwqJ9Vew3F2l6FPvJLRzLHlL4w2Cc5pfngc=;
        b=pxM7czTgbar1H1oMyrxqxw5GRenQ6bOHivjfCUgO0ls1Bvqp4IWUapp1+5yfLgd2dk
         aVmezFnlHj1vb0vhm7Gi8z9/RAlNUMvsHAAVM9OBrB7cjFKcDT12dxVVpYzULfffiUjE
         ogsD4br++6NZHKRYCiEdlaevsU71aTyTYiLwoGMgfLBmhP1gA2SwZ9B0waM7ajeCJ8v2
         XZiaosSh6HDrXFRnPCsOZ5Alndzh5mi1VKytn6J9WqBPZviDZOEwzAVg9scqIJUA8bNu
         KRdkVSpxAt1lKH31Bs3EF5fYdU0DQbvH8lSAhqSBgDf7GCGmsKwssb/74mjO79hNcDs+
         CTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252469; x=1778857269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EGp7niBWwqJ9Vew3F2l6FPvJLRzLHlL4w2Cc5pfngc=;
        b=kcgCGgpYWEeWkgpWgEsef50jS7xaujOF7hgegEKJpARbRNLtXMZizSiFUNbqMd/y6Q
         cRQEFboClFLI+zWr0NRAb7hqNmvG26ntHtZ4cl9jDZp5/kR6fz+yo85Fn7FoFhJ27U9L
         RnUhbq/Rr8jHxcV6tReODsZYljceuNR8051QVbdUaM+qAgIatUzqEoHEJDL7HudkEZWE
         tXJ+o5FuzPeO1FEnE2yUSCK7spPYLVC9vtkH7Xnpkn1d3VupcWNm509svBSI4pxvZ2nx
         bmzZPljamPqIsLMDhU7BxDrqUSjm7cWkzJT7rTFogsgjLdwKBwGEz94qcx5jOV1l2oFF
         NSog==
X-Forwarded-Encrypted: i=1; AFNElJ+nqymvXuv4OxKpN1VhTkIVPQZnViNCndPrmNie5p/YZzOMSZDobFR5t/BI9GCh2+K6JWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzRGBTyMe4PKwdwJgchfbQhaA6Q73VIbF9hp5AaI0rhfq/nuc
	z1CcLByDwlZJvYzqFFunp5E0S/qLnYa09RrlrRY1K8W+h+4VUpXgCSbv
X-Gm-Gg: Acq92OEeMs0nY/Eed7M8voss4eZDDDFcLCWwYoMpYIhjcjCcun9HjW5J2rSxYGPkeN7
	eq2sIBNe+iWDYp3qoiwQ2DWccbSogz1wfL4K6qlTw9vzHN7wb8geQpKlvAS8PwC42zIDaAdNjrB
	3OdAn88IZJaGtiH13YTQZx3CkW3vfY7mPn9lhIv1BxyqqRA+KTZjUCAT84J266ljPJ5gzfs/Rm2
	kXg5hoi4ydxqMucvqF7dZCFFyVVAzhV1hfleSwWAXSP1u5cNa21SsU0zEfcexoXxA0yxhw+MxmC
	2mKkF9sR4MdZJ23wSBUTOdnVc20MISmU/Qevikrc7Td2dPFvgWw8ftnkbDrnYoZEI8gaeC7uRkS
	PVY5RIh59GNtoPgoSfNTRL30dn8DkuItV9zO1SJUkn1wBvHjdKRplyz9NsmtfBdh6utWeFuygeD
	6kFGC1mNmm8xnF/Gk+uoEgMi/xu9W+i1LYHN3ur4oIyl3ZsMU=
X-Received: by 2002:a05:6a00:1ace:b0:82f:9d21:d352 with SMTP id d2e1a72fcca58-83a5bad9376mr12442499b3a.9.1778252468020;
        Fri, 08 May 2026 08:01:08 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945c1bsm13110064b3a.15.2026.05.08.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:07 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	inwardvessel@gmail.com,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	surenb@google.com
Cc: tz2294@columbia.edu,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	laoar.shao@gmail.com,
	gutierrez.asier@huawei-partners.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH v2 0/4] mm: introduce mthp_ext via cgroup-bpf to make mTHP more transparent
Date: Fri,  8 May 2026 23:00:51 +0800
Message-ID: <20260508150055.680136-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

Hi all,

Background
==========

As is well known, a system can simultaneously run multiple different
scenarios. However, THP is not beneficial in every scenario — it is only
most suitable for memory-intensive applications that are not sensitive
to tail latency. For example, Redis, which is sensitive to tail latency,
is not suitable for THP. But in practice, due to Redis issues, the
entire THP functionality is often turned off, preventing other scenarios
from benefiting from it.

There are also some embedded scenarios (e.g. Android) that directly use
2MB THP, where the granularity is too large. Therefore, we introduced
mTHP in v6.8, which supports multiple-size THP. In practice, however, we
still globally fix a single mTHP size and are unable to automatically
select different mTHP sizes based on different scenarios.

After testing, it was found that

- When the system has a lot of free memory, it is normal for Redis to
  use mTHP. performance degradation in Redis only occurs when the system
  is under high memory pressure.
- Additionally, when a large number of small-memory processes use mTHP,
  memory waste is prone to occur, and performance degradation may also
  happen during fast memory allocation/release.

Previously, "Cgroup-based THP control"[1] was proposed, but it had the
following issues.

- It breaks the cgroup hierarchy property.
- Add new THP knobs, making sysadmin's job more complex

Previously, "mm, bpf: BPF-MM, BPF-THP"[2] was proposed, but it had the
following issues.

- It didn't address the issue on the per-process mode.
- For global mode, the prctl(PR_SET_THP_DISABLE) has already achieved
  the same objective, there is no need to add two mechanisms for the
  same purpose.
- Attaching st_ops to mm_struct, the same issues that cgroup-bpf once
  faced are likely to arise again, e.g. lifetime of cgroup vs bpf, dying
  cgroups, wq deadlock, etc. It is recommended to use cgroup-bpf for
  implementation.
- Unclear ABI stability guarantees.
- The test cases are too simplistic, lacking eBPF cases similar to real
  workloads such as sched_ext.

If I miss some thing, please let me know. Thanks!

Solution
========

This series will solve all the problems mentioned above.

1. Using cgroup-bpf to customize mTHP size for different scenarios
2. Use a cgroup eBPF program to monitor all sub-cgroups. Sub-cgroups
   under the same parent-cgroup adopt the same eBPF program. Only multiple
   sibling-cgroups (where the parent-cgroup has no attached eBPF program)
   are supported to attach multiple different eBPF programs without
   breaking the hierarchy property of the cgroup.
3. Automatically select different mTHP sizes for different cgroups,
   let's focus on making them truly transparent.
4. Design mthp_ext case to address real workload issues and further
   clear/stabilize the ABI.

The main functions of the mthp_ext are as follows:

- When sub-cgroup is under high memory pressure (default, full 100ms 1s),
  it will automatically fallback to using 4KB.
- When the anon+shmem memory usage of sub-cgroup falls below the minimum
  memory (default 16MB), small-memory processes will automatically
  fallback to using 4KB.
- Under normal conditions, when there is no memory pressure and the
  anon+shmem memory usage exceeds the minimum memory, all mTHP sizes
  shall be utilized by kernel.
- Monitor the root-cgroup (/sys/fs/cgroup) directory by default, with
  support for specifying any cgroup directory.

Performance
===========

The below is some performance test results, testing on x86_64 machine
(AMD Ryzen9 9950X 16C32T, 32G memory, 8G zram).

NOTE: The following always/never labels indicate setting all mTHP sizes
to always/never. Detailed test script reference[4].

redis results
~~~~~~~~~~~~~

command: redis-benchmark --csv -r 3000000 -n 3000000 -d 1024 -c 16 -P 32 -t set

When cgroup memory.high=max, no memory pressure, seems only noise level
changes, mthp_ext no regression.

| redis-noBGSAVE | always      | never                | always+mthp_ext     |
|----------------|-------------|----------------------|---------------------|
| rps            | 1431307.083 | 1224004.250 (-14.5%) | 1420053.873 (-0.8%) |
| avg_latency_ms | 0.216       | 0.256       (-18.5%) | 0.218       (-0.9%) |
| p95_latency_ms | 0.612       | 0.708       (-15.7%) | 0.615       (-0.5%) |
| p99_latency_ms | 0.682       | 0.812       (-19.1%) | 0.692       (-1.5%) |

| redis-BGSAVE   | always      | never                | always+mthp_ext    |
|----------------|-------------|----------------------|--------------------|
| rps            | 1429093.707 | 1231569.587 (-13.8%) | 1431075.330 (0.1%) |
| avg_latency_ms | 0.216       | 0.255       (-18.1%) | 0.216       (0.0%) |
| p95_latency_ms | 0.618       | 0.706       (-14.2%) | 0.615       (0.5%) |
| p99_latency_ms | 0.684       | 0.823       (-20.3%) | 0.684       (0.0%) |

When cgroup memory.high=2G, high memory pressure, mthp_ext RPS improve by
3450%, while significantly reducing the tail latency by 99%.

| redis-noBGSAVE | always    | never                | always+mthp_ext      |
|----------------|-----------|----------------------|----------------------|
| rps            | 24932.790 | 976610.893 (3817.0%) | 885337.250 (3450.9%) |
| avg_latency_ms | 13.173    | 0.326        (97.5%) | 0.367        (97.2%) |
| p95_latency_ms | 23.028    | 0.786        (96.6%) | 1.511        (93.4%) |
| p99_latency_ms | 366.762   | 1.183        (99.7%) | 2.975        (99.2%) |

| redis-BGSAVE   | always    | never                 | always+mthp_ext      |
|----------------|-----------|-----------------------|----------------------|
| rps            | 50551.567 | 1026720.293 (1931.0%) | 892643.707 (1665.8%) |
| avg_latency_ms | 6.581     | 0.310         (95.3%) | 0.365        (94.5%) |
| p95_latency_ms | 16.730    | 0.772         (95.4%) | 1.447        (91.4%) |
| p99_latency_ms | 311.551   | 1.140         (99.6%) | 2.988        (99.0%) |

unixbench results
~~~~~~~~~~~~~~~~~

command: ./Run -c 1 shell8

mthp_ext improved by 5.99%.

| unixbench shell8 | always  | never           | always+mthp_ext |
|------------------|---------|-----------------|-----------------|
| Score            | 22916.8 | 24304.0 (6.05%) | 24289.9 (5.99%) |

kernbench results
~~~~~~~~~~~~~~~~~

When cgroup memory.high=max, no memory pressure, seems only noise level
changes, mthp_ext no regression.

                            always                 never               always+mthp_ext
Amean     user-32    19702.39 (   0.00%)    18428.90 *   6.46%*    19706.73 (  -0.02%)
Amean     syst-32     1159.55 (   0.00%)     2252.43 * -94.25%*     1177.48 *  -1.55%*
Amean     elsp-32      703.28 (   0.00%)      699.10 *   0.59%*      703.99 *  -0.10%*
BAmean-95 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
BAmean-95 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
BAmean-95 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)
BAmean-99 user-32    19701.79 (   0.00%)    18425.01 (   6.48%)    19704.78 (  -0.02%)
BAmean-99 syst-32     1159.43 (   0.00%)     2251.86 ( -94.22%)     1177.03 (  -1.52%)
BAmean-99 elsp-32      703.24 (   0.00%)      698.99 (   0.61%)      703.88 (  -0.09%)

When cgroup memory.high=2G, high memory pressure, mthp_ext improved by 26%.

                            always                 never               always+mthp_ext
Amean     user-32    20250.65 (   0.00%)    18368.91 *   9.29%*    18681.27 *   7.75%*
Amean     syst-32    12778.56 (   0.00%)     9636.99 *  24.58%*     9392.65 *  26.50%*
Amean     elsp-32     1377.55 (   0.00%)     1026.10 *  25.51%*     1019.40 *  26.00%*
BAmean-95 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
BAmean-95 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
BAmean-95 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)
BAmean-99 user-32    20233.75 (   0.00%)    18353.57 (   9.29%)    18678.01 (   7.69%)
BAmean-99 syst-32    12543.21 (   0.00%)     9612.28 (  23.37%)     9386.83 (  25.16%)
BAmean-99 elsp-32     1367.82 (   0.00%)     1023.75 (  25.15%)     1018.17 (  25.56%)

TODO
====

- mthp_ext handles different "enum tva_type" values. For example, for
  small-memory processes, only 4KB is used in TVA_PAGEFAULT, while
  TVA_KHUGEPAGED/TVA_FORCED_COLLAPSE continues to collapse all mthp
  size. Under high memory pressure, only 4KB is used for
  TVA_PAGEFAULT/TVA_KHUGEPAGED, while TVA_FORCED_COLLAPSE continues to
  collapse all mthp size.
- selftest

If there are additional scenarios, please let me know as well, so I can
conduct further prototype verification tests to make mTHP more
transparent and further clear/stabilize the BPF-THP ABI.

If any of the above the strategies can be integrated into the kernel,
please let me know. I would be delighted to incorporate these strategies
into the kernel.

This series is based on mm-new + "mm: BPF OOM"[3] first four patches.

Thank you very much for your comments and discussions.

[1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com
[2] https://lore.kernel.org/linux-mm/20251026100159.6103-1-laoar.shao@gmail.com
[3] https://lore.kernel.org/linux-mm/20260127024421.494929-1-roman.gushchin@linux.dev
[4] https://github.com/vernon2gh/app_and_module/tree/main/mthp_ext

V1 -> V2:
- Rebase on mm-new, run all performance tests again.
- Register eBPF programs only when no mthp_ops exists in all sub-cgroup, do not
  destroy the cgroup hierarchy property.
- Fix newly created cgroups silently bypass the hierarchical BPF mTHP policy.
- Fix bpf_mthp_choose() UAF due to improper SRCU locking.
- Add bounds check in bpf_cgroup_stall() and fix return type to u64.
- Check cgroup_psi() return value.
- Fix spurious mTHP fallback during initial cgroup scan due to zero-init
  info->stall.
- Fix info->order being set to 0 when no processes are running in the cgroup.
- Fix Compilation fails when CONFIG_CGROUPS=y && CONFIG_PSI=n.
- Fix NULL pointer dereference of st_link.
- FIx infinite loop in trigger_scan() when read() returns an error.
- Fix integer overflow in FROM_MB() macro.
- Fix setup_psi_trigger() fail, but masks the error code.

V1 : https://lore.kernel.org/linux-mm/20260503165024.1526680-1-vernon2gm@gmail.com/

Vernon Yang (4):
  psi: add psi_group_flush_stats() function
  bpf: add bpf_cgroup_{flush_stats,stall} function
  mm: introduce bpf_mthp_ops struct ops
  samples: bpf: add mthp_ext

 MAINTAINERS                     |   3 +
 include/linux/bpf_huge_memory.h |  52 +++++
 include/linux/cgroup-defs.h     |   1 +
 include/linux/huge_mm.h         |   6 +
 include/linux/psi.h             |   5 +
 kernel/bpf/helpers.c            |  34 ++++
 kernel/cgroup/cgroup.c          |   2 +
 kernel/sched/psi.c              |  34 +++-
 mm/Kconfig                      |  14 ++
 mm/Makefile                     |   1 +
 mm/bpf_huge_memory.c            | 168 ++++++++++++++++
 samples/bpf/.gitignore          |   1 +
 samples/bpf/Makefile            |   7 +-
 samples/bpf/mthp_ext.bpf.c      | 148 ++++++++++++++
 samples/bpf/mthp_ext.c          | 339 ++++++++++++++++++++++++++++++++
 samples/bpf/mthp_ext.h          |  30 +++
 16 files changed, 836 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/bpf_huge_memory.h
 create mode 100644 mm/bpf_huge_memory.c
 create mode 100644 samples/bpf/mthp_ext.bpf.c
 create mode 100644 samples/bpf/mthp_ext.c
 create mode 100644 samples/bpf/mthp_ext.h

--
2.53.0

