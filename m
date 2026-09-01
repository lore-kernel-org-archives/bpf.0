Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AD21D9A5F
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266666; cv=none; b=Y+BJa3MjrWGHP32wCzwQO49ZayzCqFVnLX47Lqsw9fFn80Uxjwb10TNaVbo1iLYeUyPY6oou1c9iUj/MlO4/LAVu9xv5Ogt27W5VVnVbUcjKAEXTIGH1IZGJ3OTJsd/VQ5tqpa6O3x/L+Htz1Z//qkU/mGdvAEwoHVLOEhjdocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266666; c=relaxed/simple;
	bh=4xYToF5MA/xkEqr/sq1dy954cS2PfO//LD1OfNLVaM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwogOOnMJ79lITJZcNjH+w7pj42mvQ3DB71r7zWwIcvBhOWvIjoQzkHbjKdsamCYZxSiKyp9jcW6COYiDaIBmyReCuIjlLBvv/0mPmvBStYU2BzgZCRiwcKE9gXoX65THDZEFtGcMBKAwluFIKxEdpbujwShDdUmBWy4IfME7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qVJsP0FQ; arc=none smtp.client-ip=95.215.58.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVJsP0FQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4xYToF5MA/xkEqr/sq1dy954cS2PfO//LD1OfNLVaM0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788266662; v=1; x=1788871462;
 b=qVJsP0FQsZ3/CX8gVuA6NowMPsoz17VdmS5lsCIxH3q8zr8ue3QvuKfucP3EiTzlQIlmkgOR
 Mcwtcf2yE8oxpmbCkHOcrklAr5QiQMah1z+K6bD/GlN/YX15kMvvz5GaxJCahMktO0l1qyEZP8W
 f66s/XijNwkiZmG3RitXzOJE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 69d6713c70f1300e;
	Tue, 01 Sep 2026 12:44:21 +0000
X-Mizu-Trace-ID: 69d6713c70f1300e
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	arighi@nvidia.com
Cc: void@manifault.com,
	changwoo@igalia.com,
	michalblk@google.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2] sched_ext: don't deliver duplicate ops.cgroup_set_idle() for same value
Date: Tue,  1 Sep 2026 20:43:47 +0800
Message-ID: <20260901124347.755904-1-cui.tao@linux.dev>
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
Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.dev
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
v1 -> v2: Fix the Link: msgid (missing @linux.dev, Andrea).

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

