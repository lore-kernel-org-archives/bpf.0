Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189958;
	b=l3aJCTBsZbGj50yBQAWPrMx5TwU4XpU9ucveA59a/l3UfkqiFm0u1GlfR1Q2rm8m6QuP
	 hEc2unxdANf7KPw8buz+HX0lf21i+prH/NQGTmWOmP/KW6i6lma34lg8uCGdXS231EEPS
	 imNa1N7VQJHyhou2DUid6ZhrtbWCa8MjUlNV6WBTfpEK7EhrZqdTVv12+1Bia8TCPHTER
	 T0RtilG0qnA00vOmTNJ7dJxxnnV5AE8sRu0+MumTbZCEdxYqkfz/QRY6fvE/nTC7reFVv
	 CwchE3sQGK3V52AjozUdhHQg4ueHdiPULvni+19GlUlR/gyS5lMv5rftfEujL3BmRiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189958;
	h=DMARC-Filter:DKIM-Signature:Subject:Message-Id:X-Mailer:
	 X-Lms-Return-Path:To:Date:Mime-Version:Cc:Content-Transfer-Encoding:
	 Content-Type:From:X-Original-From:Received;
	bh=Jxut/MrKMYK8UeaqLdbANTgLB+m90HMiLTxeFkgxSMM=;
	b=O4c/WQNlEjNxMrTPQTWP0pQUUFR+LW1rpC34vDqeNrDTeTFv6B0DIXoEs/w2hrLhHl9R
	 fiCNE7uyKtN5RGcoWUdRtJhVdU5gSqBoVKf5DyJC+ZfCJxXU2U3MPRqOEXaH4S83Y2Cyi
	 Zym9z6vOeVTKvzyXMhknA8HgLv8CeFlm9+Vj0AHRy//wOhGfH36nyCmXnYmfP4wll2vfa
	 hw7RNZ2t5haADH/C9w3hvJMj2sqCnfCwm222ej0PuLq8miWCk3c7aYBLG1u/3ajDZGFrO
	 /RKUnju5xljklsfcBPf1J/2NyZIlruUKNVrB38Qep/ODVnzqY/eFvVeLXLNSXdZpo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=insta360.com;
	spf=pass smtp.mailfrom=insta360.com;
	dkim=pass header.d=insta360.com header.i=@insta360.com header.a=rsa-sha256 header.s=feishu2606151854 header.b="TR6b+d/p";
	arc=none smtp.remote-ip=209.127.231.43
