Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2FD39FCCD
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353067; cv=none; b=kdT+SOwnUDZbBLlwdx58F7JBXArZT5k3WYdpWg6c8PuFejjhpNzTflihuM5MF2t1KsUcC1/8ymxntNbvEBPeRsaB+eE1rmQlFsHw1wm8opQ/mEW/aDF+aSw/4P9I8Hp3FS1Qv2HhddxcnXPG1NPFx31Tdb69AUbckFB41VGTcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353067; c=relaxed/simple;
	bh=nTLe7C8rX9Nmmw9o6OnXJOw8W+wtIbWr8iKQExO6urE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daPuRVkVe5VhRRRfkYF4SXBWqI48ohWeZsv9y+OoRrv3NbCc1bTCn2ykTCeyyMtJjaMlxNxv3H0/aF2HiO6IZ52DVhtPsKRpPRnRtex7rC1nxF6ZDSaByrULEnjFEMWJDX5m/JRArdPu5XQFDsSe+7kXOHotVUHf2/295m/NxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBtagRuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBtagRuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B071F000E9;
	Wed, 29 Jul 2026 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785353066;
	bh=/OPXhHSovjcBYja0yxNOCtpk5qBauAYzll+1m360ikY=;
	h=From:To:Cc:Subject:Date;
	b=GBtagRuoquLTwLU9Gv0L0oz81TiNgqHtrCP44cXsOGeuvI7fhOfvk/lPjEMjsW9UC
	 gEbQJJ+I1BGxl+lPg3EF5nXY+lj7F9G/niTthwA33ofupjN98Jj9ieGDjN+S+RlMIq
	 KoqMXuie9ta4IyiQNXNPXomF/n+ly2bU4wxPOWlrtSyCOanoBP4B5Y1T0arOqAzTir
	 JOie9f13G1YJs9s/AamemjzBWn93QBqIBJcsjTozWRJ7z86iU6ZoK4HAXd4OcX+2oX
	 2Cy2bTpnyDNc8RvCb7lErePhKIHAM7Hw8RAjTKm12pJbs6pxjKgWe0x5FwAGWiutwe
	 k0nRKqMJs4OiA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v4 bpf-next 0/1] bpf: Populate mmap-able array maps lazily
Date: Wed, 29 Jul 2026 12:24:18 -0700
Message-ID: <20260729192419.41331-1-song@kernel.org>
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

Lazy faulting needs an MMU; on !CONFIG_MMU array_map_mmap() keeps
populating the mapping eagerly via remap_vmalloc_range().

Callers that want the pages populated up front can still request that
explicitly with MAP_POPULATE. Kernel-side access to the map (via the
vmalloc address) is unaffected.

This posting contains the kernel change only; the arraymap-mmap
benchmark used to gather the numbers below will be sent separately.

Changes in v4:
- Flush the D-cache before exposing a page at a new user address, as the
  eager vm_insert_page() path did. (Sashiko AI review)
- Fix the build on !CONFIG_MMU: include <linux/pgtable.h>, keep the
  fault handlers under CONFIG_MMU, and populate eagerly for !CONFIG_MMU.
  (kernel test robot)

v3: https://lore.kernel.org/bpf/20260729001033.3433328-1-song@kernel.org/
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
no MAP_POPULATE (do not access pages): 1.2us.2us
no MAP_POPULATE => access all pages: 537us
MAP_POPULATE (do not access pages): 270us
MAP_POPULATE => access all pages: 276us

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

 include/linux/bpf.h   |   3 +
 kernel/bpf/arraymap.c | 140 ++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  30 +++++++++
 3 files changed, 169 insertions(+), 4 deletions(-)


base-commit: fdec474c65fd35d5a6e1497ed50a9f98c07192f0
--
2.53.0-Meta
