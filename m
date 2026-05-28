Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723033FB7F2
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990458; cv=none; b=HoUEltHz0+eidyivShDWLn7qWeeS0Amnt8BP+3EqEqbm3FkCG417nffcVo0QqNWlmXEnFPH8RSJBY6Kqpe37ayT/6zrFT7bF9L+Ip8RlOIRyfvmwmVZw09WpkIgjgWCgpjUxV5I6HNK5g2bhRbglNJGqSu+1R+36MJBetArhzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990458; c=relaxed/simple;
	bh=yLh3rpFJAbhh1ftPRvyoeyaJ7jaXPHQmvF8hI4ABUP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZQVQyKVeMMSztIeOVOfVoIyxUrt0/crMeDWzTVAYaWXbNknhV38jX+/1nP6KRv6HeG9DwadFYpwDhaOit0Ea6VBwt+u9dErCgBqak2B5LFzdyRWEWooKg/7mr59fZ4a6hUxGRyFVClYKmyyqujuO4gDhvnypL1o5NnO0RoNMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3DKaih+; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3DKaih+"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-459bf19e87bso7913926f8f.1
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990454; x=1780595254; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OnRr7riLExSZ74kp2ZUaTUR26kF5a5k7ZE4N5g+Sobk=;
        b=Z3DKaih+1LccvIhsYTCnNqMST3VvIkzz6QPqURW6SrKY2FRQzadOcCNLE6M2e/1xT/
         OpoWomDpDyGhdLJrczvDtAE1NwfzHnFeqN4BOvXyEM/ocd/SQPwUuADWI/FZdzoR4cgM
         VJvTxIohUKI0/qFA7Tj7f7dSSaVwUgDluM0U2LFli3kz9oG89fDkiuX1L6YG7+DKeBBE
         kHvfD5ucHcYWd0HnT+DOmsrZObHo/nwetq1z3X6ENeKeWKJ9HzYJSMX5mkDmE3NU4N/9
         Sqq/eLO6f8YN2iVmb6uGqUxhMpLEZYk2mvP9Q3BzNVPGfKLzpLEt6ScKYl07rAvBO3yT
         DPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990454; x=1780595254;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnRr7riLExSZ74kp2ZUaTUR26kF5a5k7ZE4N5g+Sobk=;
        b=Sv6bsvQYK7Qdrk9BYtx3UdCTL1NmtcC5rBJh3fk4kAbbb3n8pAslhfS/Bkta8mYwmN
         4BZJhnNlOGEkUJBonzUEeiOiLVz7mLK2Z6Mc+2aKlU8RQAnmQtvcJznkPsEsJZhcgKgu
         E1NtdZNcVBgee+zhM0xAhNJD0tHvcIh3WVs03r8hrnaBGIpJ7Wpi1oJv7CHDRu5gVALL
         +eVVzFsay+A7B28XsJbrNOLkB+RgMWW5rCrqIk9jAJau34bwQhBfiqBTyWnZOTqbopBc
         sW7ZftyXOEBU13iymVKAONg36NSe5pu3gF9pgaMh2wjGtZULNr+vxaDMy5WhMqcTgj3h
         iNtQ==
X-Gm-Message-State: AOJu0Yz7S292i8+GHYU5d5cjUpY2MP7wo6p6rIB08ha3UKwXTkoUGXii
	y9qHCQLS2xcNC/ZS42Yvw6s00Bds3O2Ca57rs52h09MiMU9IjF7RuVTB
X-Gm-Gg: Acq92OG1fYuM9e31vS3YDbz1oHKGiN09pICJJs2XDYtDP5ZviHBXTO0wmne8AY/DhCJ
	OBr3pEohAP54ZOpZ9gr5uneBu5O7En41nfIrnplBmu/869PAQHfTGoLJG0tVwre4KPeD/mK13rq
	tBxThDqtiV96fFwGRkMc6Edb9umyxvhgrtRreEVAWMTWqzz/jzj0hJHos/LK0rhHQ2f08gVGN0n
	QpVP/ZZVe9T8PjTojAaU5tJHbaKppjnTyclzUZn7eq6EP3tKyu6ggdzhHe4bpm4ophRLoqlM685
	B1RGTWwpbwQ9RpRj/w2PeJkvcOj/SzRqcxEwll1qrfRwRHsURjxKnieC97SOU9nVTohHvFmLjVc
	+zVZJw3mr6q/Xli5RN2bNlQ4mEf/n/uAAJlQKZjO6VkPGfNcOJ6m5ykmC+bTw7oXYjnM21UPm0/
	3wlXywwa9nGcgKAeBglGQxeMU=
X-Received: by 2002:a5d:4e10:0:b0:45e:ee50:d066 with SMTP id ffacd0b85a97d-45ef02917d4mr214072f8f.6.1779990453473;
        Thu, 28 May 2026 10:47:33 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb549addsm14668805f8f.5.2026.05.28.10.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:47:33 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v5 00/11] bpf: Introduce resizable hash map
Date: Thu, 28 May 2026 10:47:11 -0700
Message-Id: <20260528-rhash-v5-0-7205191b6c57@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKB/GGoC/13PzaqDMBCG4VsJszaHyeTH6qr3UbrIn8csqpJIa
 Cne+6FypKXr4Xk/5gkl5hQL9OwJOdZU0jxBz3TDwI92+o08BegZEJIWAiXPoy0jb12LaLqOZDh
 Bw2DJcUj3vXMBtwx8ivcVrg2DMZV1zo99oIr9TkgGCfV/qwqOXGIIJhjplaHzLa72x8+3PVDpj
 RSeDkQv5KRpdbBiMPELyQ9E6kCSIw84WPRRybZzX0i9kRbHq1W9UJBBK+G9w0+0bdsfODb9jUI
 BAAA=
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779990451; l=11423;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=yLh3rpFJAbhh1ftPRvyoeyaJ7jaXPHQmvF8hI4ABUP8=;
 b=LNiflFvoYez+Zqe7xsaFxHXAflJF+vbV0yqPRGWIzGQgV3Wsk6YYYtKvplxDbZFjxQCVXu417
 JTQ/1HjWp2ZDAwIXc5bMw9KaadxVb+JFA5XKhuIwt1BJ3lK3T1922Tj
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
 include/linux/rhashtable.h                         |  91 +++
 include/uapi/linux/bpf.h                           |   6 +
 kernel/bpf/hashtab.c                               | 814 ++++++++++++++++++++-
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
 20 files changed, 1561 insertions(+), 18 deletions(-)
---
base-commit: d34771f2f3db4ea0dd532cdd579002fc95dc483a
change-id: 20251103-rhash-7b70069923d8

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