Received: from va-2-43.ptr.blmpb.com (va-2-43.ptr.blmpb.com [209.127.231.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4B606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 12:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BA4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=insta360.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=insta360.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=insta360.com header.i=@insta360.com header.a=rsa-sha256 header.s=feishu2606151854 header.b=TR6b+d/p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2606151854; d=insta360.com; t=1793189952; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Jxut/MrKMYK8UeaqLdbANTgLB+m90HMiLTxeFkgxSMM=;
 b=TR6b+d/pC+85EqP4rpOJqjpS8YOrRCEADLpIVA18ez8kCWDXaXyruaU1xYp6c2T/iBwhZF
 Yv2v9EHPl7vB27z6NZwgsvNpxMbTREGNgEkTlkp6Qx0ji2P8NcXPAZElHb9ZJX1yFrLtbZ
 n4SyuLd+bo7ciqfb7O6Ap12kua8kBug2qXkN25GzR7dofZnx3aLazfAAFEj6YRhZaBGE7h
 db4+Bc3jokvIm2BBnU9VkKakFr0PpLUNfoA6rPEiViolA7vCfJ1EFyZmYs6Vm6bxdYK+sU
 JO4mNXhjugi/kYhZBZG5EI+Q9u78CWRutyTPrfYmVjh7wc2CVAGe2Fv3t1F4FQ==
Subject: [PATCH bpf] bpf: Always hold RCU read lock around perf callchain in __bpf_get_stack()
Message-Id: <20261028121859.994-1-yangsongsen@insta360.com>
X-Mailer: git-send-email 2.53.0.windows.2
X-Lms-Return-Path: <lba+26ae1e83e+b68203+vger.kernel.org+yangsongsen@insta360.com>
To: "Alexei Starovoitov" <ast@kernel.org>, 
	"Daniel Borkmann" <daniel@iogearbox.net>, 
	"Andrii Nakryiko" <andrii@kernel.org>
Date: Wed, 28 Oct 2026 20:18:59 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, 
	"Eduard Zingerman" <eddyz87@gmail.com>, 
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>, 
	"Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, 
	"Jiri Olsa" <jolsa@kernel.org>, 
	"Ihor Solodrai" <ihor.solodrai@linux.dev>, 
	"Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, 
	<syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Songsen Yang" <yangsongsen@insta360.com>
X-Original-From: Songsen Yang <yangsongsen@insta360.com>
Received: from DT-9806 ([61.241.19.90]) by smtp.feishu.cn with ESMTPS; Wed, 28 Oct 2026 20:19:09 +0800

__bpf_get_stack() only takes rcu_read_lock() around get_perf_callchain()
when may_fault is true, assuming that non-faultable callers already run
inside an RCU read-side critical section.

That assumption does not hold for BPF_PROG_TYPE_SYSCALL programs. They
are always sleepable and bpf_prog_test_run_syscall() only holds
rcu_read_lock_trace() while running them, yet through
tracing_prog_func_proto() they are given the non-sleepable
bpf_get_stack_raw_tp() helper, which calls __bpf_get_stack() with
may_fault == false. get_callchain_entry() then does
rcu_dereference(callchain_cpus_entries) without rcu_read_lock() held,
and lockdep complains:

  WARNING: suspicious RCU usage
  kernel/events/callchain.c:163 suspicious rcu_dereference_check() usage!
  1 lock held by repro:
   #0: (rcu_tasks_trace_srcu_struct){....}-{0:0}, at: bpf_prog_test_run_syscall
  Call Trace:
   lockdep_rcu_suspicious
   get_callchain_entry
   get_perf_callchain
   __bpf_get_stack
   bpf_get_stack_raw_tp
   bpf_prog_test_run_syscall
   __sys_bpf

The callchain buffers are freed with call_rcu(), and an RCU Tasks Trace
read-side section does not imply a normal RCU read-side section, so
holding rcu_read_lock_trace() alone is not what get_callchain_entry()
expects.

Take rcu_read_lock() unconditionally. Nesting it inside an existing RCU
read-side critical section is cheap and harmless, as suggested by Andrii
in an earlier discussion.

bpf_get_stackid() is not affected: sleepable programs cannot use
BPF_MAP_TYPE_STACK_TRACE maps, so syscall programs cannot reach it.

Testing: on top of bpf/master at commit c8a8a68d3ab4 ("bpf: Don't re-sort
subprog_info[] for every new subprogram"), x86_64 under QEMU TCG with
CONFIG_PROVE_RCU=y (syzbot config with KASAN/KCOV/modules disabled), the
syzbot C reproducer
triggers the splat above without this patch and does not with it. A
minimal BPF_PROG_TYPE_SYSCALL program calling bpf_get_stack() was also
run via BPF_PROG_TEST_RUN: it warns before, and returns 0 without a
warning after. BPF selftests were not run.

This issue was located, and the fix, changelog and tests were prepared,
with the help of an AI coding assistant (Claude); the submitter has
reviewed the change.

Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
Link: https://lore.kernel.org/all/CAEf4BzYN33yQhO-tsF8pUWDMZoiLAXkV+Z1oP6fJkByocYcjpw@mail.gmail.com/
Signed-off-by: Songsen Yang <yangsongsen@insta360.com>
---
 kernel/bpf/stackmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index f7e8d766d128..e452ca7c859a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -812,8 +812,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	preempt_disable();
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
+	rcu_read_lock(); /* need RCU for perf's callchain below */
 
 	if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
@@ -823,8 +822,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+		rcu_read_unlock();
 		preempt_enable();
 		goto err_fault;
 	}
@@ -832,8 +830,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	trace_nr = callchain_store(trace, trace->nr, buf, elem_size, flags);
 
 	/* trace should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
+	rcu_read_unlock();
 	preempt_enable();
 
 	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
-- 
2.50.1
