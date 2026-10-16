Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407A3C6A38
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792179429; cv=none; b=JuGYJPLK5mgf//VSwCPHfU3znDI+chf2LIbvns1ifEmacUIrxaOZy6dsuCqQXtNqUvVzwh35wTERhrC8zChpc+372S3WvSm3YdZguMThq8dAJShhywqVtwwo8p253tsTS7IW+4qkHakkBH0qrKPDZVRNO0UHmJPq0jRVNi/oAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792179429; c=relaxed/simple;
	bh=d0jR9yEMlNTeOYGgseKjJuiLE2yoAuQrlYjA+MzdP3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFfmXcwaVPQylQTSQOPepiz+SOok5jU+RZQzxQIp247Rek4lXcQ2+Ssh2QLROStulqy4RFFBoGlp2o5wDplcwT27BYXHmoPyROt+DfHSzT34TY2b5zfftTsAXpZdluwiHx4kd8GUFza/ErcFBvKRGDrcwWgDwNZClZvWKP+1R1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=esFpRvHT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="esFpRvHT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso256032a91.3
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792179426; x=1792784226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Ff3Pbs9+G9aNC3NjvDVvCey1+fxMaSKY62fWFED4ZE=;
        b=esFpRvHTORAp5RQFYQpfJM2RR8biSkisImIqYt4zjAh6u9+YFlni10Kl+2s5kN+seu
         Ah2jU0SoAllCU29iFwj+XgL55aZohUqbXccoXu+/Xj6oJ1eKzsq9W9iMU1A9g2PBP0ZB
         dQDVtINePyMGaNOFzeacGi8XANBmAaKmoDgEfXS3ILToOuywuHeGD0zwg+GeINdnPSrp
         ilIXLD13VxV3GKWrsdJbKHCENMzPq7u6t4EgipLetc4PxwClJbIWgCyczeUL8ytKmHrx
         b3ienyVi+NMcAX4T6xOORwZdNMqnrE0qE0RBMmZNoIaIyurKlVtosQj4YGVz3f4JGVY/
         2BFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792179426; x=1792784226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Ff3Pbs9+G9aNC3NjvDVvCey1+fxMaSKY62fWFED4ZE=;
        b=be+qwdHcvLA9jDrhNr5tu3dKFe6I0G4wuFWzQ8pNk4McuhkQQfn8mEbEQ0t6gvWxGr
         KiVBThhQ2mEAlRoRdeQJw9u6HmE9bK3cRnLmk2E16BtzlKiBToHm3e+JhwPDmuWEDQtB
         K8nmmunn1qsOne+3B3G5IDs9uLUHo6YUOINja7BMGPPRihlhIhd7Y9Y7/k84Bmhm3QTm
         TsTYoRuavSzUL0iD/wRJdlbeDu7yDlnM4I4K6U2ASPjlbPBdUjoHo1iotPOOZ4xM7JRD
         vyTjjQBqxYg993GlD9ODFb2B+NxCeynzdMtqDTjakmrvFuj8nFXMrNKTESs0bBXFtTxP
         DC9Q==
X-Gm-Message-State: AFq9FYLTXgxD3SERmEhxgfqiHhePLeMoJt0GtR/u6djrYToJtmVJePkj
	yZ+eU7RnAGII1HR0kmXzkObpnnn0Gk4o0IVk7TLB5KOSR/slbYhbGbi3ZJ5jMS0igY25ExKE78b
	bMMDR4UThWA==
X-Gm-Gg: AYBFou0e4eiK/DRPt6C7ckM9fNfI8nOqT3jfR7wxKdGFGq7lDY2txE/hQnZgcxUBh4K
	emltkhHodK2GLMlEM86bVkNZhg1qYlQs2hwdI7LyBjSFjOcMfYnbX77U/ul+T7hCobeii9NdExc
	1560R3j0AKFj0cRJ33Ub54yil4F0pG8/Tyqt9NiKx8av8rgAhtLZe3tynkIkXKmIU7xul22JM4o
	MnzNjjGFj5O3pvS63C4y45qryRFRuRJ/uhShSnrQnLKvu8Dm9WxLClXbw32vIxIsJ0D9b2lnKeM
	2eJUIj37oyEumm38ufFP9vSVvdiqUU8/1F/TaGOHr+3hS1K5VHk67LCXjOuLXVzbmO8tzdiLjnf
	HjJoGv+3MtsnQTIRGbTv2YCUp7lnEPwA4a68n6X5FNg7ZVDzn4BciLPAdxfslw5RV9GNnpDdCnE
	h7X3X4UX+QV4BzkQYxxI8FF7z7dQzB95fgf3dGYWnnQhqsWLHKrl9qRQz4idQW1Mshro/03cQlW
	R4mdElER7ti+zoySH8tGPxXy2vVOJ+2Wf7M
