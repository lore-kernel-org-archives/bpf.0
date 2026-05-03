Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27B2F2914
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827053; cv=none; b=GrGhqQoTF4ZNF3wNMPRFMtm+2g88JX6AYB+OcV8XrwxyYM5mGbla37eVeFXESGtom/1iziCuscBtU2bR8NzvkWrFvsMoQpINycQZXuTQWM7X54m257Qt3Z4CE6ZP16WZGNwmIwac1uzNBe6zqHFuqMqa0gtmmlgiTkcsFbXxU+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827053; c=relaxed/simple;
	bh=EvTSV0gLgu8GLRzob+OE79Vx8RCDYuUqhgqfqhKXQ1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g51Rf0w72ZlLnzuJOXrjRZMvkvXLFxIS/NHQR7BdLdDVxp7v14ThYzKYHbmR+00bxt3QY66Krjcx9mgFRemN4jYnZL6XCv6W7iqpX87obJHYNDt0wKr7KMPDdG9ZqxqZaAH1O6CyBKqYovWlJ7cb4keRVZ7vMjfZrVwtFKOxbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r37hz/e5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r37hz/e5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1970683a12.3
        for <bpf@vger.kernel.org>; Sun, 03 May 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777827051; x=1778431851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TS2sd/8o5RJAjVUI5sxoWuY3InAZTHu0PH6QjJRWXc8=;
        b=r37hz/e5GJm79PmyMroseSFsf0sayB+iLDug2qMbWvJMK77z7d4hTtpV+0QKEm8eje
         6FxOH1KNVVaSShkuYo1rF/ZE+tdNzXLV2bv0KlUKPvVfDQaL7MbP6o7E850GQunCJNOi
         zG5rDVMmM7Z1zO30RYel8Jqouz7MJ5rTODoJsBJgj4EZ3ole77yasMlRERN6r3wUcyho
         v3NdwIKoMDWN2pJmvKIUwPLcWsigWWxFkxfUDbggkxNe8DNb0rJZMSc0VliuS5KGaKWo
         jHMp8PlZe4osrqw8cxTWupyKYlD+aKL/OXrM3e6du1k6Bg8HBsN0jrCePm1XBY1y6aoP
         nXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827051; x=1778431851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TS2sd/8o5RJAjVUI5sxoWuY3InAZTHu0PH6QjJRWXc8=;
        b=rJWOFOiu68QR2809Wm9X9CA16vYqF3j8Eg/+aIW1MRyNfd4axRH500DUM9uT7EhrD/
         Z/fnaYq9G7gMfokPdVYm9GZk3v96Hnf4kpnqD0SzolwCwvbdQwECCiNe4lt6K7R4/1fA
         S7L9I9BJzSLxDaVwrYwxqWSKkbhqdHYpYTAgmR+MK6PxLF2spCaCGgJ8WXMoJ7RDHDe8
         vz8ABVmE+qTP1RIpBoEKQ3k2WlQQeHldOy+kSaEWIf9VK3PDpZ/eO8j1jRr3dwU9hEht
         mwLfIO6BjBr/Y+VmQSSlYF7rxMgfmIuN2goqgCvShUxl6ZcVGP9Q2qeAFQLsX8xb8ERh
         n7EA==
X-Forwarded-Encrypted: i=1; AFNElJ/oyYSZRo/ZlSk0PK0qbdXL1MwSqYN2mlXetrRpNCatQQHHezyYoRetEJv8p62EAJF7/iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPikkK6eY9BOJ1TmIR4zldbSNzpdEqDo6bxAMJ8xGZ+7IGSIlO
	5GQSxGX5BUQGBx0WU7mP3Kxcfx4ETGb9sq6M5SEG8aLKAdRXYQaWVtRR
X-Gm-Gg: AeBDietWblQuihQqVdLxprC0Fl6noGbDG9yjtdv419J40X+S8xh5/aZN+46MvQ/3ryi
	w9AbSGIab+NGuYq51K3FDiSCMO+dhfGkRaBDFs4ODZuUtafxWQda1QTTFqbZNS8LheEeQuRY0DW
	Qn6DUEP04/+vu6NIsoB0wZAyRS1tuwhO+Jut/WiG7tYGp2xzpT/2YRga77Uwm6/A9/p+0xoxWGT
	Z3UTX1uAf+EteVQcOV0Df18UQ6eMzsPzXngyIaJr/sgW3Z96e5vkDoglgAS8ZO3fLlRTxFALfy4
	yRq/3L4yyhF90Q3KbV7+GHt8pkJOfhY/gJ1KHmtsCqu/DFhLn4pSpmxJ64ifqtYV/U78kp59u/S
	4HRDDK+apqJXOG6SXtWczpiPqdCvtHQW2qe+yzedX2nXsHT/UBSCsu8dV6xbzC6iro7iKrS3bVi
	VKisr2WQ5/bL8fO3t7jiv3tW45zVVPOY4YhGIN3oPfac3ZLiA=
