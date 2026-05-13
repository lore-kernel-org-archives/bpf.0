Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B5B5A79B
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711823; cv=none; b=C3MjkMesxBmKZ5BwOVX06Ro1iEVQDTro+YUo7OM1rS/q0wwQ38DmAibNQup/puOyZUafi1dWm/cM3DLJavH775RNHIB46bR9j8Ek3v+KIVkccRa2JZJQMIxYTPnhzhIfhLNRmdaazbanjLq2ctTTmnY0oyTbT5fGmq39ybsKC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711823; c=relaxed/simple;
	bh=Y5UKRq1NHmjJ/SW5pWOpnBwwq/ZJd5BXDVoZDbdsQ/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bSoKnPjUECyhsFWAWqSGHrhalZ0HGxPsG9hQ1qhkG1n6reI94TmKWwdjl+gWA7UZ2gdo6dBPxKGq1loyXXQH5v8R3zovE3wxkDNEP/b7p+13OVCSWjVDMAPqvsXsO3bru5StJXE/ziyAtkHWE38C26q6/2qGu1i4pzELq4KDOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFt9v/rh; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFt9v/rh"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891b0786beso46495565e9.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711820; x=1779316620; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnp1/jJdeEuHw4WnmTGYFT3ehiL7JWHo+Hp9K8NGoP4=;
        b=AFt9v/rhusVXTsSgKU7IoE1F9DtXfghN/qg2M4blP0YbjgOUPQrOskQYG0Nb30nxKa
         U0b7HqzoaI3j7biIOsjHjgpehG6VYAp6lVSpDmwL9rDXnf0jAY09f66eCpKnL5R9odyv
         QZXDBW/J4Z9bn7sDZhxga63bUpxvQYbMiRFUGRbAMNlslmjyLBmL62KAWF4PpUm2tFWw
         dsvzAGQ5tjRBZd3scAeb+AhXMxQpMaNyQM7cWBmqx0Gip78+5oXETTl5dux8UmeVGC4D
         EbG/gUqgMc++Ddalpw0bVNkM+HrR3nr0A+pNYhjyHe49rAWD4Y1AkHSj4DMXRVXJl7m5
         PJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711820; x=1779316620;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dnp1/jJdeEuHw4WnmTGYFT3ehiL7JWHo+Hp9K8NGoP4=;
        b=WUyYsnGY5tZVS4tNzunD5dHQRiHFo0F5XIxD8mkz9PeBjQD3cJJQyITUArZGmdoqkW
         6iNQqrpJJar+LyNtCm56jt8UKcKChnJ97PPL5PF52oLpaX3No3kR77w5yirOCJI/QsqD
         hpLjssKxtd2hV5CDI2HAoTmvDTjJS5obH6Z0NKYnVAbT66boX8iAw8CaMSlYIs2Xr1XS
         9CJZyXwGWjTbCf57d4ilGF0AD/zUOmXcHuM5goUstarpDsgMWnSd86tNHLUTE4GwXuSh
         Cv9VxlFoNigPuupjIOXF4L2IV/6OsZQ2OOHDn5FzuwnMGaY0hi8MqFoC++RMeE8cFXnD
         EpXw==
X-Gm-Message-State: AOJu0YwghKbP5ytP11eRDwSOoGESg92LxriziZfyqEmjMxeDT9OjAakz
	acFFnrCDY0D7TZxpzBSHX0Azh1XW5MFjvmcnwcjKPLpXhsx9T+44Pd16
X-Gm-Gg: Acq92OHc0jQOjVrXlVtqcEMit4ABhWFwqUD09k7qemC0qgCubvLROH6duVXc+TrQWEl
	OCFT1UnY1Dam9f7JM/In6Xra8swqOASx7anU5Am/jc994QJNE7mlqRNA1zObvb9PyAZtv+qrgph
	jUpJE0g+sm20loPy1ZWTFx5+Dy54aTWc/j4ofWqPp20/fJQcNYzwrzkvzc58pfrjNp2QGA7w7jW
	Gi/DMgiKlflHVDv62MC5MCP+49prTwx7q4f7JX3MkOHqtmYMa++ldzaR0PvT0zQHgrafnZZBxiK
	S+YR3P40cBzrLeXoAaqNRFb5z/oKMOHQV8h78d3A874ZIJP0ntnVkNT41boufW/gBLRMSZ6n0pX
	6xJDod9mGAAI2cprmfzjKayo81bNYp63yx+mNTSv6jNCLUPW3UXHfibAe+ELcXauXNI3NhtORFZ
	4YC/Tp/zbMI6H3
