Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82A3932E9;
	Wed, 17 Jun 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687043; cv=none; b=F82vDmr2s91CzPC/F1BaBtXCqiKxMMq5mr1rhQXfd5DTFgJ2Y91C5uegCR7os5XdxagJGybxowKRjIKKHB/MRoh86DvkfSSESxRp0GwqzAZsMgbywb/ZeHiokaU6vdJJngcQuG5yyHCSdnCz6Y7zkxbJx1X6xQZsOkhi1y8HHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687043; c=relaxed/simple;
	bh=TrHQR7CE2CcXziOmuzbvfUnuinXw75t6TS6zVktdsJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5epu+piveSrcxEJrteUQq3MDLajc4LjLG144GxG3mdpTmpRARLtHN7C2Ueu9N3NfldOjJW4TL63hZmhaodd7UD8JsDV7w3rxRuuq9fsx+ktvouil1iO2qVDg1q13Vu/YFcA1nC3nUU7GaLkTmzPCZXhE9rYd7+RahTZ/mNahC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 76aab0646a2b11f1aa26b74ffac11d73-20260617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:891bfb16-c3f1-4ec8-aabf-0a516f0ed92b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:f1420e3bb047c7c946a71bc1c890f315,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|136|850|865|898,TC:nil,Con
	tent:0|15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76aab0646a2b11f1aa26b74ffac11d73-20260617
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 121751747; Wed, 17 Jun 2026 17:03:53 +0800
From: luoliang@kylinos.cn
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: [PATCH v2] tools/sched_ext: scx_flatcg: Fix inverted vtime delta accounting
Date: Wed, 17 Jun 2026 17:03:48 +0800
Message-Id: <20260617090348.4131187-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617064805.3901965-1-luoliang@kylinos.cn>
References: <20260617064805.3901965-1-luoliang@kylinos.cn>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Liang Luo <luoliang@kylinos.cn>
---
Changes in v2:
  - Use the standard kernel time-comparison idiom for the delta
    computation in fcg_dispatch() (Andrea Righi).
  - Add Andrea's Reviewed-by tag.

 tools/sched_ext/scx_flatcg.bpf.c | 38 +++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index fec359581826..6aa0c62b76d2 100644
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
@@ -767,11 +778,26 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
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
+		u64 expected_end = cpuc->cur_at + cgrp_slice_ns;
+		s64 excess = (s64)(now - expected_end);
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

