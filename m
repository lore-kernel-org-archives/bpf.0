Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022694;
	b=R3tRTdyeXccuOuTtJovnFqLfvuwr8ZJU1/k9gGOv8gJhK51idlO2R1+MGnpAl3eLtU9s
	 MgrUGLpWQe0gt1iu+nP5wkDl07p4EZBdG9csmiBqbhjq9jgwyRjQFQqyHnXQFN8v8k9Rw
	 CLu7Dvf1N+IRDWBx7cyg3UDyep4FsAYiSQD/MEV7X5ByMIUdCQJJI43RqIv44mbyBW95S
	 PwerXomaiYkWG7O6++C4fJaIhq0eUTwgC5da7SKIWMBu/zPlPufTUQLVyF0zR22oaalLz
	 q45fx063ugEPI/CvFokWGrOda2czcRFdmUufKvxpuRiP+E0dyTfyVOmbWgLSuQVBw7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sxWuRoxBLNSs8RmDK6ssrgW79QF3acSGzgnJZqwjxqg=;
	b=MSFd5D0KNkBWarygUAza8Qhgs5xUP79Tbb6IHiY5a2adZxdeFlPSk1O1LoyQWclotELu
	 1hbgsIwjsfqS2WrCiehWXCVx15FTagF8Cl+1mOZTOpEqvtVah8vYyhDq87C+Q38JMQ48L
	 w3ItiX6UMfeWeMkVPYESNTVW2sNYxsWPTrGOvJ9wDDhWajOt956h4A8BfmjmUMAdIUP5d
	 DbZXXrc42n50PqUEPUov8wjP+q6ANhJWgUyzGrW9h//NbjBNMP9UyVL5ghQFt1MzOrAJA
	 dyLTJC5YLiQR73Kd60gOp8IQG4O1lKkBK5UbQ5DAFSa4x4eCAuiS93xx0lGykMXIJXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Gnmb/TX1";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7FA606A334
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB7FA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gnmb/TX1
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed1414df17so4865425ad.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022693; x=1794627493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxWuRoxBLNSs8RmDK6ssrgW79QF3acSGzgnJZqwjxqg=;
        b=Gnmb/TX1o+r9iOMVJEDYGFQAQEyDaY4Dd6g5+HvNV1XLJwykpZ9sQ9TU9gJsqVy3aX
         IuvAmBbKwzVuHX4DEaRRj8abE6zuM541k56ld1lyljmQLxf1Fsaf1i7wAAm3wOhtWMRr
         g42eZu/6qTw5ba9Qm+2T9PzJPD6DXnDY73ccoaRMxKV/I31rKjiIvEBLvvs5mbcS3u2i
         EZsGsTC8mYYEauBkhl4mMmDlRRhUn+F5omgzIWTAOguAPn7JG+ZoTaaJibpkb/k1XU9K
         9wWn1B8AJB3+QpgkdkBw0IODoiX83dbDP5zUzQ2UKHDFcLcpJGt0Eb4T1KHc9rnolR9S
         VTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022693; x=1794627493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxWuRoxBLNSs8RmDK6ssrgW79QF3acSGzgnJZqwjxqg=;
        b=bvXuHh/G/XKwsH3433HB34Ok3ujYa7K8Ue+8TqPrnRJN+5XFSBhh+t7+lgt1jQqtXu
         2GJDedKyI/AC9WlQPx1DZ07X9/XoNsDd3Wipqd+KeE2OLBk3toU2z/DWQUZtNWAtRqKf
         aZ/90pi9tToIhSEwngNrBQbeZHYDGk5tzL5pGo3due3qhSEUBE8ypuHGekCe+519uaQ5
         nkCh7yFA7xzSY+RHw4MpNcKSxlLvFlq9H8qGJrazn0IO0MoZ38eqiHMrDtOwLJEkrFMC
         6nHGD6BHv93ck1WUI4GBYHyAfcjGegwgrNexrzqMOi9OZB0LCIIVsCO5huyrqlc27PgA
         N6uw==
