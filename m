Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7727472F65
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020888; cv=none; b=uOkzsdSFfBNMendCH5EdNxrKE0jexVsKB569xsEf37UHPUUuhb4cGM0nvvDQ77ZrmAhrksCm9yIKCjLLYTUjrtZJvUarJeZGOqHBk3NUzWZv3INeXUHynIPluDFuc/sYFGTBLTpxbX4LjU6o3hDNTA0+fZI64zozyXpKEJRRiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020888; c=relaxed/simple;
	bh=uk5GoQvzvlWhkVHguW/3BdzTJg/x75LGsPvMKwzF5vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xpg5+7EcyoSJehTOsT9DF2W6gOxFmCI+pus2EZOfI/Q6DdgiAYEqhM8xhLo6j8pJ2w6AtHLug5CqKcB8Mo3b7dHVZtx4/u8VA/JnbseIUkUGhCar+BjQpYsgZNc0rHPK8Zki2xRYQRy3cq2NyqPgJiqxYoPWsg3mEqSAzyUayxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=gwVT7i//; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="gwVT7i//"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso665166a12.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792020886; x=1792625686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFLBJyJUutHXBHrQWUnjzTRMomDzNKvPGlKnjPo7fOs=;
        b=gwVT7i//BuTt1Ym5r+NG5HVbHe2ODBSyR/V774c8tRKw3kReU8fz6E/cuKcP0VR9XB
         n3HbQ3nsgPwH4bK/lzw+wfg8X32VBJe1a1qbS/DEXqdDSwtRSA5T8JqqBMFj3tp7pdyh
         PsrXOSPcuNJ+V6MuwlPFfXm9vkBeMAhueUZyDoxFucrYv9EbEHNATTZd4YzJVWuSh810
         QcE75B/9jO2RrP+1VXSX4OZXTmbTXI6lvDwiQ/trEPYFEkor8OCWRKzI+Hma1+kHMdHG
         QX8Ry+z4LzO/qAL/+q8Zo4lpaLVcUc5KUOgvEk51cbKus+XVZwSTI7ztb1nmqvgc8X3T
         6lzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792020886; x=1792625686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFLBJyJUutHXBHrQWUnjzTRMomDzNKvPGlKnjPo7fOs=;
        b=oXIL1KpCYPG0edNJbnDQhCCIdsYhCSTq4mlNQvv7krNdVY3rv94LrmA8AKKUU6y3e5
         /XIOYr8hrjAF+fS4xIxTdQxAeAUrhsd6HmPkYwoUOh2O9v9UCWT+MPiNboHKjhUUxeQz
         pYKW2NcmxW3rbN7sw3Xh2F7lgBRUBh28ew70c5w418NabVMmCP13mYUEmcdwUexXHzoO
         f6daLLlD1wJ02FmzEbD/coH4P6Miw++EckvzgP18JOm94OtsEASxDBqP9j5LkufbyM4e
         xNbwAFdPAqosa/BI1gfoH7jbNWvxpoku+Ga07BX2mbIgrPz4jBPLN7wXl1yd3mWvInPf
         badA==
X-Gm-Message-State: AFq9FYJS93vJjHF0YhtXkjF5rG5yBRQDTol/aLtxrywhw/fK00Bh5zqp
	1+iNlu/zxzd+TNX7TPEixQ/tLMVKc1UzGQYFOxaFR1qiy2tgpk1a0VaN2LNJXgCcMjy6GuByUuV
	ElFmPoBE=
X-Gm-Gg: AYBFou3Yo7FKWND9x+yZBqNZ09Bsg5FN0o1bM+Fk10fJVwP9Aw5tIAK52tuxBHz8/uV
	snbb18UWbsT/g2BZna8E6pz3r6kkX8IXIuYyecvr2dmFSeTfw9kI46YUuC0vbvbkfTMuuYofPch
	4HvRqARf7xDrgKOeZuBtR6GpzlC3p5CUTLAvrEn0QM/a3RFT1CYCZBPMvYd8MYFreGcVW7uHq2N
	4YlilJ7jlLklIJf8dvza3OXOQRf9Z4gCpHZW4F/wwaCHFm+klsEuiIadxqAQi2g8js0PI14b7Jo
	a/l4kqJJJNyXe9PUbZsDWXwRr1agtTXtO1hLBes6BVw98sVu6I+AEXtEWpjKTyKxaBzFUxocDTj
	9KIlMhtq8+DEYJpQWmentNBH4KJ2wIfa2ihBU7zvT5dvtg5QoOo8wF/kffD/t+T8dixxsKI3ulG
	nTSS/bvSKnbLN/BDkdH1IW/axilul4lVHQZEJZg+8dtWnj/ivuwrTOj/NOf5gQII7SWgDAy7MYz
	u2Q14Jd+XX3C9Pc534lCMvwDsT3S2E+YfkG