X-Received: by 2002:a17:90b:2787:b0:3a8:de1:db07 with SMTP id 98e67ed59e1d1-3acee976da0mr713373a91.5.1792179426004;
        Fri, 16 Oct 2026 12:37:06 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1f0asm14970045ad.68.2026.10.16.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:37:05 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v5 0/5] bpf: Fix arena memory incoherence
Date: Fri, 16 Oct 2026 19:36:58 +0000
Message-ID: <20261016193703.9203-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arena memory is tracked in two places: the range tree, which records
which addresses are allocated, and the kernel and user page tables. The
two are updated under different locks, and that leaves two races:

- Since b8467290edab ("bpf: arena: make arena kfuncs any context safe"),
  a free releases its range before the kernel TLB flush and the user zap
  complete. A concurrent allocation can then write through stale
  translations into pages that are about to be freed.

- A user fault takes a reference to the page and installs the user PTE
  after dropping the arena lock. A free that runs in between leaves user
  space mapping a page that the arena has already released.

In both cases BPF programs and user space can see different pages at the
same arena address.

This version fixes both races without adding state to the range tree:

- A free keeps its range allocated until the TLB flush and the user zap
  are complete, and only then releases it with range_tree_set(). The
  range being freed is recorded as one page offset and count under
  arena->spinlock, and user faults on it sleep until the free releases
  it. Frees serialize on arena->lock, so there is at most one such
  range, and recording it allocates nothing.

- A user fault pins the page, locks its folio, and revalidates the
  kernel mapping before installing the user PTE, the way filemap_fault()
  synchronizes with truncate. The free waits for the folio lock of every
  page it removed before it zaps user mappings.

Patch 1 fixes a use-after-free at map teardown when the deferred free
worker requeues itself. Patches 2 and 3 fix the two races. Patch 4
retries faults when the arena lock times out instead of raising SIGBUS.
Patch 5 adds selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Puranjay Mohan <puranjay@kernel.org>

v4 -> v5 (https://lore.kernel.org/bpf/20261014233442.8392-1-emil@etsalapatis.com/)

- Drop the third range-tree state and the is_range_tree_set() change
  (v4 patches 4 and 5). A free keeps its range allocated until the TLB
  flush and the user zap complete, then releases it with
  range_tree_set(). range_tree_clear() only allocates when the whole
  range is free, and then there is nothing to free. (Alexei)
- Drop the per-arena mapping, page->mapping, the mapping-tree zap and
  the new bpf_map_ops callback (v4 patches 1 and 2). (Alexei)
- Replace opref (v4 patch 7) with the folio lock. A fault rechecks the
  kernel PTE with the folio locked and installs the user PTE itself with
  finish_fault(), and a free waits for the folio lock of each page it
  removed before zapping (new patch 2). (Alexei)
- Give faults on a reserved range the scratch_page error. Faults on the
  range being freed sleep until the free releases it, instead of
  spinning on VM_FAULT_RETRY. (Alexei)
- Trylock arena->lock and the mmap read lock of every process that maps
  the arena before retiring a range, and defer the free if one is
  contended. The worker waits for the contended lock instead of
  requeueing itself. The deferred span, allocated with
  __GFP_RETRY_MAYFAIL when the caller can sleep, is the only allocation
  before the ptes are cleared. (Alexei)
- Release a range without kernel ptes, such as a reserved one, right
  away without arena->lock or mmap_lock, so freeing and reallocating a
  reserved range is never deferred in sleepable context.
- Retry faults when the arena lock times out, keeping SIGBUS for
  -EDEADLK (new patch 4).
- Selftests: rename the subtests, and pause frees in zap_vma_range(),
  which arm64 can trace, instead of flush_tlb_kernel_range().

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

Emil Tsalapatis (5):
  bpf: Stop deferred arena frees before map teardown
  bpf: Revalidate faulted arena pages before installing user mappings
  bpf: Fix arena race between page free and alloc leading to incoherency
  bpf: Retry arena faults when the arena lock times out
  selftests/bpf: Add arena allocation race tests

 kernel/bpf/arena.c                            | 702 +++++++++++++-----
 .../selftests/bpf/prog_tests/arena_race.c     | 291 ++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 166 +++++
 3 files changed, 964 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

-- 
2.52.0