X-Gm-Message-State: APuU4Z+QgRgKh24fhUK5Bg/nKSZfrbO/cdV7WbkSJRfXpJ9uh2lt5um/
	/JyDyR+7MEKLcEPnnpIi1OVAVk2ZDyJo7fNmqa0all/o/S2EguAHElXfASmt2w==
X-Gm-Gg: AYBFou2aerhRjEDutNZGBIXY4Y0kDu9YZ/7fGw7+8HfgShg0a0h/62B233jSLn46/+H
	GwyqJna7bpI4caMf6dFz2/cVxGlz3aQMKc18eOLzuul9etigotgXwyrtIVWO2EMwuTq60o5CVO4
	tS698+4niaJcfYgAy2H73/2TLwZhtmsq0s2IcaAIXXJTAFXuUHwPK1x5iwXKLU2MbnbxfTaWWaS
	3B8WKGR2KXQM2xd+pHj0bd/DvvzTbIR9MuxoK4vtSp4YWw4I44R/0J24G3hxXqdD9TS6JPVa71l
	RB1b6b5PzyWcCUVZYmEcLYlUkeUe2Le8FVy7rCQH444zb8vbgi9Au/kstmNfJwAaCm57Mh8zXLY
	7dtPhvhwj/10WbqSc7Jv5DCawTBmGBtKtXl7lhZG/02PiJij3g0asRZVh7YqmqxcFAadWtO83Mk
	OUOvadSkuOYIoYPvYYa1zv2v3OaThisDLoXiexNybYsVc5A1Eub1reJSvTVuBRJGP0I0Vyd692k
	kc2aNcYPZtCxgymBNa2n+ofqIk/27KZ1X0nvCqE5v/whDCTUSxLGgaA52bLffYkkL44zckZySMq
	CknwMNsihUWIjP3Os9tV/rpMNVUdN2re+cI7u4mLeDpDzeugF4FSJhcWp5pKyzdppPYkCP2umER
	0FHCCQ0GG7VzS1qH6tnzypTWsnNiZGmlkhsm1/QejDu4iT31LmSNecb273dZHDznBdukBFYmzcw
	==
X-Received: by 2002:a17:902:fc8d:b0:2e9:740c:36c with SMTP id d9443c01a7336-2ed40dcd41amr52095645ad.41.1794022692982;
        Fri, 06 Nov 2026 19:38:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed477a7c52sm10173675ad.20.2026.11.06.19.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 02/46] bpf: Limit depth and time of recursive subprogs at run time
Date: Sat,  7 Nov 2026 03:37:10 +0000
Message-ID: <20261107033758.1547725-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
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

Rust recurses where C has a loop. scx_flatcg.rs of rust-bpf has

  struct CgrpCtx { parent: Option<Arc<CgrpCtx>>, ... }

The drop of the last Arc of a cgroup drops the Arc of its parent:
Arc::drop_slow() calls itself, and 8 of the 15 progs are rejected:
"recursive call from drop_slow<..>() to drop_slow<..>()". quicksort() under
sort_unstable_by() in scx_rusty.rs, BTreeMap, serde_json and regex-automata
recurse too: 100 of the 225 progs of the schedulers of rust-bpf, 100 of its
437 tests. The verifier cannot know how deep the calls go, or how many
there are.

Limit both at run time. Each subprog on a cycle of the call graph starts
with two checks:

  entry:  may_goto bail                                 limits the time
          if (r10 is in the upper half of the stack)    limits the depth
                  goto body
          bpf_prog_report_recursion()
  bail:   r0 = 0; exit
  body:   ...

Both are needed. The depth does not limit the time:

  int fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }

fib(90) is never deeper than 90 frames and makes 10^19 calls. There is no
loop in it, so no may_goto of a loop bounds it. The cycle is in the call
graph, and it goes through the first insn of fib(). With may_goto there
fib(90) ends after 250 ms, the time slice that the loops and recursions of
an invocation share. The time does not limit the depth:
'int f(int n) { return f(n + 1) + 1; }' is out of stack in less than 1 ms.

