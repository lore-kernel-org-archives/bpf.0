Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D12FD1B3
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753447; cv=none; b=ZS39HtRIyvTGQWbf+teIc/iNvuX9EigO07iMEPzdkZAAZXQFruZNrtzhym8WUgIM9A5mPhBkXYpqd5wVQwFgh2AZ+k86Ilawm1pQm8y/0AW2+zc3aNwhioqr7qOFYN125plbtrJSyijNqESXIWw8iGaZc3mnjuqbIJH7Zi7zIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753447; c=relaxed/simple;
	bh=57lz7lP7jjhQmgOrivsGD3d4mCCcPqgPpygeusf4XmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvlVeCDZZkYvsblt6GGKGaDAIyg6QWVdbtQ+Zu7h7u3d0HUapu2oM0QcAkyDDYAIcHbk9p6lIbJhAVAO3i6bu4V8wTG3jWVrK1C7u1yb/nOuiYL/J8YbgO5tYpyabf3hAKwU79bpk9xI2sldT6JeQP+5eIk4Qgaun/ubCkM3+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Biqvyne9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biqvyne9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EE51F000E9;
	Wed, 22 Jul 2026 20:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753445;
	bh=JQ41edW1TeNPLcg9KvY1++giWWezPyUbayVsWSM4QoA=;
	h=From:To:Cc:Subject:Date;
	b=Biqvyne9/yBQaz+vvFBqFl015ylRC+lVnaFsRTTVRSdl9UBmaZ3Jz6EVXJ/zR323G
	 ki2O1FseR6296CrQOrvJdD7gv31Gz1Osv9WXzxLObABiqK26XKIqO0fusOz1FA2ZB2
	 xE6w5P4U1sXY9NgFD9WpuSCCHrBP6ngH0cp0N0hGvnViZIkbr829X4ho04BC1n1ZwA
	 AeIxwP6LWePMx84S6weYWbNIz9YJrSXYoI+Oy+mXsXXozovoSPubuYxWTrbZMyPtqj
	 LvJU89KohEKOcNJ1S0twaUQ6as2+IR7+HivKwIQmpzXJv2XI81pOeeP8pwQisVn0eW
	 rKPaq+vJoIrIw==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 0/2] bpf: Populate mmap-able array maps lazily
Date: Wed, 22 Jul 2026 13:50:30 -0700
Message-ID: <20260722205032.1245094-1-song@kernel.org>
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

This series makes the mapping populate lazily instead, the same way the
arena map already does, turning mmap()/munmap() of an mmap-able array
from O(map size) into O(1). The pages are inserted on demand by a new
map_mmap_fault() callback, dispatched from the shared
bpf_map_default_vmops so that the existing VMA open/close accounting
(VM_MAYWRITE write-active tracking, freeze handling) stays centralized.

Callers that want the pages populated up front can still request that
explicitly with MAP_POPULATE, matching regular file semantics.
Kernel-side access to the map (via the vmalloc address) is unaffected.

Patch 1 implements the lazy faulting. Patch 2 adds an "arraymap-mmap"
benchmark that mmap()s/munmap()s an mmap-able array map, useful to
observe how the cost scales with the mapping size.

Changes in v2:
- Compute the mapping offset with 64-bit arithmetic in array_map_mmap()
  and the fault handler so that a large vm_pgoff cannot overflow the
  bounds check on 32-bit architectures. remap_vmalloc_range(), which is
  no longer used, used to guard against this.
- Benchmark: use the standard -p/--producers option for the thread count
  instead of a custom --nr-threads option. The v1 approach set
  env.producer_cnt from validate(), which runs after the framework has
  already sized the producers array, causing an out-of-bounds write.
(Both issues were pointed out by the Sashiko AI review.)

v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.org/

Benchmark results (single producer thread, ./bench -p1):

Before the patch
  nr_threads: 1, map_size: 1048576
arraymap-mmap: throughput: 0.034 +/- 0.000 M ops/s, latency: 29187.164 ns/op

  nr_threads: 1, map_size: 8388608
arraymap-mmap: throughput: 0.005 +/- 0.000 M ops/s, latency: 220910.150 ns/op

  nr_threads: 1, map_size: 67108864
arraymap-mmap: throughput: 0.001 +/- 0.000 M ops/s, latency: 1765083.440 ns/op

After the patch
  nr_threads: 1, map_size: 1048576
arraymap-mmap: throughput: 0.838 +/- 0.001 M ops/s, latency: 1193.553 ns/op

  nr_threads: 1, map_size: 8388608
arraymap-mmap: throughput: 0.811 +/- 0.002 M ops/s, latency: 1232.728 ns/op

  nr_threads: 1, map_size: 67108864
arraymap-mmap: throughput: 0.747 +/- 0.004 M ops/s, latency: 1339.051 ns/op

Song Liu (2):
  bpf: Populate mmap-able array map memory lazily
  selftests/bpf: Add mmap/munmap benchmark for array maps

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arraymap.c                         |  43 +++++-
 kernel/bpf/syscall.c                          |  17 +++
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_arraymap_mmap.c          | 127 ++++++++++++++++++
 .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 +++
 7 files changed, 204 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh

--
2.53.0-Meta
