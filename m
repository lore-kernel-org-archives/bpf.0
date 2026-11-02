Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597560;
	b=JgITCEmNToK8iW9Sk/qT53qDadYmyZ9ZbQsJbgPyxYztTXd45tzlpBqXiL8JN4aMXVPh
	 0FkTMeqbtgSaEC1jty2vCKyC6HwgA3pslb7pns5Nt+K3CrvPFZFpwZE35YXXGo+G+Ehzy
	 NBgoREv2I8YKYDk1WWc1I/guFmN+bQiMa+qmXcNSf+HI/jv0+D9q0E9XLZbK+7VjPGbLW
	 37FiR1LIwF4OnzlCg5kTxwMj26V3zIu3e99v95wjp8A2FtSKtp4EwgwJfyCVsG7wfsmWi
	 eg1eoHQv8TxREAm49cijdSLC+yN20//f7+e9eiRl3iDCw7+eCvbJr66quuyWYYzOrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597560;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=X5B0jYi4hYyR/YrLd/KRabGeGLqUPq4FlZEL3f9eI3w=;
	b=RTiLiesT+xfCsnJloQy6AY4TttzN0Pb8Y6lATmCRuTu/GN9ANYh06ynUkiWRqg1HtzYM
	 8xVD5NTo3FjC1XgMiLIJz8hNb0/3EAoIBDdVPTW63/zjc9RMSvUjh3cVsyvHh4v9xDlCE
	 WWIwyxxcvB6B/PNOPu6IMKoFZbXoPQEU9Gm7cVatTmgrmm72Rawad4LbfFVrKrEJtURIi
	 I8pKUImWS0uQY80ieX0CaWamVl6R4bqmx0/A18rc3fJYH0O4FT/Mo4LDHaJTlZFR2PtfA
	 QvBXtpubNpZmE2E9X+mSNzim+bQm1eg8B+QC/vjUFiLnQ3kKi5TfTqmdJiMoM1NhcvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=ftNWmQxB;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B739C606A326;
	Mon,  2 Nov 2026 05:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B739C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=ftNWmQxB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793595619;
	bh=dM7ktu0uO/zYaO33T/SNIPFkYf8MtY78bXeNc3UjLlg=;
	h=From:Date:Subject:To:Cc:From;
	b=ftNWmQxB7ewdoqNJk07gC8EfRGBDRIxHfG+Ky7OcWo0vPuOV3Y73lskv67zizLP6w
	 xxd8KC9fl7q3tEw6A6IYilophzvh2n6xgZsfoNHv8uqvz+N6G9CD61V41lYVsNYU7Y
	 7Cc3t5uObdIi5EeQazpKKBhspE1dJli3O38fknh8=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 56724406D0;
	Sun, 01 Nov 2026 21:00:19 -0800 (PST)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Sun, 01 Nov 2026 21:00:12 -0800
Subject: [PATCH] sched_ext: Reject scx_bpf_destroy_dsq() in tracing
 programs
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-scx-destroy-dsq-tracing-v1-1-987a7f2f5bec@gentwo.org>
X-B4-Tracking: v=1; b=H4sIANsY6GoC/x3MMQ6DMAxA0asgz7UUU8LQq1QdkGPAS0JtVIFQ7
 t6I8Q3/X+BiKg6v7gKTn7qW3ECPDnid8iKoqRn60I9EgdD5wCS+Wzkx+Rd3m1jzgvHJgeNATDF
 CqzeTWY/7/P7U+geoj1MUaQAAAA==
X-Change-ID: 20261101-scx-destroy-dsq-tracing-53c0c541c155
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Josh Don <joshdon@google.com>, 
 Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christopher Lameter (Ampere)" <cl@gentwo.org>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793595619; l=2923;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=dM7ktu0uO/zYaO33T/SNIPFkYf8MtY78bXeNc3UjLlg=;
 b=2H123ZAEiiB7IjGsDVOEn/WHTBM5f5yDUDd53vFqt6zxH71jaDvfwbJ+aFKLLnClCH/qgi53h
 SZSPYbqgnmOBrLmY4wb0U4WOl62ROoQ3rDRF/FmK8somN1MUTBWbQ5s
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

scx_bpf_destroy_dsq() takes the target user DSQ's raw spinlock. However,
it is in scx_kfunc_ids_any, which is also registered for
BPF_PROG_TYPE_TRACING.

For an active root scheduler without ops.sub_attach, the compatibility
path in scx_prog_sched() lets an unassociated tracing program resolve to
that scheduler. The tracing program can then call
scx_bpf_destroy_dsq() while the target DSQ lock is already held.

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
            scx_bpf_destroy_dsq(dsq_id)
              destroy_dsq()
                raw_spin_lock_irqsave(&dsq->lock)

The tracing program recursively acquires the same raw spinlock and locks
up the CPU. Because the tracepoint runs before scx_finish_exit(),
disable_irq_work is not queued and the scheduler cannot enter its normal
disable path.

Reject scx_bpf_destroy_dsq() from tracing programs at verification time.
The kfunc remains available to SCX struct_ops and syscall programs.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
 kernel/sched/ext/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca6ee325ba583e8272be2afb0f1ecf..3ae21991b64ae51f61fe3c22f241b8c215fb4fd1 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -12134,6 +12134,9 @@ static const struct btf_kfunc_id_set scx_kfunc_set_any = {
  * when scx_locked_rq() returns NULL. Taking it while the context already holds
  * an rq lock, the same one or another cpu's, can deadlock.
  *
+ * scx_bpf_destroy_dsq() takes a user DSQ lock. A tracing program can run while
+ * that lock is already held and recursively acquire it.
+ *
  * Before returning, scx_bpf_sub_grant() and scx_bpf_sub_revoke() invoke
  * ops.sub_caps_updated() of the sub-schedulers whose caps changed, so those ops
  * run in the tracing program's context. No SCX op expects to run from an
@@ -12148,6 +12151,7 @@ BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cidperf_set, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_grant, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_sub_revoke, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_destroy_dsq, KF_IMPLICIT_ARGS)
 BTF_KFUNCS_END(scx_kfunc_ids_no_tracing)
 
 /*

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261101-scx-destroy-dsq-tracing-53c0c541c155

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