r10 is an address in the kernel stack that the prog runs on. Thus the check
sees all that is in this stack, not only the frames of this prog, without
per-cpu state. On arm64 a stack is aligned to its size: one bit of r10
tells the half. On x86-64 r10 is compared with the tops of the task stack
and the irq stack. In any other stack, like in an NMI that interrupts the
kernel, the check fails. Other archs get no recursion. The stack in arena
has no check: the verifier makes the frame in the kernel stack so large
that a half of that stack is full before the stack in arena. It does so in
check_call_depth(): the limit on the stack of a chain of calls has to see
the frames that the JIT gets.

No subprog is marked as recursive yet. A call runs 12 more insns on x86-64
(17 on the irq stack), 8 on arm64: +0.2 to +0.5 nsec on x86-64.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |   3 +
 include/linux/filter.h       |  16 +++++
 kernel/bpf/core.c            |  19 ++++++
 kernel/bpf/fixups.c          | 113 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |  49 +++++++++++++++
 6 files changed, 202 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b011acc22c50..cdf3c9b90987 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1944,6 +1944,8 @@ struct bpf_prog_aux {
 	bool has_prologue;
 	bool might_sleep;
 	bool can_unwind;
+	/* frames of recursive subprogs can be on the stack when it is called */
+	bool in_recursion;
 	bool kprobe_write_ctx;
 	/* has insns that work with the arena base, see bpf_prog_has_arena_insns() */
 	bool uses_arena_insns;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7e268540dae9..2f935061b8fd 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -995,6 +995,8 @@ struct bpf_subprog_info {
 	bool has_tail_call: 1;
 	bool might_throw: 1;
 	bool can_unwind: 1; /* has unwind_exit */
+	bool recursive: 1; /* on a cycle of the call graph */
+	bool in_recursion: 1; /* recursive, or a recursive subprog gets to it */
 	bool via_callx: 1; /* callx calls it */
 	bool tail_call_reachable: 1;
 	bool has_ld_abs: 1;
@@ -1532,6 +1534,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
 int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
+int bpf_insert_recursion_checks(struct bpf_verifier_env *env);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
 int bpf_update_branch_counts(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a58ad2318412..61448be53f8d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1401,6 +1401,21 @@ bool bpf_jit_supports_large_stack(void);
 bool bpf_jit_supports_timed_may_goto(void);
 bool bpf_jit_supports_fsession(void);
 
+/*
+ * Whether a recursion in @prog can be limited at run time:
+ *  - r10 tells how much of the kernel stack is used, on the architectures whose stacks
+ *    emit_stack_check() knows.
+ *  - All may_goto of the prog share one time slice. That is the timed form, which only JITed
+ *    progs get, see bpf_do_misc_fixups(). The other form counts in each frame.
+ *  - A walk of the stack finds the prog when there is no room, to tell user space, see
+ *    bpf_prog_report_recursion().
+ */
+static inline bool bpf_prog_has_invocation_budget(const struct bpf_prog *prog)
+{
+	return (IS_ENABLED(CONFIG_X86_64) || IS_ENABLED(CONFIG_ARM64)) && prog->jit_requested &&
+	       bpf_jit_supports_timed_may_goto() && bpf_jit_supports_exceptions();
+}
+
 struct bpf_jit_arg_abi {
 	/* Argument registers of the kernel convention. */
 	u8 nr_arg_regs;
@@ -1438,6 +1453,7 @@ u64 arch_bpf_timed_may_goto(void);
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
 void bpf_timed_may_goto_save(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
 void bpf_timed_may_goto_restore(const struct bpf_prog *prog, struct bpf_timed_may_goto *saved);
+u64 bpf_prog_report_recursion(void);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 8e2fb66940c7..f88a1c041a7a 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3956,6 +3956,25 @@ static noinline void bpf_prog_report_may_goto_violation(void)
 #endif
 }
 
+/* Called by a recursive subprog that finds no room, see bpf_insert_recursion_checks() */
+u64 bpf_prog_report_recursion(void)
+{
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	prog = bpf_prog_find_from_stack();
+	/* The calls that follow get here too. One report is enough until user space reads it. */
+	if (!prog || atomic_read(&prog->aux->stream[BPF_STDERR - 1]->capacity))
+		return 0;
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: No room in the stack for a call of a recursive function\n");
+		bpf_stream_dump_stack(ss);
+	}));
+#endif
+	return 0;
+}
+
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *p)
 {
 	u64 time = ktime_get_mono_fast_ns();
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6fd79c2fbdc1..3413c7addca8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -806,6 +806,118 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 	return err;
 }
 
