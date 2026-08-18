Received: from mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C883890E4
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042212; cv=none; b=F1Lt7DMxRppRgnrKlRnyi/ckwhFuVmRg9UpllXOWsIbUvTTVjJwcoimXigQ2f/zhivu+1OgiShlodLEdE6lgP+Qa8PLnz5SxWFBE3DZ4fmf2lJEksT/jGhKkvkbQPl3q+ref3a7FbKQ5GIRDmBEIDi2Mh7gCsYjuRcuiJswpOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042212; c=relaxed/simple;
	bh=HPHzCQscpPNT0QBxW0BqZAv2GHNpNMRHwv8jkG96UoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPCI4/VZZyGbhoQu7i3vas2ibVRsS7uJUWjrah4k9tGmEbXyJ2kaS7i8OUmXHQ9LOK/A729ubmQg0pfX1Ulsn76Gj/R3n1vjdVp6hnk6awtVqON/sDDMYznkFxK47hhg+eUbc2G0pGJpJak8/bKMS1TXqDHXvivndAQGgVRYEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sLQI6aE0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sLQI6aE0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HPHzCQscpPNT0QBxW0BqZAv2GHNpNMRHwv8jkG96UoA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787042206; v=1; x=1787647006;
 b=sLQI6aE0piWRIxqdVw8jynybjee27SP7FE2q2qTk6MTY749kqOL6QnImNyjitay3GG9AcwAq
 /xavDA5xLHYrYgIGqH1UxvHFVWF5HZvBOvKRnrq2GEcqZGs89ptOK7a6+X5Z1CjAkWu25QGSBhw
 t94ICyRcj867NNSzJW6LFs9Y=
X-Envelope-To: bpf@vger.kernel.org
Received: from teawater-KVM-Virtual-Machine (39.156.73.13)
	by smtp.migadu.com with ESMTPS id b78de815968a6bde;
	Tue, 18 Aug 2026 08:36:36 +0000
X-Migadu-Flow: FLOW_OUT
From: "Hui Zhu" <hui.zhu@linux.dev>
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
Subject: [PATCH bpf-next v2 0/2] bpf: BPF-driven proactive memcg reclaim
Date: Tue, 18 Aug 2026 16:36:08 +0800
Message-ID: <cover.1787040082.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hui Zhu <zhuhui@kylinos.cn>

This series lets a BPF program decide when to trigger memcg reclaim
and how aggressively to do it, based on whatever runtime signal it
chooses to observe -- rather than reclaim only being triggered once a
cgroup's usage crosses a fixed threshold. The core idea is a pair of
new kfuncs, bpf_proactive_reclaim() and
bpf_proactive_reclaim_swappiness(), which give BPF direct access to
the proactive reclaim path so this decision can be made in BPF policy
rather than hard-coded threshold logic.

This was originally part of a larger series posted here [1].
That series also adds a memcg BPF struct_ops (memcg_charged,
memcg_uncharged, below_low, below_min) for synchronous, in-line memory
protection decisions. That mechanism and this one solve different
problems -- struct_ops hooks run inline on the charge/reclaim path,
while the kfuncs here are for asynchronous, out-of-band reclaim
decided independently by a BPF program -- so they are reviewed as
separate series. This series carries only the async reclaim piece.

Compared to v1, the kfunc interface has been reworked based on review
feedback: instead of a thin wrapper around
try_to_free_mem_cgroup_pages() exposing raw gfp/reclaim-option knobs,
the series now provides use-case-driven kfuncs that perform one
proactive reclaim pass with the same parameters memory.reclaim uses.
The bpf_thread_wq patches from v1 (old patches 2-3) are dropped from
this series: following the discussion in [2], the cgroup-aware
workqueue is being superseded by a disaggregated set of async
primitives (bpf_kthread/bpf_waitq) that will be developed separately
(discussion in [3]), and the selftest now queues its reclaim work
through bpf_wq.

Patch 1 adds bpf_proactive_reclaim() and
bpf_proactive_reclaim_swappiness(), sleepable kfuncs that perform one
reclaim pass on a target memcg, like a write to memory.reclaim: swap
is allowed, and the anon/file balance follows the cgroup's swappiness
or an explicit override in [MIN_SWAPPINESS, MAX_SWAPPINESS] plus
SWAPPINESS_ANON_ONLY. Both delegate to try_to_free_mem_cgroup_pages()
with GFP_KERNEL and MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE,
the same parameters user_proactive_reclaim() uses, and unlike
memory.reclaim they do not retry until the requested size is reached.
Both refuse to run when the caller already holds PF_MEMALLOC, since a
nested try_to_free_mem_cgroup_pages() would clobber the outer
reclaim's current->reclaim_state (e.g. MGLRU dereferences
current->reclaim_state->mm_walk).

Patch 2 (selftests/bpf: add memcg async reclaim test) ties the kfuncs
into a worked example: it watches the WORKINGSET_REFAULT_FILE counter
of a high-priority cgroup as a proxy for memory-pressure impact, and
once it starts climbing, proactively reclaims pages from a
low-priority cgroup via bpf_proactive_reclaim(), with the reclaim
work queued asynchronously through bpf_wq. The test asserts that the
monitored cgroup's workload finishes faster once async reclaim kicks
in. This demonstrates the end-to-end use case: BPF observes pressure
on the cgroup it wants to protect, and reclaims from the cgroup it
wants to reclaim from, in one self-contained mechanism. Note that,
without bpf_thread_wq, the CPU cost of the reclaim work is not yet
attributed to a chosen cgroup; that part waits for the async
primitives work mentioned above.

Changelog:
v2:
According to the comments of Shakeel Butt, replace
bpf_try_to_free_mem_cgroup_pages() with
bpf_proactive_reclaim(memcg, size) and
bpf_proactive_reclaim_swappiness(memcg, size, swappiness).
According to the comments of Kumar Kartikeya Dwivedi, drop patch 2
and patch 3.
Remove bpf_thread_wq code in patch 4.
According to the comments of sashiko-bot, fix the issues of selftests.

[1] https://sashiko.dev/#/message/cover.1779760876.git.zhuhui%40kylinos.cn
[2] https://sashiko.dev/#/message/1b58d56976202f26818d31dbd0da2ecb2e2460f5%40linux.dev
[3] https://sashiko.dev/#/message/DKNHV09PBQZP.IRQL20BY574I%40gmail.com

Hui Zhu (2):
  mm/bpf: Add bpf_proactive_reclaim kfuncs
  selftests/bpf: add memcg async reclaim test

 mm/bpf_memcontrol.c                           |  95 +++++
 .../bpf/prog_tests/memcg_async_reclaim.c      | 382 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 167 ++++++++
 3 files changed, 644 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

-- 
2.53.0