X-Received: by 2002:a05:6a20:7491:b0:3a2:d838:bfdb with SMTP id adf61e73a8af0-3a7f1f1de5amr6999048637.29.1777827051325;
        Sun, 03 May 2026 09:50:51 -0700 (PDT)
Received: from localhost.localdomain ([114.231.84.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83707fab756sm1494277b3a.44.2026.05.03.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:50:50 -0700 (PDT)
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
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	baohua@kernel.org,
	lance.yang@linux.dev,
	dev.jain@arm.com,
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: [PATCH 0/4] mm: introduce mthp_ext via cgroup-bpf to make mTHP more transparent
Date: Mon,  4 May 2026 00:50:20 +0800
Message-ID: <20260503165024.1526680-1-vernon2gm@gmail.com>
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
4. Design mthp_ext case to address real workload issues.

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

When cgroup memory.high=max.

| redis-noBGSAVE | always      | never                | always+mthp_ext      |
|----------------|-------------|----------------------|----------------------|
| rps            | 1410824.167 | 1210387.500 (-14.2%) | 1265659.833 (-10.3%) |
| avg_latency_ms | 0.220       | 0.259       (-17.7%) | 0.247       (-12.3%) |
| p95_latency_ms | 0.618       | 0.708       (-14.6%) | 0.676       (-9.40%) |
| p99_latency_ms | 0.687       | 0.818       (-19.1%) | 0.756       (-10.0%) |

| redis-BGSAVE   | always      | never                | always+mthp_ext      |
|----------------|-------------|----------------------|----------------------|
| rps            | 1418032.127 | 1212306.873 (-14.5%) | 1261069.373 (-11.1%) |
| avg_latency_ms | 0.218       | 0.259       (-18.8%) | 0.248       (-13.8%) |
| p95_latency_ms | 0.620       | 0.714       (-15.2%) | 0.687       (-10.8%) |
| p99_latency_ms | 0.684       | 0.828       (-21.1%) | 0.756       (-10.5%) |

When cgroup memory.high=2G.

| redis-noBGSAVE | always    | never                 | always+mthp_ext       |
|----------------|-----------|-----------------------|-----------------------|
| rps            | 24813.980 | 1049254.583 (4128.5%) | 1063171.270 (4184.6%) |
| avg_latency_ms | 13.317    | 0.302       (  97.7%) | 0.298       (  97.8%) |
| p95_latency_ms | 23.220    | 0.754       (  96.8%) | 0.828       (  96.4%) |
| p99_latency_ms | 369.492   | 1.154       (  99.7%) | 1.615       (  99.6%) |

| redis-BGSAVE   | always    | never                 | always+mthp_ext       |
|----------------|-----------|-----------------------|-----------------------|
| rps            | 48373.433 | 1058403.500 (2088.0%) | 1070805.707 (2113.6%) |
| avg_latency_ms | 6.884     | 0.300       (  95.6%) | 0.296       (  95.7%) |
| p95_latency_ms | 16.474    | 0.743       (  95.5%) | 0.820       (  95.0%) |
| p99_latency_ms | 326.058   | 1.170       (  99.6%) | 1.586       (  99.5%) |

When the redis is under no memory pressure, RPS drops by 10.3% (from 1.4M to
1.2M, Is this within the acceptable range?).

However, under high memory pressure, RPS improve by 4184.6% (from 24K to 1M),
while significantly reducing the tail latency by 99%.

unixbench results
~~~~~~~~~~~~~~~~~

command: ./Run -c 1 shell8

| unixbench shell8 | always  |      never      | always+mthp_ext |
|------------------|---------|-----------------|-----------------|
| Score            | 23019.4 | 24378.3 (5.90%) | 24314.5 (5.63%) |

mthp_ext improved by 5.63%.

kernbench results
~~~~~~~~~~~~~~~~~

When cgroup memory.high=max, mthp_ext no regression.

                            always                 never               always+mthp_ext
Amean     user-32    19666.44 (   0.00%)    18464.56 *   6.11%*    19650.13 *   0.08%*
Amean     syst-32     1169.16 (   0.00%)     2235.17 * -91.18%*     1169.42 (  -0.02%)
Amean     elsp-32      702.51 (   0.00%)      699.90 *   0.37%*      702.15 (   0.05%)
BAmean-95 user-32    19665.93 (   0.00%)    18461.86 (   6.12%)    19647.61 (   0.09%)
BAmean-95 syst-32     1168.68 (   0.00%)     2234.27 ( -91.18%)     1169.20 (  -0.04%)
BAmean-95 elsp-32      702.34 (   0.00%)      699.80 (   0.36%)      702.04 (   0.04%)
BAmean-99 user-32    19665.93 (   0.00%)    18461.86 (   6.12%)    19647.61 (   0.09%)
BAmean-99 syst-32     1168.68 (   0.00%)     2234.27 ( -91.18%)     1169.20 (  -0.04%)
BAmean-99 elsp-32      702.34 (   0.00%)      699.80 (   0.36%)      702.04 (   0.04%)

When cgroup memory.high=2G, mthp_ext improved by 20.98%.

                            always                 never               always+mthp_ext
Amean     user-32    20459.89 (   0.00%)    18517.24 *   9.49%*    19963.73 *   2.43%*
Amean     syst-32    11890.63 (   0.00%)     6681.95 *  43.80%*     9395.94 *  20.98%*
Amean     elsp-32     1305.29 (   0.00%)      928.13 *  28.89%*     1109.37 *  15.01%*
BAmean-95 user-32    20439.38 (   0.00%)    18510.65 (   9.44%)    19957.89 (   2.36%)
BAmean-95 syst-32    11789.99 (   0.00%)     6679.03 (  43.35%)     9381.77 (  20.43%)
BAmean-95 elsp-32     1302.18 (   0.00%)      927.89 (  28.74%)     1108.65 (  14.86%)
BAmean-99 user-32    20439.38 (   0.00%)    18510.65 (   9.44%)    19957.89 (   2.36%)
BAmean-99 syst-32    11789.99 (   0.00%)     6679.03 (  43.35%)     9381.77 (  20.43%)
BAmean-99 elsp-32     1302.18 (   0.00%)      927.89 (  28.74%)     1108.65 (  14.86%)

TODO
====

- Do not destroy the cgroup hierarchy property. If an eBPF program
  already exists in the sub-cgroup, trigger an error and clear the
  already set bpf_mthp_ops data.
- mthp_ext handles different "enum tva_type" values. For example, for
  small-memory processes, only 4KB is used in TVA_PAGEFAULT, while
  TVA_KHUGEPAGED/TVA_FORCED_COLLAPSE continues to collapse all mthp
  size. Under high memory pressure, only 4KB is used for
  TVA_PAGEFAULT/TVA_KHUGEPAGED, while TVA_FORCED_COLLAPSE continues to
  collapse all mthp size.
- selftest

If there are additional scenarios, please let me know as well, so I can
conduct further prototype verification tests to make mTHP more
transparent.

If any of the above the strategies can be integrated into the kernel,
please let me know. I would be delighted to incorporate these strategies
into the kernel.

This series is based on linux v7.1-rc1 (26fd6bff2c05) + "mm: BPF OOM"[3]
first four patches.

Thank you very much for your comments and discussions.

[1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com
[2] https://lore.kernel.org/linux-mm/20251026100159.6103-1-laoar.shao@gmail.com
[3] https://lore.kernel.org/linux-mm/20260127024421.494929-1-roman.gushchin@linux.dev
[4] https://github.com/vernon2gh/app_and_module/tree/main/mthp_ext

Vernon Yang (4):
  psi: add psi_group_flush_stats() function
  bpf: add bpf_cgroup_{flush_stats,stall} function
  mm: introduce bpf_mthp_ops struct ops
  samples: bpf: add mthp_ext

 MAINTAINERS                     |   3 +
 include/linux/bpf_huge_memory.h |  35 ++++
 include/linux/cgroup-defs.h     |   1 +
 include/linux/huge_mm.h         |   6 +
 include/linux/psi.h             |   1 +
 kernel/bpf/helpers.c            |  29 +++
 kernel/sched/psi.c              |  34 +++-
 mm/Kconfig                      |  14 ++
 mm/Makefile                     |   1 +
 mm/bpf_huge_memory.c            | 169 ++++++++++++++++
 samples/bpf/.gitignore          |   1 +
 samples/bpf/Makefile            |   7 +-
 samples/bpf/mthp_ext.bpf.c      | 142 +++++++++++++
 samples/bpf/mthp_ext.c          | 340 ++++++++++++++++++++++++++++++++
 samples/bpf/mthp_ext.h          |  30 +++
 15 files changed, 804 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/bpf_huge_memory.h
 create mode 100644 mm/bpf_huge_memory.c
 create mode 100644 samples/bpf/mthp_ext.bpf.c
 create mode 100644 samples/bpf/mthp_ext.c
 create mode 100644 samples/bpf/mthp_ext.h

--
2.53.0

