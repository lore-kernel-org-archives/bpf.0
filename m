Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440673;
	b=R1kmW/IsTRGTt2XYziI8X3DIfpO7vNOUDDRi26Th+0N+2NCv8huuIcMriEIFediRlfUR
	 1q7nvaepht4lIc1DprpAEn3Xk3nKB1UqTmOMJc4FxfrYV+jKtcOOFmlqAW0bGBeJaY5EW
	 A2ay4zyWl66UJA8BmKioOGyC37/oAUtwp3KAJ6N+krkGGUBm0S7WS5ktqN+a7Ype8CzFh
	 KxM9wRLuo2q0+oUX41E18bHdKc2iQ0AdSR3M7zOOV57rWUjXZHJZEnPDEfAlmxjEd0M37
	 5kwYl5SfQ/o00/urdISctvo99qPXBbAeorI40XuUn1N1CVv6kdpDs+H3qUZ0LryrIPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zEo7Iqpg+YERrcbhcTHgvOyPbI2nEpYXLlomySpOh9I=;
	b=LghERpcwEWGaCMwZpaiwgfGBwITJeJP/A6FXIv1Mio1n1FflVRu9PSY5y4qKbP9w0LS6
	 WtCNGnVVk+9DviPLi73MgwmKi0N3oL+kzZbt48x0OskGV2E8wpkdz3NJSMSexvh05pXAS
	 NCU90tSiYLw54yCz6T/MtgQveY+kKu97WQqLSbhut1FVV/eQEfepM340az8kNGb/yd3h4
	 6Wv+DDpCRQ0+iQJw1HwtQ8Pdd+elQP4p07qRhXo7nsd/yCe7FMRs/DHTRULeIsnM1KoiG
	 P8jdDk9ziY7Bl9nl+sGpr9sGABZTBNIFkywa5cBo39G8+peu0U5R0aQRqD15jwC+sig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=jQvHEqAk;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32979606A32C
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32979606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=jQvHEqAk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e5fb79ce82so13300255ad.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1792440671; x=1793045471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zEo7Iqpg+YERrcbhcTHgvOyPbI2nEpYXLlomySpOh9I=;
        b=jQvHEqAkKtkc6Zop9QT31InpqMiws7c4dXlN6PW65LtE7M+vId3v0VIuiM6J2AWZzk
         hPrru6ZEQykU7uB71DV7SE3HvR6eWyF0jubYL2eOaXAo1eMb9YTVJZim853H+39YIQRF
         CaVxiwzr1sWUUKM9H3FFvaWNzh7o5h/UY8fWhcAmDdEYcmjMJ2G7ua08hTq/lh2Cyesb
         6UaQVLdfvtlrVIEiB6Rpv8pe/d69AekiICBAkS0+jq9mWgL085GgJPQP1v2qQU9m+Brd
         MbNj6dMUIuQV3etjaIpsrreODEKrdyara8gvpa1KJN/qhce4R9ls6RG4GJN8vNCc3b/0
         lBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440671; x=1793045471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zEo7Iqpg+YERrcbhcTHgvOyPbI2nEpYXLlomySpOh9I=;
        b=mh3yseWMgZr+ArGCr0wSWFohRWveSDt920Sin0BScP4jdL8PqWKmX+M3cXTGJ8G24L
         0QxvjQKxUXvK/bl4Eg3LjbDDiuf+Ktrpbzv/dQ8L9HVV+66FsT70+49nyYr3e8uZbsss
         bkyhtJUtNP1jVTXrt77NLXMRqg5qfYKrl8DXKeRcOaIZQ/dHJ9CQ9n6pJHls2OVukIvr
         C13HiPScAFGulaoek7zZYLFNIsCrwTUgzaAnuVxeodpGP16n6/uAUN0HMWhd49F+eAfO
         KIlcJ2iWHets/RWng8rACPeZq1uXVGrf32uc+smc8EXJui6QVIYk3C3/vaIoULfYnFsd
         EjuA==
X-Gm-Message-State: AFq9FYJHaI//kk6j6WSlTM/PPYVLYZBWHGXS+SCyzQwG0YYcWC/6/m4T
	30FfA3H9dF3M6C+/mapRlqxiUzTbJRqPNwd4vgHYW+RuLtgGqcngZQyXQYqjlSd0vHPCDmjmPNo
	71PkEnZA=
