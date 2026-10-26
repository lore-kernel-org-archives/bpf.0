Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983886;
	b=F5nqxctF9ACiyi6gap2T6+kWUnhRd7vMsKLy1VUHE0tmFvceOJN6jGFp+InKMY1MNyRG
	 N0SXBe3basRkIkYjKJRXUCTmN8lNxjMKxUZIR10fpgNQ4SthRc9aHZAy33OVL1a4wkjji
	 dedp7Nv8wNTI9BLIvV5CtaPa/Kd+PdOgYiO0r7WABCPvGN2/vzGmez0PSDGDOG6wufvqs
	 ImLqjaRlDudTCFBqXU7UE/kBY1YBoQjK6a0VhYLw4LzAjU4NQNo+UiMA6VQGtOo5iUhX4
	 I8lXoPdxkl78H16rapjyACI9Klist7tEwLrwnkIfVLJjSY7PNXrYRcxCax4Q6qBS40A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8VJYTDaN0AVP3QhEPnkb4F/0QSVtf9O6piTt91k/8pQ=;
	b=qU+nOHzroMbDVN+DNXKrDYDlwuSLUlv0wPlpdCyMk1v+Ol8S9ghRVaHSMWG6UaEzcSiK
	 LV9Y6V07x9fiEif9OW0YUkV7kqYs+OrJyzxi8XW8NBwwKI2W5GBRAOHOTZL55NEFDvXWs
	 vVTPX34Y/nu2jWcpkxxH02iwCtyO1PW0a4F4HsplT7njR7YRkg3r7Un7iTFBZh2phuznA
	 KSn6vY9OGb3osPuZ395YKQB3SbxuqSVfjoHJCLVzuOG4XElXMzFrru+a0udpUzw8sQK7/
	 GTUhrVrXXrhA1aHq3qWrUkr4HCeFn99UDT0KFgv/+p+12lC+C5TgURavxZzrYKJ3Kzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LLLErAiX;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDCBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LLLErAiX
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1503819a12.0
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983885; x=1793588685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8VJYTDaN0AVP3QhEPnkb4F/0QSVtf9O6piTt91k/8pQ=;
        b=LLLErAiXjGJlxfCRyN1Btw1SlOgrqr/7kEEhf+hN14hshqHTwlU0hZ7rcGo559srhI
         HxH1HyXqrn56yTLUZ/3MwedYoFgGg12ceBETzUs9sIygTYEAJiBrgLev/8S8c2a82JfP
         Uki8ehgggqnfcZjExFGvNp2FT/ahuIgCK+o8dolKmVfxVVaCBg2EuY9m+Hls8o90vJPf
         bOxjDP6nPLSl+3Ekbiv1eOpcfdYziTtdqjYglaPEGzM5hv6R7JM9YfLUQgjnxashPUQP
         vScd3+fVJsnguJ1/FRq33YiEjLUwUY6bo12Q5te8r12Zb2DZ6QzZDzeXtJB8/+OILp+e
         ZaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983885; x=1793588685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8VJYTDaN0AVP3QhEPnkb4F/0QSVtf9O6piTt91k/8pQ=;
        b=PE2C7uqLfhZEQ5apHQXwrg2Sl2Sf4B/KWUULndqApUzmnt4g/pxKZxBdMjM1dUriRQ
         6kCPKVnTHajKQKZ/15b1HKiW1b4kFVoBRATvxnJubxZxhnuiobblJxML3YgQZ/jLcxY0
         rOvkB5NEuCE9QnE8mlwzZ1+6UuTph/ADroOKAl9RoyF8eCvh1blhx7HeLJU75GIH9zU5
         gCOaA5it7v0t56r30JGRjuNSj3w1ZF0NIu/YbrbKYWLelLiiMTAOlPcHzEfM3TbnVWoS
         hja/9Y1cwTtboUiPdbtQph8RLga7G0E7EE4CWhDMr20nJXjMNhcrQ3WTcNqp6wqnRbkB
         SDkg==
X-Gm-Message-State: AFq9FYIyNioGhV4vFwCLzrUGOf8oDA7RWwXwDL7e7MegMh7oWhcjqcrt
	U0AW5CsNNl5I9CA6OkrRRIcmctLMJhVVE/z7vo/Hu1WoED1N+cm0rdZMFBwdJA==
