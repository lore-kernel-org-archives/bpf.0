Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E43D565F
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661034; cv=none; b=kQ0tNWre7B5GVJwaZK1Vu0Vp8yHFUUgvF8c/zCCOSrYnN0cNfL+RcceX/9cZk5KALmUE8Rh6zklgJKTdPIhdbKIOtSuO2MHBVg+cO4giMpIUapu9ZV+K06TVdtTiFiU+53+3s/60+cUl61NPL7O6mdLMw+AQhlw5yX/N1jQbd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661034; c=relaxed/simple;
	bh=dwFNjUYp+PinnMUWrxmZHNbwBhpdPxg9/rP5ywrId6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l3N2lhjZvNXgWG8MLlZ3ebVuQ+neic9rN+Vtk1CuUkHZEGIc2tjpmUlLoReKMbhxtg0vrWV2JOzdHJ5if21GGkqwE8VYRZhVCZJgwZE4xawQmApJ9P/mZTg+puAuwlGA8JYpiyBUjYhMLbJr38HFLN9LglyXsiWfBuS0/r7Vmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX5bDPq4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX5bDPq4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso42970545e9.2
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661032; x=1776265832; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oj7UOttUPTs3aPvhWdwNYzhrX0Dhdftq4HiRX8HAo0c=;
        b=VX5bDPq4hW8PlV1pI0fipLoW+1OuZe6b/kSJI+aCGj39jIBETwQ0Gv3fz09udAKeuM
         0hPxPdqV95bHKjP/7iTj6OIVJ74qzIw8iF8lPrea2NxxnqHPMWWoNn4qjwwIBdaZdMtV
         lJr97tDSH+haotOe57uZ5a0dj1IBsMVzXlhTYUK/cEk9Cqs/y3VAyyTJizx9WxFJeaSy
         ZBqAkkBePWIhmI6rf0xlDTUUCWRXY+t250Vx4mSFg6cULmpnu9w8fHG/jFotCiUEXqKL
         VyVttpWVqwtJTuwd0HaH6zlx1yPpjuWmPoBOwWce+nO3yHhx/WboAHg/MOSKyVX5p1TV
         Rigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661032; x=1776265832;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oj7UOttUPTs3aPvhWdwNYzhrX0Dhdftq4HiRX8HAo0c=;
        b=MyBEPZCu2Sy8QYOeAgLoV1NklPdlghdqvplMXn04KUR2Fc2VIEyVdUpBUj9coA32Vr
         /jjV0LSC1OfBs+A3OndLP/MRl0RZ8Hy3hml/Fcr6WXFVSrGK6NSYoD3Vt1iWaCuM25rm
         shhvuvV4OmN5Qkn7suh9UL0qgc8mXf0mwhoqsepfAz5Y8U9BWSC8ssFYqtcQDoAbXhem
         bL91iN+W5U/zbmxxSBuZAm/A056KvG47gbn4suTCI8kgPuSfOc3qMTV8HEx2r9KMDGB6
         /LOQtCS+nvim4RGzENHxdC+ZHsYPHmYfXvgUbBPYMsVbKbhU0v1YbO9UkN/RhlIaXuKl
         DHqQ==
X-Gm-Message-State: AOJu0YwaUhV3KgGEprggJ6k1kETn8NOtYDorl/4X76ReMmJeJyRSu90e
	if5KxEdeIFmZlImLqOjYlOANtCnEbG7dC+/ldUyyBKzpF6T+DhqJKZOEp1lQNA==
X-Gm-Gg: AeBDiev+Kb7+lwYY7xvqmk2V++3Mz5fJ4GwQ/bbNbejxRqgPCvjgxTYHOm0rOJLDcj3
	eGFtCeVz7QRHdzfZUacblZU0OUtMuaQmIuHntQ3TbKSIuclxtcLVwLUB/pynM8nNxvjyLUCLAy2
	9cfWEsMBnuJjZMckvJRNSPSSiY4KjEm6Irc49qfpguwbKHBe4P7wmRYDDsvYeEca4xSgcGIsPbS
	crDICqk4rRD5oR+BnQLWEnbXnJjvirEMv0wAHG44AamVjk7Vz9JVE+j8vMVDvE+Dl7CL8rnz0iq
	/xX80/w3WWx2Fa3DXJ9p1Q044lZlkQLix43tCDBnYqJfvwvZXZPIKDwRmqPD4lm+hU0UEt/yOrk
	As46PKPr4Dmq7YZnoK6PGXts47sVs6k60q8RxXl/6l/QduXkRLLLkQnQmg5kTxNvhJ3klsvkOl6
	vy39Qoxo5Y6P/8
X-Received: by 2002:a5d:64c9:0:b0:43d:4d60:c2db with SMTP id ffacd0b85a97d-43d4d60c3abmr9704473f8f.46.1775661031479;
        Wed, 08 Apr 2026 08:10:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d289asm58052353f8f.19.2026.04.08.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