X-Gm-Gg: AYBFou1/G+ZSDdVq0Vx8dj458yGFrBtHJXRsKrU0GfVBiVkTMwYdd+s8/1nBpV03xmi
	RwzU6uWgoAUO23or2abWPFwW95oDAuP5R+SjKWUxHXiKM1ve5z4YEo9DrZNpq1+IiwnEvQEcdaS
	BzLVIeMc76ksughn/SQpmvaU9UsSAipGPw2DdQ6x5/rz0ARCUFPpfYXt5XhseRssDHU+SInTt0G
	WHnuA05AeI8SbGRhkGkN8putKaTMyo1pZc/v5S29JbirWs25I8e1A9n62xus3JLaCh+Bn+QOGRC
	iA9JMHvSVzZ7GskHzHn1D8pzOD6wrLefMfGqKWLVi7Ve981S51zJE5S4HNPDcEmzD8L805szNAp
	XPiS0PG5ZqLbA+ktkont3AyH735TrA0NXJri5aFxECP4VTaY2PWvU2UVDcHnWbgc7bo+V2LyKvO
	wnt8ZoDCusfqzEK8PpQ5xcxYb4TV+SWf+osbTEmC44RnJz5gNivxanO88aXkb5Fd3oFCD/J0YPy
	jo70mbwv0q5BNvgZEd+wFCjnXek41F5+gpM
X-Received: by 2002:a17:903:41ce:b0:2e9:5829:9b40 with SMTP id d9443c01a7336-2e9a68d969emr74780595ad.9.1792440671136;
        Mon, 19 Oct 2026 13:11:11 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea151818f0sm5102585ad.65.2026.10.19.13.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:11:10 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf-next v6 0/3] bpf: Fix arena memory incoherence
Date: Mon, 19 Oct 2026 20:11:05 +0000
Message-ID: <20261019201108.4552-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
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

- A free keeps its range allocated until the TLB flush and the user zap
  are complete, and only then releases it with range_tree_set(). User
  faults on the range get SIGBUS until then. Frees serialize on
  zap_mutex.

- A user fault pins the page, locks its folio, and revalidates the
  kernel mapping before installing the user PTE, the way filemap_fault()
  synchronizes with truncate. The free waits for the folio lock of every
  page it removed before it zaps user mappings.

Patches 1 and 2 fix the two races. Patch 3 adds selftests.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Puranjay Mohan <puranjay@kernel.org>

v5 -> v6 (https://lore.kernel.org/bpf/20261016193703.9203-1-emil@etsalapatis.com/)

- Return the locked page from arena_vm_fault() with VM_FAULT_LOCKED
  instead of installing the user PTE there with finish_fault(). The
  fault checks PageHWPoison() before it returns the page. (Alexei)
- Give faults on a range that is being freed the same SIGBUS as faults
  on a reserved range. Drop the record of the range being freed and the
  fault-side wait. (Alexei)
- Drop the trylock and deferral scheme. Frees serialize on zap_mutex and
  zap user mappings with zap_pages(), which takes mmap_read_lock() of
  each mapping process as in mainline. Keep the single-page zap
  shortcut. Sleepable frees are deferred only when the arena spinlock
  cannot be taken, and the worker retries such a free in place instead
  of requeueing itself. (Alexei)
- Drop v5 patch 1. The worker no longer requeues itself, so the
  flush_work() in arena_map_free() waits for all of its work. (Alexei)
- Drop v5 patch 4, which retried faults when the arena lock timed out.
  (Alexei)
- Drop the immediate release of ranges without kernel PTEs; they go
  through the regular free path.
- Selftests: map the page into user space before the paused free, and
  let the fault_free_realloc reader skip reads that raise SIGBUS.

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

Emil Tsalapatis (3):
  bpf: Revalidate faulted arena pages before installing user mappings
  bpf: Fix arena race between page free and alloc leading to incoherency
  selftests/bpf: Add arena allocation race tests

 kernel/bpf/arena.c                            | 177 +++++-----
 .../selftests/bpf/prog_tests/arena_race.c     | 320 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_race.c  | 166 +++++++++
 3 files changed, 575 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_race.c

-- 
2.52.0