+/*
+ * if (r10 is in the upper half of the kernel stack) goto +@off
+ *
+ * r10 of a subprog without a private stack is an address in the kernel stack that it runs on.
+ * arm64: the stacks of tasks, of interrupts and of SDEI events have THREAD_SIZE bytes and are
+ * aligned to twice that size. One bit of an address tells the half.
+ * x86-64: the stack for interrupts is aligned to a page only. But the cpu has the top of the stack
+ * of the task and the top of its stack for interrupts. In any other stack (NMI, #DB, #MC, #DF,
+ * #VC) the check fails: they have half of the size.
+ * R0 has nothing at the entry of a subprog.
+ */
+static int emit_stack_check(struct bpf_insn *buf, int off)
+{
+	int n = 0;
+
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
+	const void __percpu *top[] = { &cpu_current_top_of_stack, &hardirq_stack_ptr };
+	int i;
+
+	static_assert(IRQ_STACK_SIZE == THREAD_SIZE);
+	for (i = 0; i < 2; i++) {
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_0, (u32)(__force unsigned long)top[i]);
+		buf[n++] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
+		buf[n++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+		buf[n++] = BPF_ALU64_REG(BPF_SUB, BPF_REG_0, BPF_REG_10);
+		buf[n++] = BPF_JMP_IMM(BPF_JLT, BPF_REG_0, THREAD_SIZE / 2, i ? off : off + 5);
+	}
+#else
+	buf[n++] = BPF_JMP_IMM(BPF_JSET, BPF_REG_10, THREAD_SIZE / 2, off);
+#endif
+	return n;
+}
+
+/*
+ * How deep a recursion goes is not known, so it is limited at run time. In the same
+ * spirit as may_goto: the program goes on for as long as there is room and takes a way
+ * out that was verified when there is none.
+ *
+ * Every subprog on a cycle of the call graph begins with:
+ *
+ *	may_goto bail;
+ *	if (r10 is in the upper half of the kernel stack) goto body;
+ *	bpf_prog_report_recursion();
+ * bail:
+ *	r0 = 0;
+ *	exit;
+ * body:
+ *
+ * It is the stack as it is: whatever is there is counted, be it the callers of the prog in the
+ * kernel, another prog, a trampoline or a helper that calls a callback. An invocation in
+ * another stack has nothing to do with it.
+ *
+ * The lower half is for what is below r10: the frame of the subprog, then what it calls.
+ * That is the next recursive subprog, which doesn't get past its check, or a chain of calls that
+ * check_max_stack_depth() looked at together with that frame.
+ *
+ * A subprog that calls itself twice doesn't have to go deep to go on forever: hence may_goto.
+ * Once the time slice of the invocation is over every call returns at once, and the frames
+ * that are there come to an end.
+ */
+int bpf_insert_recursion_checks(struct bpf_verifier_env *env)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	struct bpf_insn buf[24], nop = BPF_JMP_A(0), *insn;
+	bool found = false;
+	int s, n, jmp, err;
+
+	for (s = 1; s < env->subprog_cnt; s++)
+		found |= si[s].recursive;
+	if (!found)
+		return 0;
+	env->prog->jit_required = 1;
+
+	for (s = 1; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		n = 0;
+		/* The exit drops the frame in the stack in arena. Take it before the check. */
+		if (is_arena_sp_adj(&env->prog->insnsi[si[s].start])) {
+			buf[n++] = env->prog->insnsi[si[s].start];
+			/* one insn for one: done at once, the list copies the nop */
+			insn = bpf_patch_list_add(env, si[s].start, &nop, 1);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
+		}
+		jmp = n++;
+		n += emit_stack_check(buf + n, bpf_ret_reg_pair(env, s) ? 4 : 3);
+		/* The arguments are not needed any more */
+		buf[n++] = BPF_EMIT_KERNEL_CALL(bpf_prog_report_recursion);
+		buf[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, n - jmp - 1, 0);
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+		if (bpf_ret_reg_pair(env, s))
+			buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+		buf[n++] = budget_exit_insn(env, &si[s]);
+		/* calls get to the check, jumps to the first insn do not */
+		err = bpf_patch_list_insert(env, si[s].start, buf, n);
+		if (err)
+			return err;
+	}
+	err = bpf_patch_list_commit(env);
+	if (err)
+		return err;
+	/* may_goto keeps the address of its count in a register that is dead: R0 */
+	for (s = 1; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		n = si[s].start + is_arena_sp_adj(&env->prog->insnsi[si[s].start]);
+		env->insn_aux_data[n].live_regs_before = (u16)~BIT(BPF_REG_0);
+	}
+	return 0;
+}
+
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -1878,6 +1990,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		func[i]->aux->can_unwind = env->subprog_info[i].can_unwind;
+		func[i]->aux->in_recursion = env->subprog_info[i].in_recursion;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb51f7f04153..c16a20ab664d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6112,6 +6112,47 @@ static void compute_call_depth(struct bpf_verifier_env *env, struct bpf_call_gra
 	} while (changed);
 }
 