X-Gm-Gg: AYBFou1NZ+eMhSoNNrqpJOMrYOk0dDqBa9dKTqmwHM41MKFMFOOvkg1eAPdYzonLpi/
	qf/9mmIH8GWKCzOXJY7yLiAm0Z5pTSfbxTpuR7WHfg93VhNbbDYsCB2cV83haNWC2c9Xq78J8Zd
	AAMGUxwy36uYxDrY14sbsv7Ddngs3wFR/k/fBfKkYptXvN7Ad8JUTVDf3i1HQMlafc1JFNSiNyK
	WKB0nc7IhD3cR27+orrmmnmwjHU2jtx4JJ5pA8okFmueQDOk0VBsu6Rjk9DFR7sttr7hCyTKRMi
	+FxmNibwo0ULYpVPYPYnHrYHfKHO5CDLDh30UTz0x2+1u+zeUf4/CX7oC+egVTnMIWskYGvxmGH
	k+ddDF2h30YRIQ6qV75AiKBoUE2KQBCixjXYAPa4d3rFtaZEOP2YifbDdLtuy3+RMxSn6fS/WAo
	zmkgKVqKVd9O82acLItHi6Jmakf0edPVFBdGOhywxzXJK8OCwZe3RBkd6lHfRaj4Kvt/mZ1S8jo
	WnczgoIQ0U4n4mGg9hgfvbyC+FwVfkXly3tgf6cPVTu4IjqZuH1uX2pgLaa4WN/CcpKn1pWbdZy
	o8Dpm/qGBNBUTjdljbFJy+Ezce08i0WnNoDa0Q299+8MX8WLE6TjnYBayzVVkSuudwOw7PhTHFu
	t0g/0ibaZF+opRp8EQdf9evmG
X-Received: by 2002:a17:90a:da85:b0:3a4:9a7a:360 with SMTP id 98e67ed59e1d1-3adeabde791mr5333010a91.29.1792983884847;
        Sun, 25 Oct 2026 20:04:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba38910sm4700941a91.1.2026.10.25.20.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:04:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 51/81] bpf: Check stack and count calls of recursive subprogs at run time
Date: Mon, 26 Oct 2026 02:59:12 +0000
Message-ID: <20261026025943.404450-52-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The verifier rejects recursion, because it cannot know at load time how
deep the calls go and how much stack they use.

Limit recursion at run time, as may_goto limits loops. Each recursive
subprog, that is each subprog on a cycle of the call graph, starts with a
check. The check fails when the stack has no room for one more frame, or
when this run of the prog has no calls left. Then the subprog returns 0
immediately. At its first insn the subprog holds no lock and no reference
of its own, thus it can always exit there.

  entry:  depth += weight of the frame
          depth > limit ?            --- yes ---+
          calls += 1                            |
          calls > BPF_MAX_LOOPS ?    --- yes ---+
                  | no                          v
                  v                     report, one time in a run
          body of the subprog           r0 = 0
                  |                             |
                  v                             v
  exit:   depth -= weight of the frame

depth and calls are per-cpu counters of the prog. The main prog clears
calls when a run starts. bpf_throw() subtracts the weights of the frames
that it removes, because they do not get to their exits. If unwind_goto
follows each call of the subprog, a failed check leaves with unwind_exit.
Then the callers continue at their cleanup code.

  limit, for one prog on one cpu             value
  -----------------------------------------  ------------------------------
  kernel stack of recursive frames           4096 bytes
  stack in arena (r12) of recursive frames   the part that is free
  calls of recursive subprogs in one run     BPF_MAX_LOOPS

The stack limits are in addition to the deepest chain of calls without
recursion. One counter serves the two stacks: the weight of a frame is the
larger of its shares of the two limits. The check counts calls because a
subprog that calls itself two times can run for a very long time at a small
depth.

Progs without a recursive subprog get the same code. A recursive subprog
has the cost in each call, also when it does not recurse. The three updates
of the counters are fetch_add insns. They are BPF_ATOMIC_LOCAL where the
JIT supports it: on x86 they have no lock prefix. On x86-64 (Zen 5) a call
without the check costs 0.65-0.95 nsec. The check adds:

  each run              3 insns in the main prog               +0.44 nsec
  each call             8 insns at the entry, 4 at each exit   +2.66 nsec
  first failed check    report to stderr         about 5 usec + 0.22 usec
  of a run                                       per frame

