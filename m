Received: from mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834F4399D5
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581714; cv=none; b=XiN8T3r0RwjS2Im1fvot+7tLNTNbZdA9ba4iAOlirpuXQsBwmCS/Kh1sA1iAT6veLcv8Rl2mouS8qZGFnOEdlETKZK9fEqbFn0iQJvLg5ix4/HXzRLOJ5Cq8FnHzOYxhhTz1iV0FcLNgeqkb37ACwulvO+x3bkjr/QARxN3EXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581714; c=relaxed/simple;
	bh=Gtw+u7xc8n5mWxXketVqTcpiCYuUBRGGZLwfNTG/LBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ph9TZQpaXHUzdkevNUXr6y8O54fUhdxezbw+5Z13nbcv2HQnihwCEBU/eIiAq62kloEBtCNXPFpiu2wdfS0DA0nsLqN2V6zehlayMhNOIoPzLppRWxUzP2HytGaf8C8dvScTLtV2D+M4s+k0FSUR7hn5WkckxsiSN4i4EPhCZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BeyJVGba; arc=none smtp.client-ip=95.215.58.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BeyJVGba"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gtw+u7xc8n5mWxXketVqTcpiCYuUBRGGZLwfNTG/LBY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787581709; v=1; x=1788186509;
 b=BeyJVGbas0TJK6Ycu6DLTB/r+RQVSTCYrmYtQegFpEqW5T7LPi3sF1AcDjIrp5Fi+GMLrEw2
 ATd3m9v1xd1XDHuxa6/w7XitWHlvcK5XQA63G48lCSpHm1kFRgrWAGhi2lyrviavHtpOCgL1zrR
 Rp2FLUWqWI807uyhVMHdS2E0=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (223.70.160.239)
	by smtp.migadu.com with ESMTPS id 4b083152c76dfaa4;
	Mon, 24 Aug 2026 14:28:29 +0000
X-Mizu-Trace-ID: 4b083152c76dfaa4
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: changwoo@igalia.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
Date: Mon, 24 Aug 2026 22:28:16 +0800
Message-ID: <20260824142817.568085-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

scx_cgroup_init_args carries the initial weight and bandwidth control
parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
state. A cgroup that was already configured idle before the scheduler
was loaded (or before it was onlined under it) is presented as
non-idle, and the BPF scheduler only learns about it if cpu.idle is
written again later.

Add the idle state to scx_cgroup_init_args and fill it in all four
places that build the args: scx_tg_online() for cgroups onlined under
the scheduler, scx_cgroup_init() for cgroups that already exist when
the scheduler is loaded, and the sub-scheduler handover paths
scx_cgroup_claim_subtree() and scx_cgroup_return_subtree().

Verified in a VM with a probe scheduler printing the init args: a
cgroup configured cpu.idle=1 before loading shows idle=1 in
ops.cgroup_init(), the default shows 0, and later cpu.idle writes
still come through ops.cgroup_set_idle(). The sub-scheduler paths
are compile-tested only.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
v1 -> v2: Also fill .idle in the sub-scheduler handover paths in
sub.c, scx_cgroup_claim_subtree() and scx_cgroup_return_subtree(),
missed in v1 and pointed out by Andrea Righi and the sashiko AI
review bot.

v1: https://lore.kernel.org/r/20260824133954.561956-1-cui.tao@linux.dev

 kernel/sched/ext/ext.c      | 4 +++-
 kernel/sched/ext/internal.h | 3 +++
 kernel/sched/ext/sub.c      | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b646711a45fe..a7218314dcfb 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4764,7 +4764,8 @@ int scx_tg_online(struct task_group *tg)
 				{ .weight = tg->scx.weight,
 				  .bw_period_us = tg->scx.bw_period_us,
 				  .bw_quota_us = tg->scx.bw_quota_us,
-				  .bw_burst_us = tg->scx.bw_burst_us };
+				  .bw_burst_us = tg->scx.bw_burst_us,
+				  .idle = tg->scx.idle };
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init,
 					      NULL, tg->css.cgroup, &args);
@@ -5185,6 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
 				.bw_period_us = tg->scx.bw_period_us,
 				.bw_quota_us = tg->scx.bw_quota_us,
 				.bw_burst_us = tg->scx.bw_burst_us,
+				.idle = tg->scx.idle,
 			};
 
 			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 53e136a47924..aa149a9c29f7 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
 	u64			bw_period_us;
 	u64			bw_quota_us;
 	u64			bw_burst_us;
+
+	/* whether the cgroup is configured idle via cpu.idle */
+	bool			idle;
 };
 
 enum scx_cpu_preempt_reason {
diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
index 0554448835bd..9701bd1d8ea0 100644
--- a/kernel/sched/ext/sub.c
+++ b/kernel/sched/ext/sub.c
@@ -1361,6 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
+			.idle = tg->scx.idle,
 		};
 
 		if (tg->scx.sched != parent ||
@@ -1464,6 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
 			.bw_period_us = tg->scx.bw_period_us,
 			.bw_quota_us = tg->scx.bw_quota_us,
 			.bw_burst_us = tg->scx.bw_burst_us,
+			.idle = tg->scx.idle,
 		};
 
 		/* the first pass must have transferred everything */
-- 
2.43.0

