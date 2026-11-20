Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795164276;
	b=Ztw8m0kprcpQ8DZPEt591IqZ0aN6MnP5ZdHUpsdD091rWe4SECrVupg56G8fCGJkXR+O
	 vBTjyapgfiCUYy/sTVS5A0UUmPzHepH8MxYgxJTwz5976FP0RQJcLu1gW9RVMdggrirdJ
	 1+7ZeOTNEgjB1A2Qlo2TcBRt+46xULZ5rvnLNAgwt4QF2Z/O7xY9cjP/5OshJtMVo74Hs
	 QKfOGFrHGjOR8YJcrBsKwg2BFbhdrq6HojYiEKKBuCdZB9dRqoQvlrf8pJxYGKAaEsq67
	 sSoeIDl0OlDQuH85PS2IOV6aOq1pcm952wSd1e+nmPCuS/ydHbh7C6wgkm00W2hg/8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164276;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jhUFxAY0wd/op5pav1e2eI8Q+uytDZi3dMtUnW/Jyrg=;
	b=WwX1h+19yNAloDNnPQChIQTwycI1K00+PuxEU+eY4dl1UQ8J5b8WzTDDw+xZ88Rfr8hw
	 MTSFRxyl+STKYy0reIQO7lThh+m7fX7bCH+jadt0SywUkSdD1jR/u14sR82YpIQQDW3D+
	 mgYuT5iNvZlrpObUYEmCx74LJ8aO9ySETXXBrbjyMHiDBTMYGQEdc1lqSEfwiHqRPJEz0
	 yfffmdDI/e+eRb+tJdulSzI9+Q/mk4LbEsV9XxzGGeB8pNgyDJAmA480LRZ6kQcuh0qa2
	 OyOjfjDsnuTubq3Nts2Oya5VtqD0pk+3JdW2zLObmsuLRnbpKOToHA3xmFo2ch5/fMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="a/OI4FdI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36919606A7F6;
	Fri, 20 Nov 2026 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/OI4FdI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795164275;
	b=eR07bOsCuoQ0hvQc/mz0PwwSvNBuJWLHwOnebSQO7XLHqzCuncRjtPyEKVUQ8TFYThj8
	 MoT6QfzRYjYrGjyedWth06S8R7L6mOyTx2vWHex/cfUWVmA//kLNttlHm5jc0kFilrWGT
	 G08frT7BRl/VCSW++dHtjmcYpj3qf9Mt7IogtNLGDNYdBWinCsNUzBnpSdB0QCf4wUiMS
	 V1VtM5nuY9stj9jvoWbZ2eubNdLjFFkcvlW7RT/8BPNF+pcVq01mxSxlynnw7OxWKc3Vt
	 eSBIClBOHRkGjeQI9Qqp+/2SzH9ndWlD8wMh0RNSY8/sPPg0LAAUcOt+Qsm/00ucgGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795164275;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jhUFxAY0wd/op5pav1e2eI8Q+uytDZi3dMtUnW/Jyrg=;
	b=I4Ows92HTzzlcfnzpddiIx6QnkEJbXSKsXJLjc6dcoWIp4oVEkZjMudEUK+74taMNe0v
	 jxG/tKmcG3TowoodNyhJazRwzU7oyFDFwfqEEctOkI9kT55moGzKwg0fJuiYaApklEryy
	 bfTY4HhKwNAvVXiy9Kh6wQZp+TJ8cojcYnuXat6mtp/ELy3Cad6zlOBVHgVMtuUXom08/
	 BXPD2HgVTQO3JZ7+P2jp9rLcKnlU/uYEEE51mBWVRaHve0wWcrFOuA30BFrGYpU3tvmPU
	 ojDOtn92fI5PQHhyznHVB4/9lTyDSgpi0L7WmhPtlUx6nBJbGvSYbpJ3L1NS+A2khHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 357AF1F000C6;
	Fri, 20 Nov 2026 08:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164275;
	bh=jhUFxAY0wd/op5pav1e2eI8Q+uytDZi3dMtUnW/Jyrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a/OI4FdI3fA/cjty8xeasNxVbXTEvh9uoTMjRNPzwgsewxwYTVsONgi3ziLYlKZw1
	 bxpG1cSjRB6cCWe0NdTplI4ar0TrpnRxNNPcCmQ3M14DNPOo4+rrEBZti6nKHek3yl
	 0eCYIYn8MXM0IGvsgsjL7xwY6w88vXcEIEgRD4ThPafB7AhulGTVZVBB1F0/dUCj9v
	 uXh5MUIRik7nrGiqMB0GNETjerUmyOAPgyYLn1UXhZwspky3YoTnHXj2gwhI7PjQ7J
	 4JWYbFlzFMCQbC2J1R0i/Vm+VMeliErGf+zIbw2cndHQubFFmU1oZIIHaZW/y+XxqI
	 o/4pyaDdy60CQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2409497B1;
	Fri, 20 Nov 2026 08:44:34 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 16:44:22 +0800
