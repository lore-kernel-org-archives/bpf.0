Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911528;
	b=HhsEdxdlHBxyh2oeccO9oTaSHppML0aQs9A2BVL64Mc2s6gFzCAGeUclZBHiOx4rOSfd
	 ElJiAC9FA0/Z04bgJs781O6kYuLwVV/rQN5Ydyvm+y4/BXelFm9JS0QiltoaMWhojITkI
	 fGfF49M8SlZ6Jst70na+Ez/RRrIPk2fq/4tW7H1bdIhXi9wOtfSe/52NVguxiPFF/e/nw
	 bnXR/XibidcZkO+4+SAh14U/8lYgouTvRPquUWPA/iX1SnSeazoXKCpx6fiLAeQ8/HQNb
	 KG8NAw19DIixEwe9ocxvsqJOEatCG2SWF5yeV9ADsm+9G6s6pIybrfpnqtd9twPWuYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9uTsKdbRM4xnraxWNgkkeCHoTM/PEbk52fFdHKniFGQ=;
	b=lsQttOYIie0g1MRq+XFa0vl3up52pwxqSyIgrkAD2b8YgVcPYGNXndTscsvdERBcXb/Y
	 AWteIlkCNoUmuAlUtyNR0qzMq8ajWMeEpjdk45lGcnGmoPKxFw6YldZotgu5yBdH6PhW0
	 PZuqUPDYUSX7N2wcfWDacrn0Y8H20r1yJn1pnOLsCYmJ3xHG+WY9nZ7dH+foYC2/DLN05
	 E9JmF6UYZ6q3jv+PX3z/Sbhkukmo0lJbPiFbRfVvB7uYhRc3XiIRqnLV9QTsuovi3lLQL
	 CTRrUmh37UnRkI45mSDF/U03lQJyf5U9cxE6h0YQjT5dDEaRku50cqHMg1FqSfexPlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZjkRmf8;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366CC606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 20:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366CC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kZjkRmf8
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb45e96d2bso924410a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 12:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911527; x=1794516327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uTsKdbRM4xnraxWNgkkeCHoTM/PEbk52fFdHKniFGQ=;
        b=kZjkRmf8I/05vkrIVq0/hy7AwJ/qOmFvKu3rs1q1729NwEVICMoyjmhdt5oyOjdbM0
         rNoKntHMq7492nhgAo6AUD1W0bLm9cBPVHo7eWppDBv6SnXdk+6b7x2YIRKTjHBl18T6
         4jHu5DX7rXl3xsIeTxGIngneD79JUXsGsLwIM7o3Ne01NZB3yAii/LauJBdu1e0wJ8f1
         rBHWcX4Nskdy5fpZaCf9vz4JDLgoOaGT9bOKYmmT8C1g3M2K9nXyjKp4csKqWRNpozFB
         +GyJYUgIEJtIBK7vkwUjTlnsMhMOgMCDCVDq2X3RzcwSzpnSUmqRU+eLozi9vwzvDbHG
         ETsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911527; x=1794516327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uTsKdbRM4xnraxWNgkkeCHoTM/PEbk52fFdHKniFGQ=;
        b=YpK6muVV7vM4a4hemgJcrvi3csM23+4o3A9h0wiZG6iDeObShe3YjYrWcsWEMoGyx7
         dCw1wSJj6XuZCsHISPIVT8oSsTxqgR6cmIwtwIrFiRMIH/2oSUlOX1rEFpTd10XCdNLK
         ZZ3ID0qwFrFLhK3O6ZrR8JBbeOLrK+OQWu/SekzWZ2kSFN6UskG8QPJPYhF4E4qGdyf7
         WIzFbY/cVOLOgiCg902ZuiaNpdQM07bkwLb/C1zgmzQIGtBOmhz4dHP39TvRN7aNLcit
         BpSZG9NL6s7mXBwreLdNNR5Jp/47K4PHuOfLmxnL844UMRKu3cyU/vkgSx/0L4D0Cahl
         MnoQ==
X-Gm-Message-State: APuU4Z8n3JstXpANcDDwwsx9FTO2k1AhTfgu4WgeY+8P6VIvXn3R4eeW
	dTrmDP3hdSAyDBbTrhLcavhFEEtD549lHJH42aMj/iNkvt0zCibVw5FcmyajvA==
