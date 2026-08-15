Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3B2D8DDB
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786769972; cv=none; b=KFJmAE1DOUrH8VdEBRfIdDtYEMLc175g1dFSHGI1K16LtM4Hrr80EMn2GoEg5sA/WWvnqUNtLj1l4LQ2xl4hMLvi6NPnB/CiR2UUxk4czUkOTeVtp/6e7Ope5+WBcoGcApnvFyM8TezrsscIpSGaRRtDashFcewqcIO9by9ZBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786769972; c=relaxed/simple;
	bh=CUH7eeS0i72t70xUBn3D8+EnObUyxPUfKS3cVqvrP8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyHSwD5cU/7gI4/ylW5PHiLbhicDeXVqRGFHhGIq2oYg8zKLWRvbuh6bh55ItSSyMujB1aOPPUR/zbBb62lutlslw6hlhQJo26jInMum6NkNIBMvk+Xfls9xauUEgHL5pUNELV3dwtubPsoXJx/rii+FJDf1T4fsvLv09DwCl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aGcZwbmC; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aGcZwbmC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CUH7eeS0i72t70xUBn3D8+EnObUyxPUfKS3cVqvrP8o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786769967; v=1; x=1787374767;
 b=aGcZwbmC8l7Rr+apoCRo7le4ctoq272LPJZ85zvPcBsFXAO1C3Gk2O6veDG1GQxcOygsOJCR
 OoYmqgdJfaGV5JX8OuCrFOjcFAA1kJsaPgvujVD3iDwwaZFGXhNK+2O1Z7Ex4cJCjBQj0WBv/PA
 QAWGcaZomuyXUytgPQsV+0xU=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id ac24d4f30141b71b;
	Sat, 15 Aug 2026 04:59:17 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext/scx_flatcg: Fix cvtime true-up on slice expiry
Date: Sat, 15 Aug 2026 12:59:05 +0800
Message-ID: <20260815045905.3431991-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

fcg_dispatch() true-ups the current cgroup's cvtime when its slice
expires or its DSQ runs empty while the slice is still active:

	__sync_fetch_and_add(&cgc->cvtime_delta,
			     (cpuc->cur_at + cgrp_slice_ns - now) *
			     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));

The true-up should be actual minus charged: on CNS_EXPIRE, the overrun
(now - cur_at - cgrp_slice_ns) should be added; on CNS_EMPTY, the
unused portion of the slice should be subtracted. The expression above
has the sign inverted, and in the CNS_EXPIRE case now is already past
cur_at + cgrp_slice_ns, so the u64 subtraction wraps. The
multiplication preserves the two's complement encoding but the
unsigned division by hweight destroys it, adding roughly 2^64/hweight
per expiry instead of a small correction.

Under saturation the hweight budget clamp in cgrp_cap_budget() masks
most of the garbage, so the weight distribution barely moves, but the
accounting is broken all the same. Compute the delta as a signed value
and use fetch_and_add()/fetch_and_sub() so that the dividends stay
positive, as BPF division is unsigned.

Instrumented the true-up and ran a saturated three-leaf cgroup tree on
a 4-CPU VM: without the fix, each expiry added ~5e15 (2^64/hweight
territory) to cvtime_delta; with it, the corrections are back to
slice scale, with the overrun added and the unused portion subtracted.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 0fd214cc61da..ddcf6bc03b11 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -769,10 +769,18 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 		 * cgroup to execute but the latter needs to be done in a loop
 		 * and we can't keep the lock held. Oh well...
 		 */
+		s64 delta = now - cpuc->cur_at - cgrp_slice_ns;
+
 		bpf_spin_lock(&cgv_tree_lock);
-		__sync_fetch_and_add(&cgc->cvtime_delta,
-				     (cpuc->cur_at + cgrp_slice_ns - now) *
-				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
+		/* keep the dividends positive, BPF division is unsigned */
+		if (delta >= 0)
+			__sync_fetch_and_add(&cgc->cvtime_delta,
+					     (u64)delta * FCG_HWEIGHT_ONE /
+					     (cgc->hweight ?: 1));
+		else
+			__sync_fetch_and_sub(&cgc->cvtime_delta,
+					     (u64)-delta * FCG_HWEIGHT_ONE /
+					     (cgc->hweight ?: 1));
 		bpf_spin_unlock(&cgv_tree_lock);
 	} else {
 		stat_inc(FCG_STAT_CNS_GONE);
-- 
2.43.0

