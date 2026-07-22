Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AD633374F
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703194; cv=none; b=oVtDuBCWN0vA9edTsm3NACz5tag/sX5aOiSvHAN0kVY1cS6cnhb2VmgJfk8jurLrosnYsW9z8pSY/Lylvuj4oggl4JFuGwXtbFMXzZxX8bCAMcv+m/1peCP4mN2adauWQcB+/eYmCTHh9g0ID2a2vf/AFDnBxIhxXoQnZFAs5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703194; c=relaxed/simple;
	bh=uJ81mpfV+cY6PUOb6jOG0iasrHRh6YPBw+yvt25N9bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8Wsfm/m/ZGpDlyiwpS58vDLjVafv0gzKmPFZWh8HzDQITwIVJwjIlffWT8jfu3gZkQd5MF6gbgUpAt1uYf9CPbPG5+gNjSEi0ubtM+EsnLXNGryMu5l4LduqcL2F+jf3BTKf2ClEoB8qyuvCTlFDddDqruT1mc94y77y/YCQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYIrlJvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYIrlJvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1973B1F000E9;
	Wed, 22 Jul 2026 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784703193;
	bh=e5/k9Yx+o/TY/5DoeEjIOlkNHqlf3iQf3ZrT07CcBMM=;
	h=From:To:Cc:Subject:Date;
	b=iYIrlJvb0C31gU/CxMrwpXCIElLaxYie7bBbZpBAUPcrhTrlT6Ef0Q9B8Xi+Mr2yg
	 Ub1dgIqtVqR4FwXpc3cX/av/shqmdXZcrfzE9o0ebrkQi1sFg7IKczzkVZyogXMaW4
	 C2MwDV4QEtJG6ngEUKNzYfpzfwNd9k3bWrUMrj1wNrP38QWauNYRJ/Im4MQtY0UCyM
	 NputH8BNAT21ucO1eRNZsyvrSsxHTttWdDcI38kdXBFVgN6c+w9kYk+VFPjnejdjJW
	 Ma2Glmc4UNvQsDWcNgepyCoKcz5jeLSsYpRv7oTjWhNVd72XM4Te6GqpyIdtfUwuwT
	 j2NN0IkDs3fFA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 0/2] bpf: Populate mmap-able array maps lazily
Date: Tue, 21 Jul 2026 23:53:06 -0700
Message-ID: <20260722065308.4116186-1-song@kernel.org>
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
benchmark that mmap()s/munmap()s an mmap-able array map from a
configurable number of threads, useful to observe how the cost scales
with the mapping size.

Benchmark results:

Before the patch
   nr_threads: 1, map_size: 1048576
arraymap-mmap: throughput: 0.034 +/- 0.000 M ops/s, latency: 29134.211 ns/op
   nr_threads: 1, map_size: 8388608
arraymap-mmap: throughput: 0.005 +/- 0.000 M ops/s, latency: 220365.807 ns/op
       nr_threads: 1, map_size: 67108864
arraymap-mmap: throughput: 0.001 +/- 0.000 M ops/s, latency: 1749642.119 ns/op

After the patch
    nr_threads: 1, map_size: 1048576
arraymap-mmap: throughput: 0.819 +/- 0.002 M ops/s, latency: 1221.476 ns/op
    nr_threads: 1, map_size: 8388608
arraymap-mmap: throughput: 0.808 +/- 0.005 M ops/s, latency: 1236.975 ns/op
    nr_threads: 1, map_size: 67108864
arraymap-mmap: throughput: 0.738 +/- 0.003 M ops/s, latency: 1355.100 ns/op

Song Liu (2):
  bpf: Populate mmap-able array map memory lazily
  selftests/bpf: Add mmap/munmap benchmark for array maps

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arraymap.c                         |  40 ++++-
 kernel/bpf/syscall.c                          |  17 ++
 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../bpf/benchs/bench_arraymap_mmap.c          | 146 ++++++++++++++++++
 .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 ++
 7 files changed, 221 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
 create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh

--
2.53.0-Meta
