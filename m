Received: from mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93375326D2
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072338; cv=none; b=ZcIIi4ViRj0B/99953U7gvwkO+zaMcGvUp8m85IaV4TOJjv7BjCwOtI8iUAPHIcPutitIjAJtI2/mKLp8k38XTNAfrxKanIcDbOrRsEX8OZJcY0r7YfBYoco7vGtjybdv88j1RpuQsSM5FtVTC0ViMS9nUQ5EnVauK2zprXqmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072338; c=relaxed/simple;
	bh=Cosv6Q7QMcJPuxGXk1cdr2Q6rkscbhpUAhVZPsCP5e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfAk3LGvsH/w5+gXCvcj7kpXFbmk53PGBZsJpCi08Xs2kwe5hqKLVy/D1oTs4myZDJMWLWnhpWlIHtFSD+jHO57H9rldH1u4yF3tgTzvTQ1PV/PtaFRVXD2u3E62cnIZWYEgurISKLMvx+TA+2fC3IFYFeW7N6Ie8mbd4DhzQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHhgMqKh; arc=none smtp.client-ip=95.215.58.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHhgMqKh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cosv6Q7QMcJPuxGXk1cdr2Q6rkscbhpUAhVZPsCP5e0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790072332; v=1; x=1790677132;
 b=hHhgMqKhY0TYmZucUupIEhfcfznNf0KxEfgzQayBVLmxkt209itwCTNSq6BYuZbdzhncvLDk
 xAgz5OqkzQVeIj8cySPqtyFfoQxR04aeGsMP70pvWGycZoBDvhkOZJGvm9Dqi4BwkXzywBYh/sd
 DEaAvUmQCGV/JWgi2QKIAtbU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f7a8795b067e54db;
	Tue, 22 Sep 2026 10:18:52 +0000
X-Mizu-Trace-ID: f7a8795b067e54db
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH bpf-next v9 0/3] bpf: arena: handle memory.max on fault-in with reclaim
Date: Tue, 22 Sep 2026 18:17:32 +0800
Message-ID: <20260922101831.192102-1-jiayuan.chen@linux.dev>
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

Preallocate the page outside the lock (patch 1), the way do_anonymous_page()
does, so the allocation can sleep and reclaim. It never invokes the OOM
killer: the page is charged to the map's memcg, which need not be the
faulting task's, so an OOM there could kill unrelated tasks in the map's
cgroup. On a genuine failure the fault returns VM_FAULT_SIGBUS. patch 2&3
adds a selftest that fills a memcg with reclaimable page cache and faults an
arena in under memory.max: without the fix the child gets SIGSEGV on a valid
address, with it the fault-in reclaims and succeeds.


v8 -> v9:
   - Trim the two comments in arena_vm_fault() to a sentence or two; the
     details are in the commit log. (Alexei Starovoitov)

v7 -> v8:
   - Merge patch 1 into patch 2. (Alexei Starovoitov)

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

v8:
https://lore.kernel.org/bpf/20260918084123.39477-1-jiayuan.chen@linux.dev/
v7:
https://lore.kernel.org/bpf/20260917015618.7488-1-jiayuan.chen@linux.dev/#r
v4:
https://lore.kernel.org/bpf/20260821050250.35112-1-jiayuan.chen@linux.dev/T/#t
v2:
https://lore.kernel.org/bpf/20260805091720.139924-1-jiayuan.chen@linux.dev/
v1:
https://lore.kernel.org/bpf/20260727062521.376231-1-jiayuan.chen@linux.dev/

Jiayuan Chen (3):
  bpf: arena: allocate the fault-in page outside the lock
  selftests/bpf: Add read_cgroup_file() to cgroup_helpers
  selftests/bpf: Add a test for arena fault-in under memory.max

 kernel/bpf/arena.c                            |  83 ++++++--
 tools/testing/selftests/bpf/cgroup_helpers.c  |  67 ++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 196 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  23 ++
 5 files changed, 353 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.43.0

