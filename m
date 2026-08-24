Received: from mta0.migadu.com (out-167.mta0.migadu.com [91.218.175.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1E34B66F
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578834; cv=none; b=MBsV8eHosoq2Pn1Sk8qrO4bzTBH6BM0FGrxVolhiVC1XL+/gZG5c4HQ4d64eZ2U1qxCtIMNo4hXnvI6FYLRzuVNxk6KwcS+sHplZlwLOGiKURD8UpEjAokK5XMBH+MDkOcKZaZw1h0sw7sFkyaI6imOCoCnM1CWohQwOYdMddjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578834; c=relaxed/simple;
	bh=3edNKJO7hDiLr+6N33bx+1GdVJff9by9zddu2YSlVF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/HojjNwlJfzNaAUNJLdkSbTwdXVhVodQziMCngdInYFVhd+ssICnBP3Sjie90cstKMGyy//wRaoWNdUhEmRXmyj4AkeUKaLXoEyM+hGtHKemu6KRVQo+GZh58zWNWL71GGTTfSUwIGpkpoL7Qg/Nu8rEud1pEN9fmdmXZK8SMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xQuc6FhW; arc=none smtp.client-ip=91.218.175.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xQuc6FhW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3edNKJO7hDiLr+6N33bx+1GdVJff9by9zddu2YSlVF4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787578824; v=1; x=1788183624;
 b=xQuc6FhW/z6Z9uSvkP6+PZczfWmDZv5iDy9KtfrZGlwSZpgD0pEm04Mi6Z+wW5FBfIzEdXtn
 iNn3I3xtemI+HQyDrU9WYG6NtHk8F8Aq+y9QvZz1CmtUvlv8XcIJdw+e6tGIqTAGhgW42eJVD6H
 Gfp1wSNTjAu4WiQLh5lC0PDU=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id c8db36bdc943f2b5;
	Mon, 24 Aug 2026 13:40:03 +0000
X-Mizu-Trace-ID: c8db36bdc943f2b5
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
Subject: [PATCH] sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
Date: Mon, 24 Aug 2026 21:39:54 +0800
Message-ID: <20260824133954.561956-1-cui.tao@linux.dev>
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

Add the idle state to scx_cgroup_init_args and fill it in both places
that build the args -- scx_tg_online() for cgroups created under the
scheduler and scx_cgroup_init() for cgroups that already exist when
the scheduler is loaded.

Verified in a VM with a probe scheduler printing the init args: a
cgroup configured cpu.idle=1 before loading shows idle=1 in
ops.cgroup_init(), the default shows 0, and later cpu.idle writes
still come through ops.cgroup_set_idle().

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 4 +++-
 kernel/sched/ext/internal.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
-- 
2.43.0

