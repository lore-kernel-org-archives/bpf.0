Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D944AA1FB
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266494; cv=none; b=c6vQW24bASagWoZaHs+Oir2sCnMzAfCT+KN+66c4aly8iDO1/J2SAfbG61g8LBsVOfKb7QnTNsWN/IEnOcBpLbRi6+F0twRl19Swjww8v7sU6+YzddPku6Z4cd9lNGmNVzPNs5uhefBnxZJoSj0uIN81fuBQ1eM/hCmukNNqvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266494; c=relaxed/simple;
	bh=E4QrKt+v0lNzALdrCP7x8suqEMSgDgOcYMNuh7YnQQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvdAxhmJRiHTWq7O3ll9o3AjMFkwqNN5BbTbUPh/Ix33nhBMWCTdxYiyM4P2491k+mhgmCk9FVVSA7F5rhg0wkA1AphCjLgFjUWehsBU2IRgoRxZx4bYMELVEj4zNjFi/N9bZz+UmhJLsAfaqLMIDaG2XVMZwY/uP1fGSiMkQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LsTJkcr1; arc=none smtp.client-ip=91.218.175.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LsTJkcr1"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=E4QrKt+v0lNzALdrCP7x8suqEMSgDgOcYMNuh7YnQQc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790266490; v=1; x=1790871290;
 b=LsTJkcr1rqXmYZFqCkluHSB0RIGfHtM2/s58mbmnN+I4yyJZKRKSn+TT8cz44pdUtMEsMdwz
 voY4vSlCgzkpddpBrDE4bWDDXW6olUI8xQRiYqykEf+/UUvHRuiz/bl24rYk+xxlgebpvtnhQLz
 hAugwtKyG5tWQzbDKW16Hoj8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 01de6d65797608aa;
	Thu, 24 Sep 2026 16:14:50 +0000
X-Mizu-Trace-ID: 01de6d65797608aa
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
Subject: [PATCH] sched_ext: Place dsq_vtime next to dsq_priq
Date: Thu, 24 Sep 2026 09:14:46 -0700
Message-ID: <20260924161446.3039726-1-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_dispatch_enqueue() calls rb_add() for a vtime-ordered DSQ while
holding dsq->lock. At each level of the descent, scx_dsq_priq_less()
loads the visited task's dsq_vtime, and that comparison selects rb_left
or rb_right from the same task's dsq_priq. In the x86-64 benchmark
configuration, these accesses fell on different 64-byte cache lines
before this change, so a cold visited task could require a second cache
line fill on the dependent descent path.

Move dsq_vtime immediately before dsq_priq, keeping dsq_seq and
dsq_flags next to dsq_list. In the two x86-64 layouts inspected, where
scx starts at offsets 776 and 840 in task_struct, the fields from
dsq_list through dsq_priq occupy one cache line. The exact cache line
placement depends on the containing task_struct layout and is not
guaranteed for every configuration or architecture. Where they share a
line, avoiding the dependent cache line fill helps reduce dsq->lock hold
time during vtime insertion and therefore contention on the lock.

In a 16-vCPU KVM guest, the instrumented enqueue interval was 4-6%
shorter with scx_lavd and scx_layered. scx_mitosis and end-to-end
workload time showed no consistent change.

This only reorders fields; no scheduling behavior change is intended.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 include/linux/sched/ext.h | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1e1fc3312bc40..b856768716249 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -197,9 +197,19 @@ struct sched_ext_entity {
 	u64			ddsp_slice;
 	u64			ddsp_vtime;
 	struct scx_dsq_list_node dsq_list;	/* dispatch order */
-	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
 	u32			dsq_seq;
 	u32			dsq_flags;	/* protected by DSQ lock */
+
+	/*
+	 * Used to order tasks when dispatching to the vtime-ordered priority
+	 * queue of a dsq. This is usually set through
+	 * scx_bpf_dsq_insert_vtime() but can also be modified directly by the
+	 * BPF scheduler. Modifying it while a task is queued on a dsq may
+	 * mangle the ordering and is not recommended. Kept next to @dsq_priq
+	 * as rbtree insertion reads both on every visited node.
+	 */
+	u64			dsq_vtime;
+	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	u32			reenq_cnt;	/* reenqueues since last run */
@@ -225,7 +235,7 @@ struct sched_ext_entity {
 	u64			tid;
 	struct rhash_head	tid_hash_node;	/* see SCX_OPS_TID_TO_TASK */
 
-	/* BPF scheduler modifiable fields */
+	/* BPF scheduler modifiable fields, along with @dsq_vtime above */
 
 	/*
 	 * Runtime budget in nsecs - how long the task may hold its cpu. Owned
@@ -240,15 +250,6 @@ struct sched_ext_entity {
 	 */
 	u64			slice;
 
-	/*
-	 * Used to order tasks when dispatching to the vtime-ordered priority
-	 * queue of a dsq. This is usually set through
-	 * scx_bpf_dsq_insert_vtime() but can also be modified directly by the
-	 * BPF scheduler. Modifying it while a task is queued on a dsq may
-	 * mangle the ordering and is not recommended.
-	 */
-	u64			dsq_vtime;
-
 	/*
 	 * Out-of-band slice request from scx_bpf_task_set_slice() when the
 	 * caller does not hold the rq lock, applied under the rq lock at the
-- 
2.53.0-Meta