+/*
+ * The stack in arena has no check of its own, see bpf_insert_recursion_checks(). A frame
+ * of a recursive subprog takes at least the same part of a half of the kernel stack as of the
+ * room in the stack in arena: there is room in arena for the frames that pass the check. The
+ * last of them and the one that doesn't pass come on top.
+ *
+ * Returns 1 when frames in the kernel stack grew.
+ */
+static int pad_recursive_frames(struct bpf_verifier_env *env, struct bpf_call_graph *cg,
+				struct bpf_subprog_call_depth_info *dinfo)
+{
+	struct bpf_subprog_info *si = env->subprog_info;
+	u32 arena_frame = 0, depth = 0, room, frame;
+	int s;
+
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		depth = max_t(u32, depth, dinfo[s].arena_depth + si[s].arena_stack_depth);
+		if (si[s].recursive)
+			arena_frame = max(arena_frame, si[s].arena_stack_depth);
+	}
+	if (!arena_frame)
+		return 0;
+	if (depth + 2 * arena_frame >= BPF_ARENA_STACK_MAX)
+		goto no_room;
+	room = BPF_ARENA_STACK_MAX - depth - 2 * arena_frame;
+	env->max_arena_stack_depth = BPF_ARENA_STACK_MAX;
+
+	for_each_set_bit(s, cg->live, cg->cnt) {
+		if (!si[s].recursive)
+			continue;
+		frame = DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room);
+		if (frame > env->stack_limit)
+			goto no_room;
+		si[s].stack_depth = max(si[s].stack_depth, frame);
+	}
+	return 1;
+no_room:
+	verbose(env, "no room in the stack in arena for recursion\n");
+	return -EACCES;
+}
+
 static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph *cg)
 {
 	struct bpf_subprog_info *si = env->subprog_info;
@@ -6122,6 +6163,11 @@ static int check_call_depth(struct bpf_verifier_env *env, struct bpf_call_graph
 	if (!dinfo)
 		return -ENOMEM;
 	compute_call_depth(env, cg, dinfo);
+	err = pad_recursive_frames(env, cg, dinfo);
+	if (err < 0)
+		goto out;
+	if (err)
+		compute_call_depth(env, cg, dinfo);
 
 	for_each_set_bit(s, cg->live, cg->cnt) {
 		/* A caller of it is over a limit. That one is reported, not what it calls. */
@@ -24696,6 +24742,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
 
+	if (ret == 0)
+		ret = bpf_insert_recursion_checks(env);
+
 	if (ret == 0)
 		bpf_lower_cast_mov(env);
 
-- 
2.55.0

