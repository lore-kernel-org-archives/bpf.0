Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9788C3B1B4
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785283841; cv=none; b=Q6OjdSmL6ArROWHh0O5FgyKA7XHoMcVojJN+BAbhW9eAcB5jEBwKgRTCLueAwtgdZ1g1erMAbYW9Ik2ym4sYSNY7KMjYg7s7wjoVz8vGGHNJ53PkTaGUjEJFGSGEPv3zSNnHdkAvyyY+S5f7uFmEgXmUvmJVamNS2eK/0uS/3ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785283841; c=relaxed/simple;
	bh=uCPQne/8XBl3eLZRFHiCUq0KIGynt5jkD124groUBFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nj11id+1sbYN7DhB67uq44NaQVj3C2V1hUHoBfQC+a8XfE6T5jJNekKVbMy4hnF42xkOJAzw7TtrcWeGMGuNC3dDMSGlHj4AB4pNnyKY66M1t0CbnqgHfSkDf+1Bt6gUfWIW352r0tTrGZQ4NxzuEuDGgm6YLgP4KasO12lDofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR4vBEas; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR4vBEas"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F651F000E9;
	Wed, 29 Jul 2026 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785283840;
	bh=wYfRgpX3lWKzZdYHTfRLBQQPd8tze/gE7I/nq0x9DME=;
	h=From:To:Cc:Subject:Date;
	b=NR4vBEasE6czT5F7X8tPHmwN8E9yH+1k+XlK/apY961GR48VU3Z+B/qOIXBdLVrlo
	 NmyRMRBrtYGTMP+3V1dsGoCYZU0NJPA0scmWgznfmE7s8R76TbrAMZRnA0PUdrBDfj
	 5rreNkaDyLtDYV+P7N0LRNjhHupM6+b8KEsRFNJAzmwLEVR+SCg0gkRDN9wRo6Ecud
	 V3n5XAN8emXHL2pIn6hmJM/06JzGB4JkIXywIBdKGka6DpTVZ4Pha8MwPmXyYV+Ufm
	 2Y6DFoWu6UBW+HIYz3tHrJ6CJF58ZDuiVVakp23eEbWZ6wKMbdDw8Jle9MNKOyRYX7
	 b1b2QAbkfpSmA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 0/1] bpf: Populate mmap-able array maps lazily
Date: Tue, 28 Jul 2026 17:10:32 -0700
Message-ID: <20260729001033.3433328-1-song@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
vmalloc'ed up front at map creation time. array_map_mmap() then wires up
the whole mapping eagerly via remap_vmalloc_range(), which calls
vm_insert_page() for every page of the map. This makes every mmap() cost
O(number of pages): an 8MiB map inserts 2048 PTEs on each mmap() and
tears them all down again on munmap(), even when user space only touches
a few pages (or none at all).

Populate the mapping lazily instead, the same way the arena map already
does. array_map_mmap() only performs the bounds check and returns, and
the pages are inserted on demand by a new ->map_mmap_fault handler. This
turns mmap()/munmap() of an mmap-able array from O(map size) into O(1).

To keep populating a large mapping cheap, a ->map_pages (fault-around)
handler batch-installs PTEs for the whole fault-around window under a
single page-table lock, so that mmap(MAP_POPULATE) and linear access
patterns do not take one full fault per page. Both handlers are reached
through new optional callbacks dispatched from the shared
bpf_map_default_vmops, keeping the existing VMA open/close accounting
(VM_MAYWRITE write-active tracking, freeze handling) centralized.

Callers that want the pages populated up front can still request that
explicitly with MAP_POPULATE. Kernel-side access to the map (via the
vmalloc address) is unaffected.

This posting contains the kernel change only; the arraymap-mmap
benchmark used to gather the numbers below will be sent separately.

Changes in v3:
- Add a ->map_pages (fault-around) handler so mmap(MAP_POPULATE) and
  linear access populate PTEs in batches instead of one fault per page.
- Harden the fault path with check_shl_overflow() and explicit bounds
  checks instead of a plain (u64) cast. (Andrii)
- Drop selftests (2/2 in v2). (Andrii)

v2: https://lore.kernel.org/bpf/20260722205032.1245094-1-song@kernel.org/
Changes in v2:
- Use 64-bit arithmetic for the mmap offset/bounds check to avoid a
  potential overflow on 32-bit architectures.
(Both v2 and v3 hardening were prompted by the Sashiko AI review.)

v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.org/

Benchmark results:

For 8MiB, access times are microseconds (us).

Before:
no MAP_POPULATE (do not access pages) 220us
no MAP_POPULATE => access all pages: 252us
MAP_POPULATE (do not access pages) 304us
MAP_POPULATE => access all pages: 334us

After:
no MAP_POPULATE (do not access pages): 1.2us
no MAP_POPULATE => access all pages: 543us
MAP_POPULATE (do not access pages): 262us
MAP_POPULATE => access all pages: 286us

Key take aways from these tests:

MAP_POPULATE is not a noop for old kernels. The pre fault mechanism still
adds some overhead (for almost no gain). For 8MiB mmap, MAP_POPULATE addes
about 80us.

Compared against v2, we further improved MAP_POPULATE with a batch pre
fault (vm_operations_struct->map_pages). With batch pre fault, mmap then
accessing 8MiB is about 34us slower than the best option before the set:
  before: no MAP_POPULATE => access all pages: 252us;
  after: MAP_POPULATE => access all pages: 286us.

Note that, all the above are worst cases: we need to access all pages
and fill the page table one way or another. If we don't need to access
all pages, the change saves a lot (220us => 1.2us) for the mmap.

Song Liu (1):
  bpf: Populate mmap-able array map memory lazily

 include/linux/bpf.h   |   3 ++
 kernel/bpf/arraymap.c | 112 ++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  30 +++++++++++
 3 files changed, 141 insertions(+), 4 deletions(-)


base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
--
2.53.0-Meta
