Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAF327603F;
	Wed, 12 Aug 2026 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515096; cv=none; b=sQwJIZGVHWN83oDVZAlVL4bxBA2faiGPek6/in5tzN1tW91aq05Bl63G1YEYV+6AgmfKQ+vFRZQPJOadUgOxOQLDffEywLgDep4P1Jat+IMVzDMoxLPx2FUXjO+zs9dX0JzUbJI15jdvXsejXPJlbFXnTRtQzCqG2JDUohx2h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515096; c=relaxed/simple;
	bh=bVq5fn8Pgvq29u10W+ZmmqdI2VXod7THLvIJ8ciJYSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZeaDROy5pDP92/ecbB1REVMIn4zFf+fbHPhHYaSwR4Pt/ovoW85/zdZoahHVxBbaH5Ez+jqS+mNQF3b0/g07P9ZePCz4hi/bsaB5uUlf0leoUucdpnV3wWCByCsh26KF6yqLo5ClXX9feZv5D18Q8CGTP28QxyJ1KF/mVR0uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a860608a961411f1aa26b74ffac11d73-20260812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:53642249-9248-48a9-acce-cfe0ddf9c193,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-45
X-CID-META: VersionHash:e7bac3a,CLOUDID:fead38b70cf8c30bc96a2de978754f45,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a860608a961411f1aa26b74ffac11d73-20260812
X-User: fangqiurong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fangqiurong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 305795612; Wed, 12 Aug 2026 14:11:29 +0800
From: Qiurong Fang <fangqiurong@kylinos.cn>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	fangqiurong <fangqiurong@kylinos.cn>
Subject: [PATCH] sched_ext: Gate cid kfuncs behind the SCX struct_ops check
Date: Wed, 12 Aug 2026 14:11:16 +0800
Message-Id: <20260812061116.2691443-1-fangqiurong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fangqiurong <fangqiurong@kylinos.cn>

scx_bpf_cid_to_cpu(), scx_bpf_cpu_to_cid() and scx_bpf_cid_topo() live in
the scx_kfunc_ids_cid set, but scx_kfunc_context_filter() doesn't check
that set. The filter's first test treats any kfunc outside its known sets
as non-SCX and allows it, so these three kfuncs can be called from any
struct_ops program - e.g. a TCP congestion control program.

Add scx_kfunc_ids_cid to the filter's known sets, matching how in_any and
in_idle are handled.

Fixes: e9b55af47edf ("sched_ext: Add topological CPU IDs (cids)")
Assisted-by: Z.ai:glm-5.2
Signed-off-by: fangqiurong <fangqiurong@kylinos.cn>
---
 kernel/sched/ext/cid.h | 1 +
 kernel/sched/ext/ext.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/cid.h b/kernel/sched/ext/cid.h
index 1f74d1f331f5..2fe2311a0f99 100644
--- a/kernel/sched/ext/cid.h
+++ b/kernel/sched/ext/cid.h
@@ -67,6 +67,7 @@ extern s32 __rcu *scx_shard_node;
 extern struct scx_cid_shard __rcu *scx_cid_shard_ranges;
 extern struct scx_cid_topo __rcu *scx_cid_topo;
 extern struct btf_id_set8 scx_kfunc_ids_init_cids;
+extern struct btf_id_set8 scx_kfunc_ids_cid;
 
 void scx_cmask_clear(struct scx_cmask *m);
 void scx_cmask_fill(struct scx_cmask *m);
diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f9631e66a9fc..317eb0110c64 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -10762,19 +10762,20 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
 	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
 	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
+	bool in_cid = btf_id_set8_contains(&scx_kfunc_ids_cid, kfunc_id);
 	u32 moff, flags;
 
 	/* Not an SCX kfunc - allow. */
 	if (!(in_unlocked || in_init_cids || in_select_cpu || in_enqueue || in_dispatch ||
-	      in_cpu_release || in_idle || in_any))
+	      in_cpu_release || in_idle || in_any || in_cid))
 		return 0;
 
 	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
 	if (prog->type == BPF_PROG_TYPE_SYSCALL)
-		return (in_unlocked || in_select_cpu || in_idle || in_any) ? 0 : -EACCES;
+		return (in_unlocked || in_select_cpu || in_idle || in_any || in_cid) ? 0 : -EACCES;
 
 	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
-		return (in_any || in_idle) ? 0 : -EACCES;
+		return (in_any || in_idle || in_cid) ? 0 : -EACCES;
 
 	/*
 	 * add_subprog_and_kfunc() collects all kfunc calls, including dead code
@@ -10809,7 +10810,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
 		return -EACCES;
 
 	/* SCX struct_ops: check the per-op allow list. */
-	if (in_any || in_idle)
+	if (in_any || in_idle || in_cid)
 		return 0;
 
 	moff = prog->aux->attach_st_ops_member_off;
-- 
2.43.0