The first failed check of a run sets 'unwound' in bpf_prog_info. It ends
the 250 ms of may_goto for this run, thus the loops of the run exit too. It
prints the stack to the stderr stream of the prog after one of these lines:

  ERROR: No room in the stack for a call of a recursive function
  ERROR: Too many calls of recursive functions

Limitations:
 - The check does not read the stack pointer. Thus recursive_frame_size()
   must be an upper bound of the frame that the JIT makes. The verifier
   calculates it after it inlines bpf_loop(), which adds 3 stack slots and
   3 registers.
 - Only fentry can attach to a recursive subprog. The trampoline of fexit
   stays on the stack at each level, and the check does not count it.
 - Progs that nest on a cpu do not share the limits: their stack use adds
   up. Two runs of the same prog that nest on a cpu share the stack limits.

No code marks a subprog as recursive in this patch.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |  12 ++
 include/linux/bpf_verifier.h |   5 +
 kernel/bpf/core.c            |  31 +++++
 kernel/bpf/fixups.c          | 263 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |   8 ++
 kernel/bpf/verifier.c        |  16 +++
 6 files changed, 335 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b1740d8ca8d..2ff1a2c97328 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1889,6 +1889,13 @@ struct bpf_may_goto_budget {
 	u64 count;	/* what is left until the next look at the clock, 0: the time is up */
 };
 
