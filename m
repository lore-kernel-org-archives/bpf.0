Received: from mta1.migadu.com (out-240.mta1.migadu.com [95.215.58.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B31531AF8
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117753; cv=none; b=oj/INvGVWQ4NqPpmDFVnTJ+2CKrmo5gbSLIE5rNc7Z3M32niKDP+rP7IOPolvrrCML3SglYAp7vnjjm/SeI23CtibuvWKwjzgGYfkRaRdPK8MMrN+V5UNnyRTTmc9kniTY4wFkgaHBWgnyE0GyGC/Kz22yKBe1SHf7ZPBGswEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117753; c=relaxed/simple;
	bh=GLYDVWUo9vlxL9owdIP78Jsu7Teexjv82ekJ8dgAFIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfONAzRrROVaw6PUdMeprXaFsxpNHhVzmviX9IT/U8S2YZC1DMABzWoUY+5Jc+SSZq6n9yXDxbT1U4yHKDoO5qmSa5WHP4DmnjcKoce5vF6oDoWlVFJwPu6AajGW9v+2axs8zsQ2ooNYFrBv+T25QWjEkpHZD28ekWwGw3MkfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xd7zHWVo; arc=none smtp.client-ip=95.215.58.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xd7zHWVo"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GLYDVWUo9vlxL9owdIP78Jsu7Teexjv82ekJ8dgAFIU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790117746; v=1; x=1790722546;
 b=Xd7zHWVoi37khI1DqaZyroOpTo4SreMIjIX8LHX+0Q/0gUBIYYoo3W59fyQfGaRMS78n0UGZ
 UPi0fgFHahvlvn+2c+CR9KXeLoKWaN4/gqxnx2RG4VA7mOOuwMm00SurN6C6FUxtBrLeyOiZF7J
 hLuinSE7rHNfqWa5ohjnZG+0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7fe70d7a76de0350;
	Tue, 22 Sep 2026 22:55:46 +0000
X-Mizu-Trace-ID: 7fe70d7a76de0350
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	andrii@kernel.org,
	peterz@infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH 2/2] tracing: fgraph: Add a cond_resched() to the shadow stack retry loop
Date: Tue, 22 Sep 2026 15:55:26 -0700
Message-ID: <20260922225526.1554758-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922225526.1554758-1-vineet.gupta@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is supplementary to previous patch and is effective only for
!PREEMPTION kernels.

The preceding patch cuts the number of sweeps over the thread list by
32x, but the loop is still O(N^2). Each pass walks from the same start
init_task under rcu_read_lock() with no reschedule point. On a kernel
that cannot preempt the walk, a large enough thread count lets one task
monopolize a CPU until the walk completes.

Add a cond_resched() between sweeps which is safe since it is outside
the RCU read-side critical section.

It is understood that this is effectively a no-op for CONFIG_PREEMPTION
builds, which is what default x86 and arm64 kernels are today.
A CONFIG_PREEMPT_DYNAMIC build with "preempt={none,voluntary}"
used to work but even that got inhibited since the commit
7dadeaa6e851 ("sched: Further restrict the preemption modes").
Measured on a 60-core machine with a PREEMPT_LAZY kernel and 400000
idle threads, this patch changes neither the runtime nor the yield
count, which stays at zero.

Where it does have effect is !CONFIG_PREEMPTION builds: architectures
that still offer PREEMPT_NONE or PREEMPT_VOLUNTARY, and the stable
kernels where x86 PREEMPT_NONE remains a build-time choice. Verified
on a 6.16 PREEMPT_NONE kernel, 240000 idle threads, three runs each,
with the loop instrumented to count passes and cond_resched() yields:

	                 time            yields   soft lockup
	unpatched        51.3-54.6 s     -        3 of 3
	cond_resched()   52.7-53.0 s     592-609  0 of 3

The runtime is unchanged and the soft lockups are gone. Every
need_resched() converts to a yield, giving an average of about 98 ms
between reschedules.

There is a second effect on those builds. When cond_resched() does not
reschedule it still calls rcu_all_qs() on !CONFIG_PREEMPT_RCU kernels,
reporting a quiescent state. So the two failures seen in the field are
addressed by two mechanisms: the soft lockup by yielding so the
watchdog can run, and the RCU stall by reporting a quiescent state
even on passes where no yield happens.

This is deliberately separable from the preceding patch. If the view
is that a no-op on the architectures anyone runs is not worth carrying,
dropping this one leaves the batch-size fix intact.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 kernel/trace/fgraph.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b53513b..86d11217c584 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1249,6 +1249,14 @@ static int start_graph_tracing(void)
 
 	do {
 		ret = alloc_retstack_tasklist(ret_stack_list);
+		/*
+		 * Each pass rescans the thread list from the head, so the
+		 * loop is O(threads^2) overall. The RCU read-side section
+		 * ends with the pass, and both locks held here (ftrace_lock,
+		 * and fprobe_mutex for fprobe users) are mutexes, so it is
+		 * safe to give the CPU up in between.
+		 */
+		cond_resched();
 	} while (ret == -EAGAIN);
 
 	if (!ret) {
-- 
2.53.0-Meta

