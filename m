Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AAB4398FA
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199270; cv=none; b=o1mBm/9fm+/q+6T5imaHorh3mHxV64TOL02MKW2ZP+VlLK7m/znCZVraUBu5MgEiwAlyovaHuyne1LbMccNDXhG9CgVgg9wRK6gdX7Wdq92gko+UbyY2p0teoQiUhKlb9+HeBF8uulO3aFh5mhCb7SjoD4shtf2Xg4SF+VM15kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199270; c=relaxed/simple;
	bh=gaBwtgEKyOPcEEsD7osdzgsOcqXdV/RIyBOYnAYCAxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDAfnAlAQ3H0im4xebG1oYKKU/fAAfFAf0cbIeQs7wxVOqO3Tb9mvx2MIh9tVEB4Tzm8a3z6X36UNZwNdOkARKWpLtf0WhQOHHPMYIr2vWDZaHQsYWqAnJf1itWuy65z654NO/jlzkELU2zeaVyCCUM72KvOW0LnlduBus/WyM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cew4H93m; arc=none smtp.client-ip=91.218.175.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cew4H93m"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gaBwtgEKyOPcEEsD7osdzgsOcqXdV/RIyBOYnAYCAxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790199265; v=1; x=1790804065;
 b=cew4H93m0f6boMjxwjkZA0BeXqjL+2rV8dRJZOtKDlM1sAoVkgoeM09VTOulAMESEhoZp6+6
 Dk0pGz4YPyKlRKBJD+ccbK5spwn/EPWwoG8I+uNtbD9QiunXsN+SXpWvWviNb4jxk2D6Ap2ni+4
 w23P8Y/uPsV9d/0+RgWCEexo=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c7f1b9445d181e47;
	Wed, 23 Sep 2026 21:34:25 +0000
X-Mizu-Trace-ID: c7f1b9445d181e47
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
Subject: [PATCH] sched_ext: Update scx_dispatch_dequeue() comments
Date: Wed, 23 Sep 2026 14:34:18 -0700
Message-ID: <20260923213418.3197834-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remote consumption now reaches the !dsq branch with holding_cpu set,
just like direct dispatch. Also, the dsq-present branch races with
unlink_dsq_and_switch_rq_lock(), not dispatch_to_local_dsq().

Update both comments to describe the current transfer paths. No
functional change.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/sched/ext/ext.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 0135ff6824b03..f95d1cf8d3d1c 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1832,10 +1832,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 			list_del_init(&p->scx.dsq_list.node);
 
 		/*
-		 * When dispatching directly from the BPF scheduler to a local
-		 * DSQ, the task isn't associated with any DSQ but
-		 * @p->scx.holding_cpu may be set under the protection of
-		 * %SCX_OPSS_DISPATCHING.
+		 * When moving a task to a local DSQ through either direct dispatch
+		 * or remote consumption, the task isn't associated with any DSQ but
+		 * @p->scx.holding_cpu may be set.
 		 */
 		if (p->scx.holding_cpu >= 0)
 			p->scx.holding_cpu = -1;
@@ -1855,9 +1854,9 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		scx_task_unlink_from_dsq(p, dsq);
 	} else {
 		/*
-		 * We're racing against dispatch_to_local_dsq() which already
-		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
-		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
+		 * We're racing against unlink_dsq_and_switch_rq_lock(), which
+		 * already removed @p from @dsq and set @p->scx.holding_cpu. Clear
+		 * holding_cpu to tell unlink_dsq_and_switch_rq_lock() that it lost
 		 * the race.
 		 */
 		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
-- 
2.53.0-Meta

