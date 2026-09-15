Received: from mta0.migadu.com (out-238.mta0.migadu.com [91.218.175.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C264A8FCB
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475411; cv=none; b=t70QZOOHLnIyitN3qvr7cU8E0pvu0EvtnxFrantgz15csHsyDDxxzwjbW8vmhP/NvZhSVLfqQmR7/NNybVIRqpN+yg/trYeZKRq6yYvp9BbJtSInFutVcsj1v5xRL6kGcI4YwWun9EqUvWuReZRbkdwDLKgB4uTKdPd6Wdfefus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475411; c=relaxed/simple;
	bh=nJ8Tf3/omubO5lmb4Qg6Pf8rR5Fq4Yd4BwGCvB4CKvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bV+t3QBYIDirLfkllb0kiqIsovZrpjEFmQen7sOaoL8fO0wG/N7WzH5T3JNOsCGBoUtVBcosi18iabxe6RZtlNFzvz/GFSBbeecdgRqhIs5cW38bJF6jfoNPNIMpIxeG0TmizWaL51oGQTdFobhYnIvjd/aAiKw5DSqI3VtoyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UkX0doXq; arc=none smtp.client-ip=91.218.175.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UkX0doXq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nJ8Tf3/omubO5lmb4Qg6Pf8rR5Fq4Yd4BwGCvB4CKvo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789475407; v=1; x=1790080207;
 b=UkX0doXq00/eVcQ7S7gJCMJ64BNdbiXzzf91ROlbt9xDkV73Fh+hwLr57D5tTkwbXuvDOyQt
 EhiWMhDX/TQzM4H2l84ezOOqt07XOfVvf2bjh5e9Rif7RmN6dHUhOXBiOebzRtdk/yfyTlj4JRh
 ctuYx5UGqKncU7MhGVzUTxsw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 4aa4d6d5ceb44ce6;
	Tue, 15 Sep 2026 12:29:57 +0000
X-Mizu-Trace-ID: 4aa4d6d5ceb44ce6
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
	Barry Song <baohua@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [PATCH bpf-next v11 0/2] bpf: BPF-driven proactive memcg reclaim
Date: Tue, 15 Sep 2026 20:29:34 +0800
Message-ID: <cover.1789475073.git.zhuhui@kylinos.cn>
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
finishes in a median of 2.1s with BPF-driven async reclaim versus
12.0s without, a 51%-90% improvement per run. The harvested workload
shares the parent's memory.max with it and finishes in a median of
5.1s versus 9.7s, as it has the limit to itself once the pressured
workload finishes early.

Raw benchmark output of the 10 runs (one line per run, all passed):
memcg_async_reclaim: baseline high=4.081880 low=8.951780, reclaim high=2.000056 low=10.872397, high speedup=51.0%
memcg_async_reclaim: baseline high=15.803050 low=14.594268, reclaim high=1.567874 low=4.848877, high speedup=90.1%
memcg_async_reclaim: baseline high=5.222607 low=4.076494, reclaim high=2.188346 low=3.922446, high speedup=58.1%
memcg_async_reclaim: baseline high=11.556587 low=3.222517, reclaim high=2.325903 low=5.303031, high speedup=79.9%
memcg_async_reclaim: baseline high=14.481044 low=10.517298, reclaim high=2.309609 low=7.884620, high speedup=84.1%
memcg_async_reclaim: baseline high=9.737340 low=2.876915, reclaim high=1.815853 low=9.379357, high speedup=81.4%
memcg_async_reclaim: baseline high=16.290141 low=17.152739, reclaim high=1.649337 low=4.978743, high speedup=89.9%
memcg_async_reclaim: baseline high=5.176590 low=4.858071, reclaim high=2.356344 low=5.971522, high speedup=54.5%
memcg_async_reclaim: baseline high=12.444925 low=13.305078, reclaim high=1.973012 low=4.261413, high speedup=84.1%
memcg_async_reclaim: baseline high=16.213717 low=12.608334, reclaim high=2.207762 low=4.317123, high speedup=86.4%

Hui Zhu (2):
  mm/bpf: Add bpf_proactive_reclaim kfunc
  selftests/bpf: Add memcg async reclaim test

 mm/bpf_memcontrol.c                           |  61 +-
 mm/internal.h                                 |  10 +-
 .../bpf/prog_tests/memcg_async_reclaim.c      | 779 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 289 +++++++
 4 files changed, 1134 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

-- 
2.43.0

