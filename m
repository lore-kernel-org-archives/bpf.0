Received: from mta0.migadu.com (out-70.mta0.migadu.com [91.218.175.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6D380FC8
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610253; cv=none; b=uAlt9eYqLvfVScQewrt9y11EyPZ/BTGr1a5rcpQXD58HynIzFcc1lZ5cdGLiAj6MNuRwiJYONJySITdg9sc7indcPVb7E5Q8M2qbgkXdkvZMouzz2MQt9133e9zyySvxuIw9FMnQ4Bfd3MC+wy+Er3ZrIzznGStsNy6tzMc+9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610253; c=relaxed/simple;
	bh=VrWoURvvl56BkD3Ktx89+dTULUYId6JOYbgJrG5Pidg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSXnEPKpQNUFDTJEUUO0gNsA6Wzf45MNONQ/OYMmX0bK0YebYCBhwNVD58qy5hAlnYnd2ItjYNUIlKytXW9ryCnWpDIwBI4Aca8YY5Rw237ShxVpaCAUMfH4c9HqSkUZEh7HkjKxaofhj8wHK3FRv1NkYomHhjlw8srqjzBI+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ne/SoDm7; arc=none smtp.client-ip=91.218.175.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ne/SoDm7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VrWoURvvl56BkD3Ktx89+dTULUYId6JOYbgJrG5Pidg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789610246; v=1; x=1790215046;
 b=Ne/SoDm7SZu+OKGxTLswRRM04+ogs+9fT4LETvcWqGm1cDrmB/UqtTS+DzZR2/wo+O9yn7aM
 bBXf48+6aACpzAE94cKCCiaMGfzeVAPHfcxEMhYmvivMpHEN2LnqUodun+q2ew7PvMeVCtbvS1L
 kfgxhaGA1Uxn/C2Rfm2ir/hA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1e691b0d3b488a22;
	Thu, 17 Sep 2026 01:57:25 +0000
X-Mizu-Trace-ID: 1e691b0d3b488a22
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v7 0/4] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Thu, 17 Sep 2026 09:55:05 +0800
Message-ID: <20260917015618.7488-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e66fe1bc6d25 ("bpf: arena: Reintroduce memcg accounting"),
arena pages are charged to the memcg of the process that created the arena.
That exposes a problem in the arena user page fault path: the fault-in
allocation runs under arena->spinlock, so it can only use the non-blocking
allocator, which never reclaims. Once memory.current is at memory.max the
allocation simply fails, even when the memcg is full of page cache that
could be dropped right away. Reaching memory.max is completely normal for a
healthy application - e.g. reading a large file fills memory.current with
page cache - and the process then gets SIGSEGV on a perfectly valid arena
address.

Preallocate the page outside the lock (patch 2), the way do_anonymous_page()
does, so the allocation can sleep and reclaim. It never invokes the OOM
killer: the page is charged to the map's memcg, which need not be the
faulting task's, so an OOM there could kill unrelated tasks in the map's
cgroup. On a genuine failure the fault returns VM_FAULT_SIGBUS. This needs a
sleepable allocator (patch 1), because bpf_map_alloc_pages() can use the
non-blocking allocator, which never reclaims. patch 3&4 adds a selftest that
fills a memcg with reclaimable page cache and faults an arena in under
memory.max: without the fix the child gets SIGSEGV on a valid address, with
it the fault-in reclaims and succeeds.


v4 -> v7:
   - Simplify the implementation: do not aim for OOM anymore. An arena is
     shared between processes and can be shared across cgroups, so the OOM
     killer is the wrong tool here - it would act on the map's memcg, which
     need not be the faulting task's. Only try to reclaim now, via
     __GFP_RETRY_MAYFAIL. Everything else is kept as before.
   - selftest: changed accordingly - fill the memcg with reclaimable page
     cache and check that the arena fault-in succeeds by reclaiming it,
     instead of relying on an OOM kill.

v3 -> v4:
   - rebase bpf-next and fix conflict
   - add Reviewed-by tag from Emil Tsalapatis

v2 -> v3:
   - selftest: check the memcg OOM via memory.events "oom_kill" instead of
     the exit signal; it only aims to pass on the fixed kernel, since the
     unfixed SIGSEGV is racy.

v1 -> v2:
   - Rebase on the separate deadlock fix (found by the Sashiko AI review),
     now applied to bpf-next.
   - Honor the map's NUMA node on fault-in.
   - Return VM_FAULT_SIGBUS for the non-recoverable faults (lock, range-tree
     and page-table failures); a scratch-page hole stays VM_FAULT_SIGSEGV
     only under BPF_F_SEGV_ON_FAULT. (Kumar Kartikeya Dwivedi)
   - Add read_cgroup_file() to cgroup_helpers instead of open-coding the
     /mnt/... path in the test. (Emil Tsalapatis)
   - Dump the cgroup memory stats on test failure to ease debugging.

v4:
https://lore.kernel.org/bpf/20260821050250.35112-1-jiayuan.chen@linux.dev/T/#t
v2:
https://lore.kernel.org/bpf/20260805091720.139924-1-jiayuan.chen@linux.dev/
v1:
https://lore.kernel.org/bpf/20260727062521.376231-1-jiayuan.chen@linux.dev/

Jiayuan Chen (4):
  bpf: Add a sleepable page allocator for map memory
  bpf: arena: allocate the fault-in page outside the lock
  selftests/bpf: Add read_cgroup_file() to cgroup_helpers
  selftests/bpf: Add a test for arena fault-in under memory.max

 include/linux/bpf.h                           |   1 +
 kernel/bpf/arena.c                            |  86 ++++++--
 kernel/bpf/syscall.c                          |  28 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  67 ++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 196 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  23 ++
 7 files changed, 381 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.43.0