X-Gm-Gg: AYBFou1DmH7RQ8ptnkZuTVfjZ8O0YFJx8fcGklF2SPZoJWX9AW04Bj2kMj9hsNKdapb
	7JiKvvBcYqHLdOFTJOr9Qm8xVRTZM8wGOepB1FnkPQKSpjEsOlsNMU5Ivf2e1gpSLX1KY6iYv3j
	s0t2/rS39lieSfCxiKN3PTL4+XbX+vjJGrYiMfFCxUL/160yJGHbofNDg8FbrfjAqM0pOcoR+Hu
	WZ6vUBz9ucjQ6CILEsTaIm8tYpmPyM4iaJynlywFzZ0jNgmukzS0I7Apjs47gWUD7+/S832xQmN
	rDk0SYucnwHdJriBtvnq0ap9skHVM3ZiDPKwddoCiuJxH+YjkNsJEV7T0ibDIhuLWSWzRJ1n+62
	xaGdAUkE9d/4+wXVWfINkl0QYIcURgkBKRhYSmukX3a7yu5EUXkpCOtvXIEarrHwlZz5cfI5syq
	VSK2J95HxD6F5K2mQUJnBb6vZFweX3Kq14vl8v/58NXXrunC7YIrEErITV2THAc+gbQ9jCRj17r
	uk/wrGdIP/7PMlMpiLsOD6RUPD6LfJ7INEYmPjSr0sLBS9IqIoaA9tdFsTFywQY5fQmch3dTLZN
	t5dCUYA8PtR8XCDt/vyeboQw1n4WGx5mypBmik3FYhACCetQZ415+Ohvrsj8WIOX2rl51mQEyT2
	NKz5x7lqDv9dPGd4l27fBn0jfcF/d9w7+Az1euv+OXfOEyCtQgQ/dNY0LPtZov2FWZIZgc1z2tH
	E=
X-Received: by 2002:a17:90a:c10f:b0:3b0:96b4:ceb7 with SMTP id 98e67ed59e1d1-3b0db5f12famr223832a91.8.1793911527110;
        Thu, 05 Nov 2026 12:45:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969b35c7sm4598798a91.3.2026.11.05.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:45:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 02/35] bpf: Limit depth and time of recursive subprogs at run time
Date: Thu,  5 Nov 2026 20:44:39 +0000
Message-ID: <20261105204513.2230344-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-1-alexei.starovoitov@gmail.com>
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
that a half of that stack is full before the stack in arena.

No subprog is marked as recursive yet. A call runs 12 more insns on x86-64
(17 on the irq stack), 8 on arm64: +0.2 to +0.5 nsec on x86-64.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h          |   2 +
 include/linux/bpf_verifier.h |   3 +
 include/linux/filter.h       |  16 ++++
 kernel/bpf/core.c            |  19 +++++
 kernel/bpf/fixups.c          | 141 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   3 +
 6 files changed, 184 insertions(+)

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
index 6fd79c2fbdc1..7ccbff51be7f 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -806,6 +806,146 @@ int bpf_insert_loop_guards(struct bpf_verifier_env *env)
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
+	u32 arena_frame = 0, room = 0, frame;
+	bool found = false;
+	int s, n, jmp, err;
+
+	for (s = 1; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		found = true;
+		arena_frame = max(arena_frame, si[s].arena_stack_depth);
+	}
+	if (!found)
+		return 0;
+	env->prog->jit_required = 1;
+
+	/*
+	 * The stack in arena has no check of its own. A frame takes at least the same part of
+	 * a half of the kernel stack as of the room in the stack in arena: there is room in
+	 * arena for the frames that pass the check. The last of them and the one that
+	 * doesn't pass come on top.
+	 */
+	if (arena_frame) {
+		room = BPF_ARENA_STACK_MAX - env->max_arena_stack_depth;
+		if (room <= 2 * arena_frame) {
+			verbose(env, "no room in the stack in arena for recursion\n");
+			return -EACCES;
+		}
+		room -= 2 * arena_frame;
+		env->max_arena_stack_depth = BPF_ARENA_STACK_MAX;
+	}
+	for (s = 1; s < env->subprog_cnt; s++) {
+		if (!si[s].recursive)
+			continue;
+		if (si[s].arena_stack_depth) {
+			frame = DIV_ROUND_UP(si[s].arena_stack_depth * (THREAD_SIZE / 2), room);
+			if (frame > env->stack_limit) {
+				verbose(env, "no room in the stack in arena for recursion\n");
+				return -EACCES;
+			}
+			si[s].stack_depth = max(si[s].stack_depth, frame);
+		}
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
@@ -1878,6 +2018,7 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->changes_pkt_data = env->subprog_info[i].changes_pkt_data;
 		func[i]->aux->might_sleep = env->subprog_info[i].might_sleep;
 		func[i]->aux->can_unwind = env->subprog_info[i].can_unwind;
+		func[i]->aux->in_recursion = env->subprog_info[i].in_recursion;
 		func[i]->aux->token = prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary = env->seen_exception;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8525330b11e8..08140ac6e624 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24669,6 +24669,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0)
 		ret = bpf_optimize_bpf_loop(env);
 
+	if (ret == 0)
+		ret = bpf_insert_recursion_checks(env);
+
 	if (ret == 0)
 		bpf_lower_cast_mov(env);
 
-- 
2.55.0

