Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D44CA28F
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 11:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659694; cv=none; b=cfPscylH4h+N//x/d/4bGJobip2bDBE/u2EXORhUPzqPS4eYU3A3OqN2RGB7JgmptYEalJlg+gS0cwAHE7B8I+BDBctPwkw40TxQLN/U/zXyPQQxldQbAce2VM3kFrHZhIpBivnKzJpWmUoDoUdC5BSAAlrRZsp7KVyK6cH5Neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659694; c=relaxed/simple;
	bh=FnLc2e7RDBbOxzqcxIm66iMR5mPbXGfAzmQ2u/OF8k0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I08v2QG5v+L6HTZYXQ6+hki2AjoZKi1Jh4tdmezM7h+aJ1ZWktLOJfobVHT4UV7ACIO3zAb4dbFuOvGjcDoh6UC6ZteTo59SZL5vqgAwGqCs8C/8vbRUxrXzhFkrZN0pyUJdFmUI7z0DLzavym1raF3qxehyBLx5I6MDjnKD/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEvcbYg5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEvcbYg5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso922122f8f.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659691; x=1781264491; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf13pJgU76CPC9RooFxjTNe/zpJYQdOSy/VOf8T4Yi4=;
        b=ZEvcbYg5tYJ32IQSfbpM4E02LQOKc1+1rVG3vH5PvCoPU0n24TIHg/LEAStf0moJDU
         uJrOVfjcVF5wl3iORjh9Q0Qbl4+cvjFabjQTtfIwHJP7L8Ijz7z+GWkEkNgba3muDK7r
         wl2aeQi2TPUjONMDhN8aYFugudXWqZKmIweg24s1ZAuyld9oMM15D5TEz0L3yb7Ix2FV
         lv+ikh+6uD7N8Hfij49KXtwrrRm4g2QNCuJ2Ja6/VG7erBhq83BGtca5Qj29vmXs2Vju
         KAmJitn0WFMS9Sx0sVuSVeomWFB3uYy+0FS+YhHg4TbWmAXorGj/mDaYP3r/tRdYc0Zv
         b05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659691; x=1781264491;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf13pJgU76CPC9RooFxjTNe/zpJYQdOSy/VOf8T4Yi4=;
        b=KcNMSkd1dL7ngB6wssnIMkW9DmTzw+xZe/CvNo0PIb9KxQpf5LQDnnnJ4SQ+hR0ppi
         GDohMGzDhLEmlU08egze2LD7ioEQS+ytnHcYZdJd84AFvJMGz8K26xL528pc0ELitAh0
         O1pOm4Na6rdUGTeJ226x7PamGZYajNdXZjgCguxSWCGWF79/ZvotK5IOpl7EWFl4mW2T
         ufyG4TIN29JqVflL6qpjQfnYQIZtFFNuQ2NLYI7CNyJZk+kYgJkY8jTsNpAd7a2+vJ4o
         PdVIRQ22iiMLFd5VLld8Yxw4Grx70wOPaK1pO12SmczkjpfC5Mrw+JKbsFfKKKCYlkoL
         SkOA==
X-Gm-Message-State: AOJu0YwWviiAllIMscYsHVM/jUtkUu4yMUQog++CbUMunExIzXCvwdke
	UMAXKEzv2qxQju5pg+SU0WY7odO4lyoLmK27thZEl2veDYD2yVs36P2T
X-Gm-Gg: Acq92OHfrMMZ1pRPnUrqqFSGvihcSFv8TKZ826DKTdxGR0yHj8vjVfamORdQuJylr8Q
	aiVHfXtQm+AMR9H8ilBMN6+IHkArAHqbA5xfN6I/klM+7WAk30d7gfYAV2KLLA88RlGIhuId7Wf
	gSMyT9Bwr9vvZsd+Jao+MS1PFSQxlk0XEaHj1zHcSMpqrPhWvzabd9uuRf1565hC0zblLAPzbmt
	s+kWwACxNHJ0zKt+RPbJxTMNB1BXjiWLLmA6tDjlLKWMwZUxWT8hNELD7cXIMNUVbp5bdIc620v
	EkhLBe9/YnDxp1Beh8HAq1BdBgvoyO4bTyVgM5UsXEUJnzLqbAbhsvigwrqmR98R3+7i4Z8Kesr
	AnJmF8x+WlGKfAoGgoNa5Fz3qGQlTjFzJhWBXbd+jjLPvb5e1xkjf0md4ao6Qu416LCJYxMG0cc
	OWQTGPstI+pg02d+QCCTmkkzc=
X-Received: by 2002:a5d:68ca:0:b0:460:25e7:f78a with SMTP id ffacd0b85a97d-46030757f87mr3646829f8f.32.1780659690696;
        Fri, 05 Jun 2026 04:41:30 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm26387524f8f.6.2026.06.05.04.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:41:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v7 00/12] bpf: Introduce resizable hash map
