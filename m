Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CA48424C
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255115; cv=none; b=nP5fhDkBOKTIYO+5DFvSZXKnAlIEbX3560uxcwGzfxiJiVAXHA8fIjxXclk+LjwX6uRGJDkBLwnQehiNVjzFpAiQlL0QFU3V+MpGQcfIY/kUhWnZgidoA4wSK9He1OB8EQS05OMTcpTB7CcKI0RTWFwPhN6ANy6kOqFPL6aFlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255115; c=relaxed/simple;
	bh=EMai31/qqyf5QaAObsfQuiXXHW9sYpANFB9S/2uRX4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRJmoitpean2muSxEsvlPqhgjZlFh5gKaozd36NBGnXRdquZszMDoV9k30iSiNVe6VpwkOKaCMUPnN3laMv09QTpnj48Is5CISHvF+U+sNbuophnu+HXntn+HqSPht3Cbdjv7IK4BcXOFUo7xUB679tMb7Qs12IpR+cir+iYxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GIDB7sst; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GIDB7sst"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EMai31/qqyf5QaAObsfQuiXXHW9sYpANFB9S/2uRX4k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790255108; v=1; x=1790859908;
 b=GIDB7sstN5kfpUloqyFxkw201OUYQ80sOb0J8uvAcet+ZhI6PhWttd8rT12+KTQ6kOTeEXjj
 riLjHXvRMAvVoYXnY98XiLKVQA3QCohYoOM8B7zSJ4+j2XsUhMvMoQQCWEm36D92keHK/bxH1Ek
 1SyLATqBtxZd7PeWCs/binEU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a8de4e7e9e9a9053;
	Thu, 24 Sep 2026 13:05:08 +0000
X-Mizu-Trace-ID: a8de4e7e9e9a9053
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
Subject: [PATCH v2] sched_ext: Update scx_dispatch_dequeue() comments
Date: Thu, 24 Sep 2026 06:05:03 -0700
Message-ID: <20260924130503.853919-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remote consumption now reaches the !dsq branch with holding_cpu set,
just like dispatch_to_local_dsq(). Clearing holding_cpu in this branch
also tells dispatch_to_local_dsq() that it lost to a dequeue. The
dsq-present branch races with unlink_dsq_and_switch_rq_lock(), not
dispatch_to_local_dsq().

Update both comments to describe the current transfer paths and race
semantics. No functional change.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
v1 -> v2: (Tejun)
- Name dispatch_to_local_dsq() in the comments and commit description.
- Explain that clearing holding_cpu tells dispatch_to_local_dsq() that it
  lost to a dequeue.
- Rewrap both comments to 80 columns.
---
 kernel/sched/ext/ext.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 911bb6d433ba7..d01f44839da32 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -1821,10 +1821,10 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 			list_del_init(&p->scx.dsq_list.node);
 
 		/*
-		 * When dispatching directly from the BPF scheduler to a local
-		 * DSQ, the task isn't associated with any DSQ but
-		 * @p->scx.holding_cpu may be set under the protection of
-		 * %SCX_OPSS_DISPATCHING.
+		 * When dispatch_to_local_dsq() or remote consumption moves a
+		 * task to a local DSQ, the task isn't associated with any DSQ
+		 * but @p->scx.holding_cpu may be set. Clearing holding_cpu
+		 * tells dispatch_to_local_dsq() that it lost to a dequeue.
 		 */
 		if (p->scx.holding_cpu >= 0)
 			p->scx.holding_cpu = -1;
@@ -1844,10 +1844,10 @@ void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		scx_task_unlink_from_dsq(p, dsq);
 	} else {
 		/*
-		 * We're racing against dispatch_to_local_dsq() which already
-		 * removed @p from @dsq and set @p->scx.holding_cpu. Clear the
-		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
-		 * the race.
+		 * We're racing against unlink_dsq_and_switch_rq_lock(),
+		 * which already removed @p from @dsq and set
+		 * @p->scx.holding_cpu. Clear holding_cpu to tell
+		 * unlink_dsq_and_switch_rq_lock() that it lost the race.
 		 */
 		WARN_ON_ONCE(!list_empty(&p->scx.dsq_list.node));
 		p->scx.holding_cpu = -1;
-- 
2.53.0-Meta