X-Received: by 2002:a05:600c:8705:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48fce9c731dmr79225495e9.9.1778711819981;
        Wed, 13 May 2026 15:36:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64da1absm32466115e9.14.2026.05.13.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:36:58 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v4 00/11] bpf: Introduce resizable hash map
Date: Wed, 13 May 2026 15:36:03 -0700
Message-Id: <20260513-rhash-v4-0-dd3d541ccb0b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANP8BGoC/13NQQ6CMBCF4as0s6ZmOi1FWHkP46LQQboQSEsIh
 nB3I5FoXL98/1shcQycoBIrRJ5DCkMPlTCZgKZz/Z1l8FAJIKRcKdQydi51sqgLRFuWpP0ZMgF
 j5DYse+cK9djKnpcJbpmALqRpiM/9YFb7TkgWCfNPa1YSpUbvrbe6MZYuD57cqRkee2CmLzJ4P
 hC9Ua1tkXunWst/SP8gMgfSEqXH1mHDRhdl/YO2bXsBOjgBoQ0BAAA=
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778711817; l=10285;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Y5UKRq1NHmjJ/SW5pWOpnBwwq/ZJd5BXDVoZDbdsQ/w=;
 b=TdDSVkkByNCfJO3GnIQ1Z82O1JdZV/MJ/pMRHGEpp17j2b6LP2E1vOMfRR/MEoMOcWyRFaE4I
 9arRyvKKxZNDxPxyeZG7ILYTkItRZny9FYohHfrWl3RgWSXNkjw6dX1
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This patch series introduces BPF_MAP_TYPE_RHASH, a new hash map type that
leverages the kernel's rhashtable to provide resizable hash map for BPF.

The existing BPF_MAP_TYPE_HASH uses a fixed number of buckets determined at
map creation time. While this works well for many use cases, it presents
challenges when:

1. The number of elements is unknown at creation time
2. The element count varies significantly during runtime
3. Memory efficiency is important (over-provisioning wastes memory,
 under-provisioning hurts performance)

BPF_MAP_TYPE_RHASH addresses these issues by using rhashtable, which
automatically grows and shrinks based on load factor.

The implementation wraps the kernel's rhashtable with BPF map operations:

- Uses bpf_mem_alloc for RCU-safe memory management
- Supports all standard map operations (lookup, update, delete, get_next_key)
- Supports batch operations (lookup_batch, lookup_and_delete_batch)
- Supports BPF iterators for traversal
- Supports BPF_F_LOCK for spin locks in values
- Requires BPF_F_NO_PREALLOC flag (elements allocated on demand)
- In-place updates for improved performance.
- max_entries serves as a hard limit, not bucket count
- Uses bit_spin_lock() + local_irq_save() for bucket locking,
similar to existing BPF hashmap's raw_spin_lock_irqsave(), insertions and
deletes may fail.
- Iterations are best-effort, if resize, insertions, deletions take place
concurrently, iterations may visit same elements multiple times or skip
elements.
- Lock out insertions, when running special fields destructor to guarantee
its completion.

The series includes comprehensive tests:
- Basic operations in test_maps (lookup, update, delete, get_next_key)
- BPF program tests for lookup/update/delete semantics
- Seq file tests

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Update implementation
---------------------
Current implementation of the BPF_MAP_TYPE_RHASH does not provide
the same strong guarantees on the values consistency under concurrent
reads/writes as BPF_MAP_TYPE_HASH.
BPF_MAP_TYPE_HASH allocates a new element and atomically swaps the
pointer. BPF_MAP_TYPE_RHASH does memcpy in place with no lock held.
rhash trades consistency for speed, concurrent readers can observe
partially updated data. Two concurrent writers to the same key can
also interleave, producing mixed values. This is similar to arraymap
update implementation, including handling of the special fields.
As a solution, user may use BPF_F_LOCK to guarantee consistent reads
and write serialization.