Date: Fri, 05 Jun 2026 04:41:17 -0700
Message-Id: <20260605-rhash-v7-0-5b8e05f8630d@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN21ImoC/13PS26EMAyA4atEXpPKcV7Aau5RdZFnyWJgBAhNN
 eLu1aBSEGvr+22/YEpjSRO07AVjWspUhh5aZisGoXP9d+IlQsuAkLQQKPnYuanj1ltE0zQkYw0
 Vg8eYcnlunU/wj8z79Jzhq2LQlWkexp9twSK2OSEZJNR/rUVw5BJjNNHIoAzd7ml2H2G4b4GFD
 qSw3hG9kZfG6uhENumC5AmR2pHkyCNmhyEpaRt/QepAWuyvLuqNooxaiRA8XpE+Ifo/T3PkllC
 LRngTtL0gcyCDtCPDkQufo9ROiVrlE1rX9RfZ4t07rAEAAA==
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780659688; l=13422;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=FnLc2e7RDBbOxzqcxIm66iMR5mPbXGfAzmQ2u/OF8k0=;
 b=C20ne2oVtjgOt59gefAYTTR/4YmLLAKEStlod7Qom0b0HoyQZZF2y2lHjE21xJiezU0FEB4wj
 pvz6JoHb92lBy2bIrfFX1SrHCZ0g2BktJ7J6U7uZApOtegp5h275Xis
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
Changes in v7:
- rhashtable_next_key: move into lib/rhashtable.c, drop params argument
  (Herbert).
- rhashtable_next_key: kdoc clarifies that behavior on tables with
  duplicate keys is undefined (sashiko).
- rhashtable: include Herbert's "Use irq work for shrinking" patch so
  __rhashtable_remove_fast_one() can fire the shrink path from NMI
  context (Herbert).
- hashtab: fix u32 multiply overflow in __rhtab_map_lookup_and_delete_batch
  copy_to_user; cast total to size_t before multiplying by key_size /
  value_size (sashiko, bot+bpf-ci).
- hashtab: allow kptr/refcount fields in rhtab values (same model as
  array map).
- Link to v6: https://patch.msgid.link/20260602-rhash-v6-0-1bfd35a4184f@meta.com

Changes in v6:
- rhashtable_next_key: advance past duplicate keys in the main bucket
  chain to avoid an infinite loop when there are duplicate keys
  (sashiko).
- rhashtable_next_key: return ERR_PTR(-EOPNOTSUPP) on rhltable (sashiko).
- rhashtable: selftest pre-sizes the table to avoid concurrent rehash
  triggering spurious failures (sashiko).
- hashtab: real rhtab_map_mem_usage in the basic commit; move
  bpf_map_free_internal_structs from rhtab_free_elem into the
  special-fields commit where it does meaningful work (bot+bpf-ci).
- bpf_iter (seq_file): switch to rhashtable_walk_* for stronger
  coverage under concurrent rehash; get_next_key and batch keep
  rhashtable_next_key (sashiko).
- iter ops: rhtab_map_get_next_key adds IS_ERR check
  before dereferencing the element pointer (sashiko).
- iter ops: bpf_each_rhash_elem removes cond_resched() (sashiko).
- iter ops: batch returns -EAGAIN (not -ENOENT) on cursor delete,
  so userspace can distinguish lost cursor from end-of-iteration
  and restart from NULL (sashiko).

- Link to v5: https://patch.msgid.link/20260528-rhash-v5-0-7205191b6c57@meta.com

Changes in v5:
- rhashtable_next_key: add kdoc WARNING to highlight lack of rehash
  detection and unbounded iteration (Herbert).
- rhashtable: selftest now checks IS_ERR() before PTR_ERR comparison
  on the missing-key path (bot+bpf-ci).
- hashtab: drop dead stub bodies and unused map_ops registrations
  from the basic commit; iteration commit adds bodies, structs, and
  registrations together. .map_get_next_key keeps a stub registration
  in the basic commit because the syscall dispatcher does not
  NULL-check it; iteration commit replaces the stub body with the
  real implementation (bot+bpf-ci).
- hashtab: fix batch cursor advancement. v4 stashed the lookahead
  element key but then resumed via next_key(cursor), skipping that
  element across batch boundaries and orphaning it on
  lookup_and_delete_batch. v5 stashes the lookahead key and looks
  it up directly on the next batch entry (bot+bpf-ci, sashiko v3).
- hashtab: document torn-read race in rhtab_map_update_existing,
  matching arraymap semantics (bot+bpf-ci).
- Link to v4: https://patch.msgid.link/20260513-rhash-v4-0-dd3d541ccb0b@meta.com

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
Herbert Xu (1):
      rhashtable: Use irq work for shrinking

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
 include/linux/rhashtable.h                         |  42 +-
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/hashtab.c                               | 808 ++++++++++++++++++++-
 kernel/bpf/map_iter.c                              |   3 +-
 kernel/bpf/syscall.c                               |   6 +
 kernel/bpf/verifier.c                              |   1 +
 lib/rhashtable.c                                   |  69 ++
 lib/test_rhashtable.c                              |  75 ++
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
 21 files changed, 1577 insertions(+), 19 deletions(-)
---
base-commit: 73f574b0cd0ef87a25afdffe1d907b55f7fcc940
change-id: 20251103-rhash-7b70069923d8

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

