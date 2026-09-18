Received: from mta0.migadu.com (out-121.mta0.migadu.com [91.218.175.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D3231A23
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714759; cv=none; b=BDijuv+sXypcvDPlpIoyPYGSrPSLYs9jPhsFkBkTZerP2rCXmTMYS4MRXOL3JW8uRYxIqSa9qMv3FlbiyZIRRJm9UjlNg37atrFeDQ2bSE2FnJMOD3mwxdte1JSA1Qc5ThAf2UYsrNFjUaKb97VyJH2arSTurwRETBjLuuK8/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714759; c=relaxed/simple;
	bh=u1IH4r+aCqyNvijH53MjoE8PjJY5Tc0reOM1hN6q8Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJ3wOEiJJCNhEqYXXD+Tnk/cknFB33le3zCxPpQcjK2RwFX0N/06kbisI8YBt1kKV6mOackOOIuWN4d81O5vXJd2SvkVKp7a2dU/0jW513APcVSg/OEZMbEY9n98LJx+bDdCBriKZfhMrhI3RepVTk2YOnm4tFI04574FqazK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uRwO2IXc; arc=none smtp.client-ip=91.218.175.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uRwO2IXc"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u1IH4r+aCqyNvijH53MjoE8PjJY5Tc0reOM1hN6q8Mk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789714753; v=1; x=1790319553;
 b=uRwO2IXcuSW7ibNUBrUz4NkMG4g5en1HjU7zsuTPhv7FJ80v679HbmL+Lw0FVVf6C3pLE2pK
 bjepdE0bL/w5NR5guWh5n30JWXK2wPHAAdbyr3x8RKNTZZSAKmjMmu4NaNZ0winicMhsUkkPxwb
 UiptNOjbzCToVFiGFpTAI3u0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fe34583bbf42bfe1;
	Fri, 18 Sep 2026 06:59:13 +0000
X-Mizu-Trace-ID: fe34583bbf42bfe1
X-Migadu-Flow: FLOW_OUT
From: Hui Zhu <hui.zhu@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v12 0/2] bpf: BPF-driven proactive memcg reclaim
Date: Fri, 18 Sep 2026 14:58:52 +0800
Message-ID: <cover.1789714023.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

BPF programs can observe memory pressure on a cgroup (e.g. refault
stats via bpf_mem_cgroup_page_state()), but cannot act on it:
triggering reclaim on a chosen cgroup requires writing to
memory.reclaim, which BPF cannot do. This series adds
bpf_proactive_reclaim(), a sleepable kfunc performing one proactive
reclaim pass on a target memcg, so when and how hard to reclaim is
BPF policy rather than hard-coded thresholds.

The kfunc is restricted to BPF_PROG_TYPE_SYSCALL so that reclaim
always runs in a clean process context: generic sleepable programs
may execute with filesystem locks held or in NOFS/NOIO contexts,
where the reclaim path could deadlock in filesystem shrinkers. The
bpf_wq and task_work callbacks of a SYSCALL program keep its program
type and run in process context, so reclaim work can still be queued
asynchronously through them, as the selftest does with bpf_wq.

The use case we are looking at is protecting high-priority workloads:
a BPF program monitors the state of a high-priority cgroup and, when
it degrades (e.g. PSI rises or refaults increase, as in the
selftest), asynchronously reclaims memory from low-priority cgroups
via bpf_wq and bpf_proactive_reclaim(), giving the pressured cgroup
more free pages.

Another use case: several vendor-maintained kernels carry private
implementations that trigger asynchronous reclaim when a memcg enters
a certain state. These exist for historical and partly psychological
reasons, but the underlying demand is real. We expect BPF-driven
proactive reclaim, combined with the BPF hooks for the memory
controller currently under discussion and development, to serve these
needs in mainline, reducing kernel fragmentation and improving kernel
maintainability.

Benchmark numbers from the selftest (TEST_MEMCG_ASYNC_RECLAIM_BENCH=1
runs the workload once without the BPF program and once with it; QEMU
VM with 8 GiB RAM and 10 vCPUs, 10 runs): the pressured workload
finishes in a median of 2.0s with BPF-driven async reclaim versus
15.3s without, a 62%-94% improvement per run. The harvested workload
shares the parent's memory.max with it and finishes in a median of
7.5s versus 12.2s, as it has the limit to itself once the pressured
workload finishes early.

Raw benchmark output of the 10 runs (one line per run, all passed):
memcg_async_reclaim: baseline high=15.331030 low=10.662426, reclaim high=2.311867 low=4.912402, high speedup=84.9%
memcg_async_reclaim: baseline high=10.788771 low=15.127507, reclaim high=3.061484 low=4.518388, high speedup=71.6%
memcg_async_reclaim: baseline high=16.553653 low=12.281844, reclaim high=2.586470 low=9.890286, high speedup=84.4%
memcg_async_reclaim: baseline high=18.032006 low=14.058724, reclaim high=1.713115 low=3.967476, high speedup=90.5%
memcg_async_reclaim: baseline high=15.253594 low=12.101572, reclaim high=1.880957 low=4.478044, high speedup=87.7%
memcg_async_reclaim: baseline high=5.454157 low=9.781724, reclaim high=2.035418 low=10.322757, high speedup=62.7%
memcg_async_reclaim: baseline high=10.010656 low=3.029734, reclaim high=1.947231 low=10.162948, high speedup=80.5%
memcg_async_reclaim: baseline high=18.201170 low=15.182740, reclaim high=1.510723 low=9.390685, high speedup=91.7%
memcg_async_reclaim: baseline high=10.772079 low=5.418259, reclaim high=2.325059 low=13.225425, high speedup=78.4%
memcg_async_reclaim: baseline high=16.360502 low=14.506304, reclaim high=0.864310 low=5.624312, high speedup=94.7%

Changelog:
v12:
Redo performance tests and update performance data.
According to the comments of Barry, fix comments issue.
Based on the AI review and my re-examination of selftests, updated the
contents below.
Express RECLAIM_SIZE in bytes so it is right on non-4K page kernels.
Drop the local PAGE_SIZE macro, RECLAIM_SIZE is now a byte count.
Remove the unused bpf_helpers.h, bpf_tracing.h and bpf_core_read.h.
Rename CLOCK_MONOTONIC_ID to CLOCK_MONOTONIC to match the kernel.
Drop the CSS_DYING test, it is never set on a cgroup's own css.
Document that the lookup fails inside rmdir(), not at last put.
Count bpf_timer_start() failures so a stalled loop is visible.
Record the kfunc errno so failure is not read as an idle cgroup.
Note that an idle tick discards the refault delta.
Reject tmpfs for /tmp and the working dir, else the workload OOMs.
Pass the mkstemp() fds to the children so no stale path is reopened.
Read the timing file with lseek() and read() on the shared fd.
Write the timing with snprintf() and write(), checking truncation.
Close the data and time fds on every cleanup path.
Remove fcntl.h, nothing calls open() any more.
Factor disable_swap() out of the two cgroup setups.
Recreate the cgroups between bench runs so both start cold.
Guard the speedup calculation against a zero baseline.
Drop the non-bench timing printf, it was noise on passing runs.
Assert only TARGET_GONE, the outcome rmdir() actually guarantees.
End the wait loop only on target_gone so later events are seen.
Compare reclaimed_bytes against 0, a check that can now fail.
Poll the keepalive reader with WNOHANG and report its exit code.
Clear reader_pid after reaping so cleanup cannot kill a new PID.
Rename the ring_buffer__poll() result to n, it counts events.
Print timer_failures and last_reclaim_err when an assert fails.
Explain why bench_printf() needs the stdout fallback and no # prefix.
v11:
According to the comments of Kumar, fix reclaim_cgroup() to not treat
a negative bpf_proactive_reclaim() return as reclaimed bytes.
According to the comments of Shakeel, shorten the commit message.
v10:
According to the comments of JP, drop redundant swap.h include, turn
swappiness macros into a BTF-visible enum, and clarify the -1 swappiness
semantics in docs and code in code patch.
report each reclaim outcome via ringbuf and wait for events with timeout
instead of sleep-polling, log workload timings instead of failing on
them, drop a debug printf, and add a TEST_MEMCG_ASYNC_RECLAIM_BENCH
baseline-comparison mode in the selftests patch.
Include the benchmark numbers in the cover letter.
v9:
According to the comments of JP, copy the motivation from the cover
letter to the commit message, restructure the kfunc documentation
to separate the direct and asynchronous calling contexts, fold the
fs-lock warning into the SYSCALL-only rationale, soften the "bounded
unit of work" wording (only the reclaim target is capped), and drop
the redundant comment above the reclaim kfunc set registration.
v8:
According to the comments of Andrew, Kumar and Shakeel, drop the
bpf_in_reclaim_context() check because the SYSCALL-only restriction
already rules out reentrancy.
According to the comments of Kumar, Add the swappiness argument to
bpf_proactive_reclaim().
v7:
According to the comments of JP, clamp the reclaim target of one
bpf_proactive_reclaim() call to MEMCG_CHARGE_BATCH so each call is
a bounded unit of work, and document the batching policy in the kfunc.
selftest: check the target cgroup for dying state before reclaiming
from it, and add the memcg_async_reclaim_dying test covering target
removal while reclaim is running.
v6:
According to the comments of Kumar and Shakeel, Restrict
bpf_proactive_reclaim() to BPF_PROG_TYPE_SYSCALL by moving it
to a dedicated kfunc set registered for that program type only, and
document the clean-process-context requirement in its kerneldoc.
v5:
According to the comments of Andrii, Kumar and Shakeel, remove
bpf_proactive_reclaim_swappiness.
v4:
According to the comments of bot+bpf-ci and sashiko, also check
current->reclaim_state to close the fentry-on-trace-iter recursion
window in bpf_in_reclaim_context.
Return bytes instead of pages ( nr * PAGE_SIZE ) in
bpf_proactive_reclaim_pages and bpf_proactive_reclaim_swappiness.
Return (unsigned long)-1 on out-of-range swappiness (was 0).
Kdoc of both kfuncs: updated Return descriptions; added FS-lock deadlock
warning to bpf_proactive_reclaim.
Fix potential child process leak in selftests.
Use _exit() instead of exit() in forked children in selftests.
Rename reclaimed_pages to reclaimed_bytes in selftests.
Fix comments issues in selftests.
v3:
According to the comments of bot+bpf-ci, add a shared helper
bpf_proactive_reclaim_pages() that is called by bpf_proactive_reclaim
and bpf_proactive_reclaim_swappiness.
According to the comments of sashiko and bot+bpf-ci, fix the issues of
selftests.
v2:
According to the comments of Shakeel Butt, replace
bpf_try_to_free_mem_cgroup_pages() with
bpf_proactive_reclaim(memcg, size) and
bpf_proactive_reclaim_swappiness(memcg, size, swappiness).
According to the comments of Kumar Kartikeya Dwivedi, drop patch 2
and patch 3.
Remove bpf_thread_wq code in patch 4.
According to the comments of sashiko-bot, fix the issues of selftests.

Hui Zhu (2):
  mm/bpf: Add bpf_proactive_reclaim kfunc
  selftests/bpf: Add memcg async reclaim test

 mm/bpf_memcontrol.c                           |  62 +-
 mm/internal.h                                 |  10 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/memcg_async_reclaim.c      | 890 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 327 +++++++
 5 files changed, 1285 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

-- 
2.43.0