X-Received: by 2002:a17:90b:3d4b:b0:3ac:945c:7f69 with SMTP id 98e67ed59e1d1-3ac945c9996mr827785a91.66.1792020885774;
        Wed, 14 Oct 2026 16:34:45 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7a98sm1385177a91.6.2026.10.14.16.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 16:34:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v4 0/8] bpf: Fix arena memory incoherence
Date: Wed, 14 Oct 2026 23:34:34 +0000
Message-ID: <20261014233442.8392-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting up arena memory for a task currently requires two operations:
Adjusting its range tree, used for tracking which memory is allocated;
and adjusting its page tables/flushing its TLB state. These operations
cannot happen atomically because their critical sections do not nest.
This lack of atomicity is the source of two bugs that can lead to
incoherence between different users of the same arena, wherein they
observe different pages for the same address.

Address the problem by more finely tracking the state of each address.
Expand the range tree used for address state tracking with a third
state, used to denote whether an address range is unavailable, either
because it is being freed or because it is being populated by a VM
fault. Use this extra state in the arena page freeing/fault logic
to ensure that operations on a single address properly serialize.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Puranjay Mohan <puranjay@kernel.org>

v3 -> v4 (https://lore.kernel.org/bpf/20260923191125.5311-1-emil@etsalapatis.com/)

- Add per-arena anonymous mappings and associate pages with them
- Return VM_FAULT_LOCKED and let generic MM install user PTEs; wait
  for locked fault pages before TLB flushing and zapping (Alexei).
- Add mutual exclusion between arena free and fault operations to
  prevent incoherency.
- Return VM_FAULT_NOPAGE for non-retryable GUP faults when progress is
  impossible.
- Stop and drain self-requeueing deferred frees before map teardown.
- Track ownership of unavailable ranges independently of free progress
  and retry worker reservations on -ENOMEM without starting teardown.
- Make arena free span state machine explicit.

v2 -> v3 (https://lore.kernel.org/bpf/20260923061425.7045-1-emil@etsalapatis.com/)

- Rebase on bpf-next and resolve conflicts
- Fold in the atomic mark_available range tree operation into initial
  fix patches

v1 -> v2 (https://lore.kernel.org/bpf/20260902070239.16968-1-emil@etsalapatis.com/)

- Use __range_iter_next() in is_range_tree_set() (bot-ci)
- Move -EAGAIN handling to the patch where the errno is introduced (bot-ci)
- Add refactoring patch for (Puranjay)
- Avoid leaking unavailable range tree nodes with atomic mark_available
  operation()
- Avoid retries on res spinlock locking for -EDEADLK (Puranjay)


Emil Tsalapatis (8):
  bpf: Use mapping tree to zap arena VMAs
  bpf: Associate arena pages with their mapping
  bpf: arena: Stop deferred frees before map teardown
  bpf: Update is_range_tree_set to work for consecutive ranges
  bpf: Track availability information for ranges in range tree
  bpf: Fix arena race between page free and alloc leading to incoherency
  bpf: Synchronize arena page faults with page freeing
  selftests/bpf: Add arena allocation race tests

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arena.c                            | 452 ++++++++++++++----
 kernel/bpf/range_tree.c                       | 240 ++++++++--
 kernel/bpf/range_tree.h                       |   7 +-
 kernel/bpf/syscall.c                          |   2 +
 .../selftests/bpf/prog_tests/arena_race.c     | 285 +++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 159 ++++++
 7 files changed, 1013 insertions(+), 133 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

-- 
2.52.0
