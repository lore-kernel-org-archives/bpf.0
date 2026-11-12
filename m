Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.204
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489014;
	b=xJMsE1ihIWUMQjkiOk5+zrgxMueIJaRqHPWtiPEXUMVZ7Z/86fBQPIL0XHsAkid1vHIe
	 DAVos9uPEeehVc9Ysk7j85XvSdULdEHu4spNe9R7jvdV7aamq7NZyMA/3w1lIxmfNMbG/
	 8Wx05hOS8lee6YZHiU10Wli7PRm4x/Jbp2hVOpJ/NpsEaSAmECLIuBnsjtAfmp2vx3rJj
	 +9IgeV4yL0SQnV5qhqN/bDGkmpzKocRQmAaJzwO47+nvQ2xjeCHg6ivRNdutmgdnssD4o
	 bNHa7GUZGaxFEafnQFlswOU75lrdFHgeNalJao/xHnF9iBbIjMEhWXsBB1v8p2uIbaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489014;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VZ5eT6B75LMWy1ddL3HEmfKOZCeeu08WJvkuJTYb4oI=;
	b=0/aBNP0zf8NWQ9zQzVS+FEeCAlBMWpiMQB22U4Z+cpzDFFh1FD9oGjb3MwEMOc34DnvA
	 zkEWW1+URKdwhkZlFlZWn189WoQNd8IZE5lTnnDcE4pr9XrqPD7m1rl1MWft1+8sc3XgY
	 YONxLHDrVkNRxjpzOLuHY1CAsNzT/5L5zkYkCQzXrqBVuby5XY/LTzmozGLrFXTuFr9E1
	 qo5c7N67jchbLFy0FXNLdczKRaKPs+gqK4SHsOSXBKOlshwGZ4WqZgsYuGV5uEIrX0YJC
	 RR78vSMRmoXZ/TQQcXJKGrZUnAaYDcGs59Zi/nC7UV+i+XoP8Qc9VbHNy2k/xjMf26w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GFy0xwG+;
	arc=none smtp.remote-ip=91.218.175.204
Received: from mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BD606A898
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C0BD606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GFy0xwG+
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ngqf9+sqR9FZGAPuRCkZiauWpsW12zu/jja2vEiaVxU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489011; v=1; x=1795093811;
 b=GFy0xwG+FtzOpEQ2/54N26lfYTcrOGxomcHIe4iFujyrLrJm+jm7GUG8ER7wYon0bz7SE2va
 cqEtLaJhAIRQh6lPJF+Do7kHihtgrhj344JHjwvSwCFN6OP81SsvXzPcA0/V0s/xiC89YACEL0o
 FR8f8ikz2HMWgO23vePzNbI8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 944e6862ae57fa88;
	Thu, 12 Nov 2026 13:10:10 +0000
X-Mizu-Trace-ID: 944e6862ae57fa88
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/6] sched_ext: Reject DSQ iterator kfuncs in tracing programs
Date: Thu, 12 Nov 2026 21:09:29 +0800
Message-ID: <20261112130934.563321-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

bpf_iter_scx_dsq_next() and bpf_iter_scx_dsq_destroy() take the target
user DSQ's raw spinlock, but they are in scx_kfunc_ids_any, which is
also registered for BPF_PROG_TYPE_TRACING.

For an active root scheduler without ops.sub_attach, the compatibility
path in scx_prog_sched() lets an unassociated tracing program resolve to
that scheduler. The tracing program can then call the iterator kfuncs
while the target DSQ lock is already held.

For example, a scheduler which mixes FIFO and priority-queue insertions
into a user DSQ triggers scx_error() from scx_dispatch_enqueue() while
holding that DSQ's lock. scx_claim_exit() emits sched_ext_exit before
the lock is released:

  scx_dispatch_enqueue()
    raw_spin_lock(&dsq->lock)
    scx_error()
      scx_claim_exit()
        trace_sched_ext_exit()
          tracing BPF program
            bpf_iter_scx_dsq_new(dsq_id)
            bpf_for_each(scx_dsq, p, dsq_id, 0)
              bpf_iter_scx_dsq_next(it)
                raw_spin_lock_irqsave(&dsq->lock)

The tracing program recursively acquires the same raw spinlock and locks
up the CPU. Because the tracepoint runs before scx_finish_exit(),
disable_irq_work is not queued and the scheduler cannot enter its normal
disable path.

Reject the two iterator kfuncs from tracing programs at verification
time. The kfuncs remain available to SCX struct_ops and syscall
programs. bpf_iter_scx_dsq_destroy() has no independent live
reproduction: its cursor only links into the DSQ after at least one
successful next(), which deadlocks in the same window first. It is
included for symmetry.

This extends the coverage of commit b07a7450f6ef ("sched_ext: Reject
rq-lock-taking kfuncs in tracing programs") and commit 4c2e0751d5e6
("sched_ext: Reject scx_bpf_destroy_dsq() in tracing programs").

Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 536648378ea3..063b2964099a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -12166,8 +12166,10 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  * when scx_locked_rq() returns NULL. Taking it while the context already holds
  * an rq lock, the same one or another cpu's, can deadlock.
  *
- * scx_bpf_destroy_dsq() takes a user DSQ lock. A tracing program can run while
- * that lock is already held and recursively acquire it.
+ * scx_bpf_destroy_dsq() takes a user DSQ lock. So do
+ * bpf_iter_scx_dsq_next() and bpf_iter_scx_dsq_destroy(), the latter only
+ * after a successful next() has linked the cursor. A tracing program can
+ * run while that lock is already held and recursively acquire it.
  *
  * Before returning, scx_bpf_sub_grant() and scx_bpf_sub_revoke() invoke
  * ops.sub_caps_updated() of the sub-schedulers whose caps changed, so those ops
@@ -12184,6 +12186,8 @@ BTF_ID_FLAGS(func, scx_bpf_cidperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_grant, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_revoke, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_KFUNCS_END(scx_kfunc_ids_no_tracing)
 
 /*
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
