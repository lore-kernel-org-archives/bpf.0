Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E41372B45
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563926; cv=none; b=I+GmXS/szcmrMIiP4Wq34UNG1C3Bq55ylxdqaEy6TPleLsfkfRa71BXWKjSVBo8sCNC0oGjYkhSww2SdIQIhgz06Z+UwwnpIgOHM6f5/FMgcPFF6l3XsKFpjmzo8cYYcCdC1+f1Z6802BBH9AnAZ0Kskmx1H2Pu/pqny4Bu9Cfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563926; c=relaxed/simple;
	bh=KaS0ypCeP3wS1mU7/FuFqA6jDq/HI79w+q1Gh97MSgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFSWN6nt1Qv2FBGJcRPpcGnV+LWMLd68/kJnddRTNchjwKkIoMwvvB7P9LppCZNMP96z6CjKafATKLa5kNQUXEidgLg/+GYfIUqw3v6SoC666T5FfRACvlwgXrAE99kzOqMfexbm0+AvYUMbNNaDmNGK0kfSFFjCsyqoN/vybGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjXQMdKH; arc=none smtp.client-ip=95.215.58.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjXQMdKH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KaS0ypCeP3wS1mU7/FuFqA6jDq/HI79w+q1Gh97MSgo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787563921; v=1; x=1788168721;
 b=LjXQMdKHkqHgmsyaTlaN1R1biYEobl4/4Iqu99mTM/MLwY7FL3DhglNpAAnF7O1I0ZWl9pRC
 NR2aqX9Vwsf8wd/iNsr3ikxuuivjw4Ja9q9Kv/CHXC7CCczRY1AcvSOH+lpX9u7fMh+lXSBspSc
 0EtPUVBSd9UbqF2DPmcmLyk4=
X-Envelope-To: bpf@vger.kernel.org
Received: from localhost.localdomain (147.136.157.2)
	by smtp.migadu.com with ESMTPS id a80a2cd212814040;
	Mon, 24 Aug 2026 09:32:01 +0000
X-Mizu-Trace-ID: a80a2cd212814040
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v5 0/4] bpf: arena: handle memory.max on fault-in with reclaim/OOM
Date: Mon, 24 Aug 2026 17:29:51 +0800
Message-ID: <20260824093122.362135-1-jiayuan.chen@linux.dev>
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
That accounting exposes two problems in the arena user page fault path.

1. The fault-in allocation runs under arena->spinlock, so it can only use the
   non-blocking allocator, which never reclaims. Once memory.current is at
   memory.max the allocation simply fails. Reaching memory.max is completely
   normal for a healthy application - e.g. reading a large file fills
   memory.current with page cache - so the process ends up killed for no real
   reason.

2. That failure is turned into VM_FAULT_SIGSEGV, which is misleading: the
   faulting address is a perfectly valid arena address. The memcg OOM killer
   should run instead, and a genuine out-of-memory should surface as a
   non-recoverable fault, not a bogus segfault.

Preallocate the page outside the lock (patch 2), the way do_anonymous_page()
does, so the allocation can sleep, reclaim and run the memcg OOM killer. On a
genuine failure the fault is non-recoverable and returns VM_FAULT_SIGBUS; a
task faulting its own arena is unaffected, the OOM killer picks it inside the
allocation and it dies by SIGKILL. This needs a sleepable allocator (patch 1),
because can_alloc_pages() is a conservative guess for BPF program context and
always forces the non-blocking allocator under PREEMPT_RT. patch 3&4 adds a
selftest that faults an arena in under a memory.max limit: without the fix the
child gets SIGSEGV on a valid address, with it the child is killed by the
memcg OOM killer.


v4 -> v5:
   - arena: return VM_FAULT_SIGBUS instead of VM_FAULT_OOM when the fault-in
     allocation fails. The allocation already ran reclaim and the OOM killer,
     so the failure is non-recoverable; VM_FAULT_OOM would be retried by the
     fault path and can livelock a task faulting a shared arena whose memcg
     OOM killer cannot reach it. (reported by the Sashiko AI review)
   - selftest: cap the arena at 50000 pages so it stays under the 4G arena
     limit on 64K-page kernels.
   - selftest: ASSERT_OK setup_cgroup_environment(), print a reason on the
     no-memory-controller skip, and flush only stderr in the child.

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
 kernel/bpf/arena.c                            |  90 +++++++---
 kernel/bpf/syscall.c                          |  21 ++-
 tools/testing/selftests/bpf/cgroup_helpers.c  |  67 ++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   4 +
 .../selftests/bpf/prog_tests/arena_memcg.c    | 158 ++++++++++++++++++
 .../testing/selftests/bpf/progs/arena_memcg.c |  24 +++
 7 files changed, 340 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_memcg.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_memcg.c

-- 
2.43.0