Summary of the read consistency guarantees:

  map type     |  write mechanism |  read consistency
  -------------+------------------+--------------------------
  htab         |  alloc, swap ptr |  always consistent (RCU)
  htab  F_LOCK |  in-place + lock |  consistent if reader locks
  -------------+------------------+--------------------------
  rhtab        |  in-place memcpy |  torn reads
  rhtab F_LOCK |  in-place + lock |  consistent if reader locks

Benchmarks
----------
1. LOOKUP  (single producer, M events/sec)
  key | max | nr    |    htab |   rhtab | ratio | delta
  ----+-----+-------+---------+---------+-------+-------
    8 |  1K |   750 |   99.85 |   81.92 | 0.82x |  -18 %
    8 |  1K |    1K |  100.71 |   80.19 | 0.80x |  -20 %
    8 |  1M |  750K |   23.37 |   72.09 | 3.08x | +208 %
    8 |  1M |    1M |   13.39 |   53.72 | 4.01x | +301 %
   32 |  1K |   750 |   51.57 |   42.78 | 0.83x |  -17 %
   32 |  1K |    1K |   50.81 |   45.83 | 0.90x |  -10 %
   32 |  1M |  750K |   11.27 |   15.29 | 1.36x |  +36 %
   32 |  1M |    1M |    7.32 |    8.75 | 1.19x |  +19 %
  256 |  1K |   750 |    7.58 |    7.88 | 1.04x |   +4 %
  256 |  1K |    1K |    7.43 |    7.81 | 1.05x |   +5 %
  256 |  1M |  750K |    3.69 |    4.27 | 1.16x |  +16 %
  256 |  1M |    1M |    2.60 |    3.12 | 1.20x |  +20 %

Pattern:
  * Small map (1K): htab wins for 8 / 32 byte keys by 10-20 %
    because the preallocated bucket array fits in L1.  Equalises
    at 256 byte keys.
  * Large map (1M): rhtab wins everywhere, up to 4x at high load
    factor with 8 byte keys.
  * Higher load factor amplifies rhtab's lead: rhtab grows the
    bucket array; htab stays at user-declared max.

2. FULL UPDATE  (M events/sec per producer, -p 7)

  htab  per-producer:
    20.33   22.02   19.27   23.61   24.18   23.17   21.07
    mean  21.94   range  19.27 - 24.18

  rhtab per-producer:
   133.51  129.47   74.52  129.29  102.26  129.98  107.64
    mean 115.24   range  74.52 - 133.51

  speedup (mean): 5.25x   (+425 %)

In-place memcpy avoids the per-update alloc + RCU pointer swap
that htab pays.

3. MEMORY  (overwrite, -p 8, no --preallocated)

  value_size |  htab ops/s | rhtab ops/s | htab mem | rhtab mem
  -----------+-------------+-------------+----------+----------
       32 B  |  122.87 k/s |  133.04 k/s | 2.47 MiB | 2.49 MiB
     4096 B  |   64.43 k/s |   65.38 k/s | 6.74 MiB | 6.44 MiB
  rhtab/htab :  +8 % ops, +0.8 % mem   (32 B)
                +1 % ops,  -4  % mem (4096 B)

SUMMARY

  * Small / well-fitting map: htab is faster (cache-friendly
    fixed bucket array), but only by ~10-20 %.
  * Large / high-load-factor map: rhtab is dramatically faster
    (1.2x to 4x) because rhashtable resizes to keep the load
    factor sane while htab stays stuck at user-declared max.
  * Update-heavy workloads: rhtab is ~5x faster per producer
    via in-place memcpy.
  * Memory benchmark: effectively on par

---
Changes in v4:
- rhashtable: introduce rhashtable_next_key(), drop walker-based
  iteration for BPF (also drops earlier rhashtable_walk_enter_from()
  proposal).
- map_extra: presize hint via lower 32 bits (nelem_hint), capped at
  U16_MAX.