+/* What the recursive subprogs of a prog have used on this cpu, see bpf_insert_recursion_checks() */
+struct bpf_recursion_budget {
+	u32 calls;	/* the number of calls in this run of the prog */
+	u32 reported;	/* it was said that the run is out of budget */
+	u32 depth;	/* the weights of the frames that are there */
+};
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1937,6 +1944,8 @@ struct bpf_prog_aux {
 	bool might_sleep;
 	bool can_unwind;
 	bool unwound; /* main prog: see bpf_prog_info */
+	/* on a cycle of the call graph: what it adds to call_depth of the main prog */
+	u32 recursive;
 	bool kprobe_write_ctx;
 	/* has insns that work with the arena base, see bpf_prog_has_arena_insns() */
 	bool uses_arena_insns;
@@ -1962,6 +1971,8 @@ struct bpf_prog_aux {
 	const char *attach_func_name;
 	struct bpf_prog **func;
 	struct bpf_prog_aux *main_prog_aux;
+	/* frames of recursive subprogs on this cpu, see bpf_insert_recursion_checks() */
+	struct bpf_recursion_budget __percpu *call_depth;
 	/* main prog: there when a subprog has may_goto */
 	struct bpf_may_goto_budget __percpu *may_goto_budget;
 	void *jit_data; /* JIT specific data. arch dependent */
@@ -3464,6 +3475,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
 void bpf_prog_begin_run(const struct bpf_prog *prog);
+u64 bpf_prog_report_recursion(void);
 u64 bpf_prog_report_unwound(u64 ret);
 
 static __always_inline u32
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 31b1fa866e49..16987fa282b3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -812,6 +812,7 @@ struct bpf_insn_aux_data {
 	u64 guard_at_header:1; /* there is no better place than the head of the loop */
 	u64 guard_unwind:1; /* the subprog unwinds when may_goto is out of budget */
 	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
+	u64 recursion_bail:1; /* the first insn of the way out, bpf_insert_recursion_reports() */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -999,6 +1000,7 @@ struct bpf_subprog_info {
 	bool has_tail_call: 1;
 	bool might_throw: 1;
 	bool can_unwind: 1; /* has unwind_exit */
+	bool recursive: 1; /* on a cycle of the call graph */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
 	bool is_cb: 1;
@@ -1027,6 +1029,7 @@ struct bpf_subprog_info {
 
 	enum priv_stack_mode priv_stack_mode;
 	struct bpf_subprog_arg_info args[MAX_BPF_FUNC_ARGS];
+	u32 recursion_weight; /* see bpf_insert_recursion_checks() */
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
 };
@@ -1463,9 +1466,11 @@ int bpf_states_join(struct bpf_verifier_env *env, struct bpf_verifier_state *dst
 void bpf_join_free(struct bpf_verifier_env *env);
 
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
+int bpf_insert_recursion_reports(struct bpf_verifier_env *env);
 int bpf_insert_unwound_reports(struct bpf_verifier_env *env);
 bool bpf_insn_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
+int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index bb0aeda9f9cc..19d8191053b9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -292,6 +292,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		kfree(fp->aux->poke_tab);
+		free_percpu(fp->aux->call_depth);
 		free_percpu(fp->aux->may_goto_budget);
 		kfree(fp->aux);
 	}
@@ -3640,6 +3641,32 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 #endif
 }
 
+/* Called by a recursive subprog that is out of budget, see bpf_insert_recursion_checks() */
+u64 bpf_prog_report_recursion(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+	bool many;
+
+	prog = bpf_prog_find_from_stack();
+	if (!prog)
+		return 0;
+	WRITE_ONCE(prog->aux->unwound, true);
+	this_cpu_write(prog->aux->call_depth->reported, 1);
+	many = this_cpu_read(prog->aux->call_depth->calls) >= BPF_MAX_LOOPS;
+	/* the loops of the run come to an end as well */
+	if (prog->aux->may_goto_budget)
+		this_cpu_write(prog->aux->may_goto_budget->count, 0);
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, many ? "ERROR: Too many calls of recursive functions\n" :
+				  "ERROR: No room in the stack for a call of a recursive function\n");
+		bpf_stream_dump_stack(ss);
+	}));
+#endif
+	return 0;
+}
+
 /*
  * Nothing caught the unwinding. The prog or the async callback returns to the kernel.
  * There is no return value that is right for every hook, so what to do about it is up
@@ -3677,6 +3704,10 @@ void bpf_prog_begin_run(const struct bpf_prog *prog)
 		this_cpu_write(aux->may_goto_budget->start, 0);
 		this_cpu_write(aux->may_goto_budget->count, BPF_MAX_TIMED_LOOPS);
 	}
+	if (aux->call_depth) {
+		this_cpu_write(aux->call_depth->calls, 0);
+		this_cpu_write(aux->call_depth->reported, 0);
+	}
 }
 
 static struct bpf_may_goto_budget *bpf_may_goto_budget(void)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 937274c164e8..4a0b55c5fe35 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -647,6 +647,268 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
 	return 0;
 }
 
+/*
+ * The room that the frame of a subprog takes besides its stack: what JIT saves at most.
+ * arm64: FP, LR, 8 registers, the tail call count: 96. loongarch: 96, riscv: 80.
+ * powerpc: 112 with ELF ABI v2, 192 with v1.
+ */
+#define BPF_FRAME_OVERHEAD	(IS_ENABLED(CONFIG_PPC64) ? 192 : 96)
+
+/* the room for the frames of recursive subprogs */
+#define BPF_RECURSION_STACK	4096
+/* the frames of the helper or the kfunc that is between a callback and its caller */
+#define BPF_CALLBACK_OVERHEAD	256
+
+static u32 recursive_frame_size(struct bpf_verifier_env *env, int s)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	struct bpf_insn *insn = env->prog->insnsi;
+	u32 size, used = 0, may_goto = 0, cb = sub->is_cb ? BPF_CALLBACK_OVERHEAD : 0;
+	int i;
+
+	/* may_goto is yet to add its 16 bytes */
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return round_up(sub->stack_depth + 16, 32) + BPF_FRAME_OVERHEAD + cb +
+		       sub->max_out_stack_arg_cnt * BPF_REG_SIZE;
+
+	for (i = sub->start; i < (sub + 1)->start; i++) {
+		if (insn[i].dst_reg >= BPF_REG_6 && insn[i].dst_reg <= BPF_REG_9)
+			used |= BIT(insn[i].dst_reg);
+		if (insn[i].src_reg >= BPF_REG_6 && insn[i].src_reg <= BPF_REG_9)
+			used |= BIT(insn[i].src_reg);
+		if (bpf_is_may_goto_insn(&insn[i]))
+			may_goto = 16;
+	}
+	/* the return address, rbp, the registers that are saved */
+	size = 16 + hweight32(used) * 8;
+	/* the base of arena, the slot for r12 */
+	if (env->prog->aux->arena)
+		size += 16;
+	/* the tail call count and the pointer to it */
+	if (sub->tail_call_reachable)
+		size += 16;
+	return size + cb + round_up(sub->stack_depth + may_goto, 8) +
+	       sub->max_out_stack_arg_cnt * BPF_REG_SIZE;
+}
+
+/* what the frames of recursive subprogs add up to at most */
+#define BPF_RECURSION_UNITS	65536
+
+/*
+ * How deep a recursion goes is not known, so it is counted at run time. In the same
+ * spirit as may_goto: the program goes on for as long as there is budget and
+ * takes a way out that was verified when there is none.
+ *
+ * Every subprog on a cycle of the call graph adds its weight to a per-cpu
+ * counter of the program when it is entered and takes it back at every exit.
+ * The weight is the part of the budget that its frame takes: of the stack
+ * room, or of the room in the stack in arena, whichever is larger. So these
+ * frames take no more than BPF_RECURSION_STACK, on top of the chain of calls
+ * without recursion that check_max_stack_depth() looked at.
+ *
+ * A subprog that calls itself twice doesn't have to go deep to go on forever. So
+ * the calls are counted too: BPF_MAX_LOOPS of them in a run of the prog, like the
+ * callbacks of bpf_loop(). Once they are used up every call returns at once, and
+ * the frames that are there come to an end.
+ *
+ * Another run of the program on the same cpu, in interrupt or after
+ * preemption, counts in the same counter. Then there is less for both.
+ */
+int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	u32 frame, min_frame = U32_MAX, arena_frame = 0, arena_room = 0, weight;
+	u32 limit = BPF_RECURSION_STACK;
+	struct bpf_insn buf[24], first;
+	struct bpf_prog *new_prog;
+	struct bpf_recursion_budget __percpu *depth;
+	/* Only this cpu touches the counters */
+	int fetch_add = BPF_ADD | BPF_FETCH |
+			(bpf_jit_supports_local_atomics() ? BPF_ATOMIC_LOCAL : 0);
+	int i, s, n, bail, bail_len, err;
+
+	for (s = 0; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		frame = recursive_frame_size(env, s);
+		si[s].recursion_weight = DIV_ROUND_UP(frame * BPF_RECURSION_UNITS, limit);
+		min_frame = min(min_frame, frame);
+		arena_frame = max(arena_frame, si[s].arena_stack_depth);
+	}
+	if (min_frame == U32_MAX)
+		return 0;
+	if (arena_frame) {
+		/*
+		 * One more frame is for the subprog that finds that there is no
+		 * budget: it has its frame by then.
+		 */
+		u32 room = BPF_ARENA_STACK_MAX - env->max_arena_stack_depth;
+
+		if (room < 2 * arena_frame) {
+			verbose(env, "no room in the stack in arena for recursion\n");
+			return -EACCES;
+		}
+		/* no more than the frames that fit in the stack can take */
+		arena_room = min(room - arena_frame, limit / min_frame * arena_frame);
+		env->max_arena_stack_depth += arena_room + arena_frame;
+	}
+	for (s = 0; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		if (si[s].arena_stack_depth)
+			si[s].recursion_weight = max(si[s].recursion_weight,
+						     DIV_ROUND_UP(si[s].arena_stack_depth *
+								  BPF_RECURSION_UNITS, arena_room));
+		if (si[s].recursion_weight > BPF_RECURSION_UNITS) {
+			verbose(env, "the frame of recursive %s() is too large\n",
+				bpf_subprog_name(env, s));
+			return -EACCES;
+		}
+	}
+
+	depth = alloc_percpu_gfp(struct bpf_recursion_budget, GFP_KERNEL_ACCOUNT);
+	if (!depth)
+		return -ENOMEM;
+	env->prog->aux->call_depth = depth;
+	env->prog->jit_required = 1;
+
+	/* From the last one, so that nothing moves in those that are yet to be done. */
+	for (s = env->subprog_cnt - 1; s > 0; s--) {
+		if (!si[s].recursive)
+			continue;
+		/*
+		 * R0 has nothing at the entry. The address is not for AX:
+		 * blinding of constants takes ld_imm64 apart with the help of
+		 * AX. It leaves alone the insns that have AX in them.
+		 */
+		n = 0;
+		first = env->prog->insnsi[si[s].start];
+		/* The exit drops the frame in the stack in arena. Take it before the check. */
+		if (is_arena_sp_adj(&first)) {
+			buf[n++] = first;
+			first = BPF_JMP_A(0);
+		}
+		memcpy(buf + n, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
+		       2 * sizeof(buf[0]));
+		n += 2;
+		buf[n++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+		weight = si[s].recursion_weight;
+		bail_len = bpf_ret_reg_pair(env, s) ? 3 : 2;
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, weight);
+		buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_0, BPF_REG_AX,
+					 offsetof(struct bpf_recursion_budget, depth));
+		buf[n++] = BPF_JMP_IMM(BPF_JGT, BPF_REG_AX, BPF_RECURSION_UNITS - weight, 3);
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, 1);
+		buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_0, BPF_REG_AX,
+					 offsetof(struct bpf_recursion_budget, calls));
+		buf[n++] = BPF_JMP_IMM(BPF_JLT, BPF_REG_AX, BPF_MAX_LOOPS, bail_len);
+		bail = n;
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		if (bpf_ret_reg_pair(env, s))
+			buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+		buf[n++] = budget_exit_insn(env, &si[s]);
+		buf[n] = first;
+		err = bpf_adj_moved_insn(&buf[n], n);
+		if (err) {
+			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+				env->insn_aux_data[si[s].start].orig_idx);
+			return err;
+		}
+		n++;
+		new_prog = __bpf_patch_insn_data(env, si[s].start, buf, n, BPF_PATCH_MOVE_TARGET);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		env->insn_aux_data[si[s].start + bail].recursion_bail = true;
+		/* calls get to the check, jumps to the first insn do not */
+		err = adjust_jmp_off(env->prog, si[s].start, n - 1);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * The calls are counted anew when a run begins. For async callbacks see
+	 * bpf_prog_begin_run(). R0 has nothing at the entry.
+	 */
+	memcpy(buf, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_0, (long)depth) },
+	       2 * sizeof(buf[0]));
+	buf[2] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+	/* calls and reported */
+	buf[3] = BPF_ST_MEM(BPF_DW, BPF_REG_0, 0, 0);
+	buf[4] = env->prog->insnsi[0];
+	err = bpf_adj_moved_insn(&buf[4], 4);
+	if (err) {
+		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+			env->insn_aux_data[0].orig_idx);
+		return err;
+	}
+	new_prog = __bpf_patch_insn_data(env, 0, buf, 5, BPF_PATCH_MOVE_TARGET);
+	if (!new_prog)
+		return -ENOMEM;
+	env->prog = new_prog;
+	/* a jump to the first insn doesn't begin a run */
+	err = adjust_jmp_off(env->prog, 0, 4);
+	if (err)
+		return err;
+
+	/* R1 is nothing to the caller. Jumps to exit get to what is added. */
+	for (i = 0; i < env->prog->len; i++) {
+		if (bpf_is_ldimm64(&env->prog->insnsi[i])) {
+			i++;
+			continue;
+		}
+		if (env->prog->insnsi[i].code != (BPF_JMP | BPF_EXIT) ||
+		    !bpf_find_containing_subprog(env, i)->recursive)
+			continue;
+		n = 0;
+		memcpy(buf, (struct bpf_insn[]){ BPF_LD_IMM64(BPF_REG_1, (long)depth) },
+		       2 * sizeof(buf[0]));
+		n += 2;
+		buf[n++] = BPF_MOV64_PERCPU_REG(BPF_REG_1, BPF_REG_1);
+		weight = bpf_find_containing_subprog(env, i)->recursion_weight;
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_AX, -(int)weight);
+		buf[n++] = BPF_ATOMIC_OP(BPF_W, fetch_add, BPF_REG_1, BPF_REG_AX,
+					 offsetof(struct bpf_recursion_budget, depth));
+		buf[n++] = env->prog->insnsi[i];
+		new_prog = bpf_patch_insn_data(env, i, buf, n);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		i += n - 1;
+	}
+	return 0;
+}
+
+/*
+ * Say so when a recursive subprog is out of budget, once in a run: from then on every call
+ * comes here. R0 is what bpf_insert_recursion_checks() left in it. The arguments are not
+ * needed any more.
+ * It's done after bpf_do_misc_fixups(), that takes a call for a call of a helper.
+ */
+int bpf_insert_recursion_reports(struct bpf_verifier_env *env)
+{
+	struct bpf_prog *new_prog;
+	struct bpf_insn buf[4];
+	int i;
+
+	for (i = 0; i < env->prog->len; i++) {
+		if (!env->insn_aux_data[i].recursion_bail)
+			continue;
+		env->insn_aux_data[i].recursion_bail = false;
+		buf[0] = BPF_LDX_MEM(BPF_W, BPF_REG_AX, BPF_REG_0,
+				     offsetof(struct bpf_recursion_budget, reported));
+		buf[1] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
+		buf[2] = BPF_EMIT_CALL(bpf_prog_report_recursion);
+		buf[3] = env->prog->insnsi[i];
+		new_prog = bpf_patch_insn_data(env, i, buf, 4);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		i += 3;
+	}
+	return 0;
+}
+
 /*
  * Say so when the main prog unwinds. JITs make exit of that, see bpf_prog_can_unwind().
  * It's done after bpf_do_misc_fixups(), that takes a call for a call of a helper.
@@ -1936,6 +2198,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		func[i]->aux->can_unwind = env->subprog_info[i].can_unwind;
+		func[i]->aux->recursive = env->subprog_info[i].recursion_weight;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cd960f65093d..45e85e7d54bf 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3403,6 +3403,7 @@ struct bpf_throw_ctx {
 	u64 sp;
 	u64 bp;
 	int cnt;
+	u32 recursive;
 };
 
 static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
@@ -3421,6 +3422,7 @@ static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 	if (!prog)
 		return !ctx->cnt;
 	ctx->cnt++;
+	ctx->recursive += prog->aux->recursive;
 	if (bpf_is_subprog(prog))
 		return true;
 	ctx->aux = prog->aux;
@@ -3439,6 +3441,12 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 		WARN_ON_ONCE(!ctx.aux->exception_boundary);
 	WARN_ON_ONCE(!ctx.bp);
 	WARN_ON_ONCE(!ctx.cnt);
+	/*
+	 * The frames that go away do not get to their exits. Only these: another
+	 * run of the program may be in the middle of its recursion on this cpu.
+	 */
+	if (ctx.aux && ctx.recursive)
+		this_cpu_sub(ctx.aux->main_prog_aux->call_depth->depth, ctx.recursive);
 	/*
 	 * Prevent KASAN false positives for CONFIG_KASAN_STACK by unpoisoning
 	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c3fac4586c92..a9628f5045fe 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22925,6 +22925,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Only fentry can attach to %s, which can unwind\n", tname);
 			return -EINVAL;
 		}
+		/*
+		 * A trampoline that calls the target stays on the stack at every level.
+		 * The check of the stack in the target does not count it.
+		 */
+		if (aux->func && aux->func[subprog]->aux->recursive && !prog_extension &&
+		    prog->expected_attach_type != BPF_TRACE_FENTRY) {
+			bpf_log(log, "Only fentry can attach to %s, which is recursive\n", tname);
+			return -EINVAL;
+		}
 		conservative = aux->func_info_aux[subprog].unreliable;
 		if (prog_extension) {
 			if (aux->func_info_aux[subprog].linkage != BTF_FUNC_GLOBAL ||
@@ -24415,6 +24424,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
 
+	/* after what makes frames larger: inlined bpf_loop() takes 3 slots and 3 registers */
+	if (ret == 0)
+		ret = bpf_insert_recursion_checks(env);
+
 	if (ret == 0)
 		bpf_lower_cast_mov(env);
 
@@ -24437,6 +24450,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_do_misc_fixups(env);
 
+	if (ret == 0)
+		ret = bpf_insert_recursion_reports(env);
+
 	if (ret == 0)
 		ret = bpf_insert_unwound_reports(env);
 
-- 
2.55.0