Subject: [PATCH sched_ext/for-7.5 1/2] sched_ext: idle: Don't stack a sync
 wakee behind a higher-class task
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
Message-Id: <20261120-scx-fix75-v1-1-254f782ff9b0@gmail.com>
References: <20261120-scx-fix75-v1-0-254f782ff9b0@gmail.com>
In-Reply-To: <20261120-scx-fix75-v1-0-254f782ff9b0@gmail.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, Shuah Khan <shuah@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>, 
 Hui Su <sh_def@163.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795164273; l=3366;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=XDlfptL4/63rv6xAwJeSPuaqpC6qexTX9EZsXa6XdeE=;
 b=+041VgJyuR080Y7h/zrFkwlzfmEXSrTActdVaCPfTvYKiDijZMidGqycmug0BVWAySZtC+EO0
 2NNuASmdAXDD3trtjhj9q2R1TZdKG0rJKoRLJrsGFG6ehfgS4OCidu5
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

On a sync wakeup, scx_select_cpu_dfl() can return the waker's CPU. It
does this when the waker's local DSQ is empty and some CPU is idle,
because the waker is expected to give up its CPU soon.

This is wrong when the waker's CPU runs an RT or DL task, or a fair
task in partial mode. The BPF scheduler can't preempt such a task. The
wakee waits on the local DSQ until that task blocks, or until the ext
dl_server runs the wakee. Meanwhile, other CPUs are idle.

The waker may not sleep at all. pipe_write() and sock_def_readable()
always set WF_SYNC, even if the writer keeps running.

This affects every BPF scheduler that leaves CPU selection to the
kernel, or that passes SCX_WAKE_SYNC to scx_bpf_select_cpu_dfl() or
scx_bpf_select_cpu_and(). In an 8 vCPU guest with scx_simple, an RT
task on CPU 0 wrote to a pipe and kept spinning. In 16 of 16 wakeups,
the reader ran on CPU 0, 169 ms to 1.5 s later. With an eventfd write
instead, which is not a sync wakeup, the reader ran on an idle CPU
within 0.1 ms.

SCX_OPS_ALWAYS_ENQ_IMMED doesn't fix this. It re-enqueues the wakee,
but in the same test the wakee still ran 16 to 483 ms late. The fair
class doesn't have this problem. wake_affine_idle() also picks the
waker's CPU, but select_idle_sibling() only uses it if it is idle.

Skip the shortcut when a task of a higher class than EXT is running,
or about to run, on the waker's CPU. rq->next_class shows this, and
rq_is_open() uses the same check for SCX_ENQ_IMMED. The wakee then
goes to an idle CPU, as in any other wakeup. Sync wakeups between EXT
tasks don't change, unless a higher-class task is about to run on the
waker's CPU.

Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
 kernel/sched/ext/idle.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index 922fbc3065cc..bf4dd8cb4255 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -534,6 +534,7 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * If WAKE_SYNC, try to migrate the wakee to the waker's CPU.
 	 */
 	if (wake_flags & SCX_WAKE_SYNC) {
+		const struct sched_class *next_class;
 		int waker_node;
 
 		/*
@@ -559,9 +560,19 @@ s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 		 * insufficient as the local DSQ of the waker could have tasks
 		 * piled up on it even if there is an idle core elsewhere on
 		 * the system.
+		 *
+		 * Also don't put @p behind a task of a higher class (RT, DL,
+		 * or fair in partial mode). The BPF scheduler can't preempt
+		 * that task, and it may keep the CPU for a long time. @p would
+		 * wait on the local DSQ until that task stops, or until the
+		 * ext dl_server runs @p. ->next_class also shows a higher-class
+		 * task that is about to run here. Reading it without the rq
+		 * lock is fine, since this is only a hint.
 		 */
+		next_class = READ_ONCE(cpu_rq(cpu)->next_class);
 		waker_node = scx_cpu_node_if_enabled(cpu);
 		if (!(current->flags & PF_EXITING) &&
+		    !sched_class_above(next_class, &ext_sched_class) &&
 		    cpu_rq(cpu)->scx.local_dsq.nr == 0 &&
 		    (!(flags & SCX_PICK_IDLE_IN_NODE) || (waker_node == node)) &&
 		    !cpumask_empty(idle_cpumask(waker_node)->cpu)) {

-- 
2.53.0