Date: Wed, 08 Apr 2026 08:10:05 -0700
Message-Id: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1v1mkC/y3NTQqDMBBA4asMszZlMqmxuioUeoBuiws1Y5OFP
 yQiFvHuBen+8b0dk8QgCSvYMcoaUphGrIAzwM4340dUcFgBMnGuNRkVfZO8KtqCyJYlG3fDDHC
 O0oftdN74ej6gnXs1yrZgnQH6kJYpfs/Jqs+GiS0x5X9v1YqUIeess6a7Wr4PsjSXbhqwPo7jB
 5MqF4inAAAA
X-Change-ID: 20251103-rhash-7b70069923d8
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=5870;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=dwFNjUYp+PinnMUWrxmZHNbwBhpdPxg9/rP5ywrId6s=;
 b=6EtuK92vPh2iVjyWfJhDh9G/PJwyY/+++JCv31C4usBsDh4EqFFeQeOn5j4FGoQ4z/CExg3EJ
 Eq3aC1s394EDzTzzakr3zAUyoFXndLyaSqoMaD91xtcVWasJquMOSEu
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
- max_entries serves as a hard limit, not bucket count

The series includes comprehensive tests:
- Basic operations in test_maps (lookup, update, delete, get_next_key)
- BPF program tests for lookup/update/delete semantics
- BPF_F_LOCK tests with concurrent access
- Stress tests for get_next_key during concurrent resize operations
- Seq file tests

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Current implementation of the BPF_MAP_TYPE_RHASH does not provide
the same strong guarantees on the values consistency under concurrent
reads/writes as BPF_MAP_TYPE_HASH.
BPF_MAP_TYPE_HASH allocates a new element and atomically swaps the
pointer, so RCU readers always see a complete value. BPF_MAP_TYPE_RHASH
does memcpy in place with no lock held.
rhash trades consistency for speed (5x improvement in update benchmark):
concurrent readers can observe partially updated data. Two concurrent
writers to the same key can also interleave, producing mixed values.
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

Benchmarks and s390 tests depend on the
https://lore.kernel.org/linux-crypto/20260224192954.819444-1-mykyta.yatsenko5@gmail.com/

Changes in v2:
- Added benchmarks
- Reworked all functions that walk the rhashtable, use walk API, instead
of directly accessing tbl and future_tbl
- Added rhashtable_walk_enter_from() into rhashtable to support O(1)
iteration continuations
- Link to v1: https://lore.kernel.org/r/20260205-rhash-v1-0-30dd6d63c462@meta.com

---
Mykyta Yatsenko (18):
      bpf: Register rhash map
      bpf: Add resizable hashtab skeleton
      bpf: Implement lookup, delete, update for resizable hashtab
      rhashtable: Add rhashtable_walk_enter_from()
      bpf: Implement get_next_key and free_internal_structs for resizable hashtab
      bpf: Implement bpf_each_rhash_elem() using walk API
      bpf: Implement batch ops for resizable hashtab
      bpf: Implement iterator APIs for resizable hashtab
      bpf: Implement alloc and free for resizable hashtab
      bpf: Allow timers, workqueues and task_work in resizable hashtab
      libbpf: Support resizable hashtable
      selftests/bpf: Add basic tests for resizable hash map
      selftests/bpf: Support resizable hashtab in test_maps
      selftests/bpf: Resizable hashtab BPF_F_LOCK tests
      selftests/bpf: Add stress tests for resizable hash get_next_key
      selftests/bpf: Add BPF iterator tests for resizable hash map
      bpftool: Add rhash map documentation
      selftests/bpf: Add resizable hashmap to benchmarks

 include/linux/bpf_types.h                          |   1 +
 include/linux/rhashtable.h                         |  31 +-
 include/uapi/linux/bpf.h                           |   1 +
 kernel/bpf/hashtab.c                               | 730 ++++++++++++++++++++-
 kernel/bpf/map_iter.c                              |   3 +-
 kernel/bpf/syscall.c                               |   4 +
 kernel/bpf/verifier.c                              |   1 +
 lib/rhashtable.c                                   |  53 ++
 lib/test_rhashtable.c                              | 120 ++++
 tools/bpf/bpftool/Documentation/bpftool-map.rst    |   2 +-
 tools/bpf/bpftool/map.c                            |   2 +-
 tools/include/uapi/linux/bpf.h                     |   1 +
 tools/lib/bpf/libbpf.c                             |   1 +
 tools/lib/bpf/libbpf_probes.c                      |   3 +
 tools/testing/selftests/bpf/bench.c                |   6 +
 .../bpf/benchs/bench_bpf_hashmap_full_update.c     |  34 +-
 .../bpf/benchs/bench_bpf_hashmap_lookup.c          |  31 +-
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |  35 +-
 .../selftests/bpf/map_tests/htab_map_batch_ops.c   |  22 +-
 tools/testing/selftests/bpf/prog_tests/rhash.c     | 502 ++++++++++++++
 .../selftests/bpf/progs/bpf_iter_bpf_rhash_map.c   |  75 +++
 tools/testing/selftests/bpf/progs/rhash.c          | 285 ++++++++
 tools/testing/selftests/bpf/test_maps.c            | 127 +++-
 23 files changed, 2012 insertions(+), 58 deletions(-)
---
base-commit: b199f582a924e04f3f3b1050c484798034c61a12
change-id: 20251103-rhash-7b70069923d8

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

