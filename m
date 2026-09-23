Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC22474258
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199295; cv=none; b=tkFz0dmAdZIzwL1Ap8x2vhF2z0dubSapldKr8WvSIDzc0wrSbJPo1nOhaAdpO0CtRUOTP8K31Q2yHeY7O58ET1cf0r/+QSaKSnAXtdguBjPAvw9ZUKCH8X+Ygabr8Fa459ztT2q98t+CAg2s3l2CMAhmW2eicUV3jYRX3qhghmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199295; c=relaxed/simple;
	bh=rb7CP4UYtgy+IXS6D08jHYPv/a6qcfU7VomdBfispcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI2E0SwL0bQ6dOHV38ZZ86dyVdiuKcmBx/v/VVY4QLHQXuIAIpuOU3Te4e/x9TVuXoUWd8jWHadvSZc/G0kMdNgluwHTira/PaB/bUyMjl2Z6s/g8kekSXn0N++765bbzpYmuzQfdA1SJnTbxTuDl79PWDFjhIvj8a8YPPbLoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HnL2tipy; arc=none smtp.client-ip=95.215.58.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HnL2tipy"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rb7CP4UYtgy+IXS6D08jHYPv/a6qcfU7VomdBfispcs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790199291; v=1; x=1790804091;
 b=HnL2tipyUvMaJvc9BPXNfOHSVSlrZuK6eVs5YSLMdcNDJuoy/K9zZE1KskFjPIsAyleFlTik
 6dTHonyzloOLQa1xESvu9Ox2t0i9tKvNVTzEjn9EJXocIn9JYDnhGerPN5KUR0eVs/sPDxn33Q1
 FznAACwMWKTZDz2PD2E0S7eU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8768a77adbd16e00;
	Wed, 23 Sep 2026 21:34:51 +0000
X-Mizu-Trace-ID: 8768a77adbd16e00
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: arighi@nvidia.com,
	bpf@vger.kernel.org,
	bsegall@google.com,
	changwoo@igalia.com,
	dietmar.eggemann@arm.com,
	etsal@meta.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	vincent.guittot@linaro.org,
	void@manifault.com,
	vschneid@redhat.com,
	yphbchou0911@gmail.com
Cc: Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] sched_ext: Avoid relocking DSQ during remote DSQ moves
Date: Wed, 23 Sep 2026 14:34:44 -0700
Message-ID: <20260923213444.3231509-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When scx_bpf_dsq_move*() moves a task from a non-local DSQ to a
remote local DSQ, move_task_between_dsqs() drops src_dsq->lock while
leaving p->scx.dsq set. The following deactivate_task() then reacquires
src_dsq->lock in scx_dispatch_dequeue() to unlink the task and clear
p->scx.dsq.

Both the source rq and src_dsq are already locked before the source DSQ
lock is dropped. Call dispatch_dequeue_locked() there so that
deactivate_task() takes the !dsq path and avoids the redundant lock
acquisition.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f95d1cf8d3d1c..56bc06a56bb34 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -2710,6 +2710,7 @@ static struct rq *move_task_between_dsqs(struct scx_sched *sch,
 			raw_spin_unlock(&src_dsq->lock);
 			scx_move_local_task_to_local_dsq(sch, p, enq_flags, dst_rq);
 		} else {
+			dispatch_dequeue_locked(p, src_dsq);
 			raw_spin_unlock(&src_dsq->lock);
 			move_remote_task_to_local_dsq(sch, p, enq_flags, src_rq, dst_rq);
 		}
-- 
2.53.0-Meta

