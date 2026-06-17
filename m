Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB63AE6FB;
	Wed, 17 Jun 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678901; cv=none; b=QrsMek4l0S0rlREElr1jap2T4c3KhJ1h9Kg4d0zAH/avfcmE6L5U5ilP0PNuNHVx6nB0qnzyCDe3Ws9hjdQwPabNM4TnSE1CkqOvxKfA3vQqU3NsQczE0YasmCeyFdYaZ6WC0XRk2bklIQWnrrXbT0Y7iCn6QvfG66OBZZjqWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678901; c=relaxed/simple;
	bh=mxfJdKr4nXVKG7iuqYRdd2k/7ISp2J7jHFF8/ss5K+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fhP2g9ypHbEA+jbdF0moNMZjYshwM1qslFypxOSl7l2ZIcpPMxQ9ebhvxLrXGqhqaQ4F97hXQzpGikh0GMD+4ra5e2ujj8yVsO/xSoOwyvGBW4WBDYPtPEp1Tf7AleopUbtrSlGKs1uQLqPpV1pb2n7rvszha63jHiA9HelQaW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 820c01c86a1811f1aa26b74ffac11d73-20260617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0fb00710-322f-4beb-af24-cba2d821374e,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a1f20e6cda53d291a7503115ae9a1876,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
	|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 820c01c86a1811f1aa26b74ffac11d73-20260617
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 993940327; Wed, 17 Jun 2026 14:48:11 +0800
From: luoliang@kylinos.cn
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH] tools/sched_ext: scx_flatcg: Fix inverted vtime delta accounting
Date: Wed, 17 Jun 2026 14:48:05 +0800
Message-Id: <20260617064805.3901965-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

In try_pick_next_cgroup(), a cgroup is charged its full slice upfront.
fcg_dispatch() is then supposed to refund the unused time by adding
(expected_end - now) * FCG_HWEIGHT_ONE / hweight to cvtime_delta:

    __sync_fetch_and_add(&cgc->cvtime_delta,
                         (cpuc->cur_at + cgrp_slice_ns - now) *
                         FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));

However, if a cgroup yields early (expected_end > now), this adds a
positive value to cvtime_delta, which ultimately increases cvtime,
heavily penalizing the cgroup instead of refunding it.

Conversely, if a cgroup overuses its slice (now > expected_end), the
unsigned subtraction underflows to a massive u64. When multiplied by
FCG_HWEIGHT_ONE and divided by hweight via unsigned division, it
yields an enormous positive number. Adding this huge value to
cvtime_delta pushes the cgroup's virtual time roughly 3.25 days into
the future, permanently starving it.

cgrp_cap_budget() later applies cvtime_delta to cvtime reading it as
u64. Once dispatch can produce negative (refund) deltas, reading them
as u64 turns every refund into a huge positive value with the same
starving effect, so read and apply the delta as s64 and clamp the
result at zero.

Order the time delta as (now - expected_end) so overruns are positive
and early yields negative, and split the magnitude scaling by sign
since BPF has no signed division.

Observed on a nested cgroup hierarchy under mixed CPU load: cvtime
grew roughly 300x faster than wall-clock time, cvtime_delta reached
2^47..2^49, and tasks in cgroups stalled. After the change cvtime
advances at the expected weight-scaled rate and no anomalous deltas
appear.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 37 ++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fec359581826..a37f5b876da8 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -249,15 +249,26 @@ static void cgrp_refresh_hweight(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
 
 static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
 {
-	u64 delta, cvtime, max_budget;
+	s64 delta;
+	u64 cvtime, max_budget;
 
 	/*
 	 * A node which is on the rbtree can't be pointed to from elsewhere yet
 	 * and thus can't be updated and repositioned. Instead, we collect the
 	 * vtime deltas separately and apply it asynchronously here.
 	 */
-	delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
-	cvtime = cgv_node->cvtime + delta;
+	delta = (s64)__sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
+	/*
+	 * cvtime_delta may be negative (early-yield refund from fcg_dispatch()).
+	 * Apply it in the signed domain and clamp the resulting cvtime at zero
+	 * so that a refund larger than the accumulated cvtime doesn't roll the
+	 * field negative.
+	 */
+	s64 vtime = (s64)cgv_node->cvtime + delta;
+
+	if (vtime < 0)
+		vtime = 0;
+	cvtime = (u64)vtime;
 
 	/*
 	 * Allow a cgroup to carry the maximum budget proportional to its
@@ -767,11 +778,25 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
 		 * We want to update the vtime delta and then look for the next
 		 * cgroup to execute but the latter needs to be done in a loop
 		 * and we can't keep the lock held. Oh well...
+		 *
+		 * Charge the overrun or refund the unused time. The original
+		 * (cur_at + slice - now) was inverted: early yields were
+		 * penalized and overruns underflowed. Use (now - (cur_at +
+		 * slice)) so overruns are positive and early yields negative;
+		 * split the magnitude scaling by sign since BPF has no signed
+		 * division.
 		 */
 		bpf_spin_lock(&cgv_tree_lock);
-		__sync_fetch_and_add(&cgc->cvtime_delta,
-				     (cpuc->cur_at + cgrp_slice_ns - now) *
-				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
+		s64 excess = (s64)now - (s64)(cpuc->cur_at + cgrp_slice_ns);
+		s64 delta;
+
+		if (excess > 0)
+			delta = (s64)((u64)excess * FCG_HWEIGHT_ONE /
+				      (cgc->hweight ?: 1));
+		else
+			delta = -(s64)((u64)-excess * FCG_HWEIGHT_ONE /
+				       (cgc->hweight ?: 1));
+		__sync_fetch_and_add(&cgc->cvtime_delta, delta);
 		bpf_spin_unlock(&cgv_tree_lock);
 	} else {
 		stat_inc(FCG_STAT_CNS_GONE);
-- 
2.43.0

