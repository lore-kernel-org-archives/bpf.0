Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C2425879
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232277; cv=none; b=JohAZg9ndgvw8H1JjiEGG6kDQONGVZoWDqfcvAgaHiXqTB9xtwuinhpvpSkxuTr5xMtbqPv58SFkFLb1XtrIGKv5MySUXuaKo2QeBwKUU8fvl1TgpMXd0BIGPoO/N8OL80E2f62GSsWV6mHBwK2XdIel2PEJe+uQ1OvVM+ue/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232277; c=relaxed/simple;
	bh=s5oPWfvcaE1YMaxXsFJOTvk9No3nN8NYNIrkpi80+cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ArsutGBwXsEGsPvGmd+yDs6HJE2PEr/wRzaa6OGnOgnZvROob5dYuNLmGk9QYW60E+5Orua6WRXj7YTfGdpMdGLtMEaltAmyOmgf5ClztKkb4Z2zPOEsl774D9DXj54/cxiA/VwoQTJb7xULXIXSUaKoHbcGL4MNLCR09u5eJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZs+7PTd; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZs+7PTd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=s5oPWfvcaE1YMaxXsFJOTvk9No3nN8NYNIrkpi80+cM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788232273; v=1; x=1788837073;
 b=GZs+7PTdJi7pNFnigosE7k6tUUzUolpPtnCzVO184D83S/B4IUwY/zFpw0OsIzslmNXC+Lf6
 pKLj64RdBd+5imouiLK1eKZlPb9q4aSDetjNYXKZKwk15gVuWaFVGwLiEIzTwg/rHX93d4aKYfW
 RnQ4bEOXRrUpDpuiIWhpaMLM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b250c1526b7c3aa9;
	Tue, 01 Sep 2026 03:11:13 +0000
X-Mizu-Trace-ID: b250c1526b7c3aa9
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: don't deliver duplicate ops.cgroup_set_idle() for same value
Date: Tue,  1 Sep 2026 11:11:01 +0800
Message-ID: <20260901031101.731943-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

ops.cgroup_set_idle() is documented to be invoked when a cgroup
transitions between idle and non-idle states, and scx_group_set_weight()
already skips value-preserving writes. scx_group_set_idle() delivers
every write unconditionally, so rewriting an already-correct cpu.idle
value feeds the BPF scheduler a transition callback each time, which
toggle- or accounting-based schedulers miscount. Mirror the weight
guard and only deliver on an actual change.

Verified with a probe scheduler printing each callback: rewriting
cpu.idle=1 twice on an already-idle cgroup delivered two callbacks
before and none after.

Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 8041c87a3562..8b3625107b72 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4933,7 +4933,8 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
 	percpu_down_read(&scx_cgroup_ops_rwsem);
 	sch = scx_tg_knob_sched(tg);
 
-	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
+	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
+	    tg->scx.sched_idle != idle)
 		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
 
 	/* Update the task group's idle state */
-- 
2.43.0