- Automatic shrinking enabled (was missing despite being advertised).
- Reject key_size > U16_MAX (rhashtable_params.key_len is u16).
- Replace irqs_disabled() guard with bpf_disable_instrumentation around
  bucket-lock paths: closes same-CPU NMI tracing recursion without
  rejecting legitimate IRQ-context callers.
- lookup_and_delete reordered: unlink before copy to avoid populating
  user buffer on concurrent-unlink -ENOENT.
- update_existing reordered: copy then free_fields, matching arraymap.
- Word-sized key fast path (sizeof(long) bytes), inlined hashfn/cmpfn
  via static-const rhashtable_params; works on both 32-bit and 64-bit.
- check_and_init_map_value() on insert (zero special-field bytes from
  recycled bpf_mem_alloc memory; previously bpf_spin_lock could read
  garbage and qspinlock would deadlock).
- BPF_SPIN_LOCK / BPF_RES_SPIN_LOCK allowlist moved to the special-
  fields commit so each commit is bisect-safe.
- Link to v3: https://patch.msgid.link/20260424-rhash-v3-0-d0fa0ce4379b@meta.com

Changes in v3:
- Squash all commits implementing basic functions into one (Alexei)
- Remove selftests that were not necessary (Alexei)
- Resize detection for kernel full iterations, error out on resize (Alexei)
- Remove second lookup in get_next_key() (Emil)
- __acquires(RCU)/__releases(RCU) on seq_start/seq_stop (Emil)
- Use bpf_map_check_op_flags() where it makes sense (Leon)
- Benchmarks refresh, experiment with alternative hash functions
- Rely on iterator invalidation during rehash to handle table resizes:
fail on resize where we fully iterate on table inside kernel, dont fail on
resize where iteration goes through userspace. Exception -
rhtab_map_free_internal_structs() should be just safe to iterate fully
in kernel, no risk of infinite loop, because no user holding reference.
- Handle special fields during in-place updates (Emil, sashiko)
- Link to v2: https://lore.kernel.org/all/20260408-rhash-v2-0-3b3675da1f6e@meta.com/

Changes in v2:
- Added benchmarks
- Reworked all functions that walk the rhashtable, use walk API, instead
of directly accessing tbl and future_tbl
- Added rhashtable_walk_enter_from() into rhashtable to support O(1)
iteration continuations
- Link to v1: https://lore.kernel.org/r/20260205-rhash-v1-0-30dd6d63c462@meta.com

---
Mykyta Yatsenko (11):
      rhashtable: Add rhashtable_next_key() API
      rhashtable: Add selftest for rhashtable_next_key()
      bpf: Implement resizable hashmap basic functions
      bpf: Implement iteration ops for resizable hashtab
      bpf: Allow special fields in resizable hashtab
      bpf: Optimize word-sized keys for resizable hashtable
      libbpf: Support resizable hashtable
      selftests/bpf: Add basic tests for resizable hash map
      selftests/bpf: Add BPF iterator tests for resizable hash map
      bpftool: Add rhash map documentation
      selftests/bpf: Add resizable hashmap to benchmarks

 include/linux/bpf_types.h                          |   1 +
 include/linux/rhashtable.h                         |  85 +++
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/hashtab.c                               | 805 ++++++++++++++++++++-
 kernel/bpf/map_iter.c                              |   3 +-
 kernel/bpf/syscall.c                               |   5 +
 kernel/bpf/verifier.c                              |   1 +
 lib/test_rhashtable.c                              |  73 ++
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   2 +-
 tools/bpf/bpftool/map.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |   6 +
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/lib/bpf/libbpf_probes.c                      |   3 +
 tools/testing/selftests/bpf/bench.c                |   6 +
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |  34 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |  31 +-
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |  35 +-
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 183 +++++
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  34 +
 tools/testing/selftests/bpf/progs/rhash.c          | 248 +++++++
 20 files changed, 1546 insertions(+), 18 deletions(-)
---
base-commit: b01b1156ce614469a6b9bd9a23408eb4181e1ae7
change-id: 20251103-rhash-7b70069923d8

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

