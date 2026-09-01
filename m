Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570E02367DF
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229306; cv=none; b=H42BgzCvY8lygrRgSZ2EuFzmG+8j68d/g8Oc3F3QrlTPr85jQ2qKy2BVgSMzlHsTwKHrLq9GZcS/tsclTBuXK9mPSy4GpEy6hoBUeX1bZ0q47wiAsO8qnFBs15klGmYn4BHf04m7T02UIHkJFc6Pa9xPJBPDo6MS/Fzc5bq8vv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229306; c=relaxed/simple;
	bh=7uPbtr2WBHUVzXJjAHM0J1bBu+jQncq3WQCDdhThYVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcLficybyfouBBMfVfd1UXUYw9NQ+ToB8kBQEGqEc9KG0YzB2veqqfmo9u3b2JQA4B1FzUzYzI8kWqN8LztoCdWE+qgw7v/zTrzFUcsCkt3AIZ8ahEQ87/YkiUPaFDqJ48xWKLI3CtZ6QXuj25JXX3oq8bcrTy54dsWCIyL4uyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1TnX+9E; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1TnX+9E"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7uPbtr2WBHUVzXJjAHM0J1bBu+jQncq3WQCDdhThYVo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788229302; v=1; x=1788834102;
 b=P1TnX+9EVvR12ORR43x+qcpOqYUD2nmqnr+KjWeoHBK/Mfg7V+sWin6bWVuQ3tJIYWtw7Mrs
 Iet6e771XlBGhAMmiaOg27rkns1urEIW5Ye40wQKUk0kcmPm/pETH0Yb9RR0Ai4RLx5PXplKKyw
 mxGi38v1cVcQe+0VTCt/Xsy8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2e88f73ed0aea6f1;
	Tue, 01 Sep 2026 02:21:42 +0000
X-Mizu-Trace-ID: 2e88f73ed0aea6f1
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
Subject: [PATCH bpf-next v6 0/2] bpf: BPF-driven proactive memcg reclaim
Date: Tue,  1 Sep 2026 10:21:09 +0800
Message-ID: <cover.1788228773.git.zhuhui@kylinos.cn>
X-Mailer: git-send-email 2.53.0
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

Hui Zhu (2):
  mm/bpf: Add bpf_proactive_reclaim kfunc
  selftests/bpf: Add memcg async reclaim test

 mm/bpf_memcontrol.c                           |  76 ++-
 .../bpf/prog_tests/memcg_async_reclaim.c      | 480 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 181 +++++++
 3 files changed, 735 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

-- 
2.53.0

