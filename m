Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022688;
	b=qchGNUt+gmbsqs/6GSwgVtgUtH6r+ihfIddd746H0L0vqxEVhTARqxCvkXF9iH/lFwLd
	 nqPxRkFwx807+KrP29vtbFmx1NnueLUxQrjVT5XiuYjd+KNEoBc2wrRCCz9kYYwhJfb6b
	 5Q3iXmYeXMchDHY+PEtN/tSJOrtbAyQWXgNWtb1YrnB5eZTKh3mKFxgSffr5XmnvAkl74
	 kc1+YUeqH7X25Gz/VSy0OTt+4nBKW/zu3eo4dRSKJ4zA5d5D3asPz0gq1gaWexZnab3PF
	 nAlbSfQrXRrFzMeJjICPR/xyQswV9C2eB5rK/XwMlfHw+T6AMMyOjMe8z4S8odCdhkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6zG0hBCn6ebz5GpxP8CjC9xSqQbF3yJW+y99aAlmGmo=;
	b=n8k8Xs9ikHyRmTJxdlQ0fB+a0Mkrgg1QUs/41xIG2G2gJ5Ocy5descVPAR/5ZPBNb9vy
	 WQX72W91Rhjrz+zwbinxL2e1AKg54/st7G6UuFg1KI/tzt72p1+5Samx6ftV707YKNmFd
	 /g2MRFl9A1cvobbTXkM0Rz+Ba8Ex19kZCZzkAwHENwNuvwWWTja17Y81vnWgXJaJOgwH3
	 3uf7sylF2Y1WJTOfbt92UUWd8pfAIf9ChMECN5MKyZYmRSj0RBpkongI4axEUHZr5e6fx
	 Tyj7qSkJGtc2Usl09gXQOW8teYmrQkXDAqiNW1+BmKWxXuJk0Zwa6eZMIW04FCa7e7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjX8XOEN;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D05606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9D05606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZjX8XOEN
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e987a2ba0cso7181035ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794022687; x=1794627487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zG0hBCn6ebz5GpxP8CjC9xSqQbF3yJW+y99aAlmGmo=;
        b=ZjX8XOENzkyE6H+OjANsyXeztc5rkKQf9CAFMSMrTjP4IqoJ5fPx0JfTy/BSyg05oC
         cd43pUfqHXcq4+gZHCEa6SttrYOno7o3eLqgyZKvTYxGSF0WqmXVRIUutlEAT+at20Xv
         BgDc/OzmhuFFEuLeDZq5DbfqYf0Y7ainmJWPPDWfph1Rka0kQIskfQCroQJikaoWcsZv
         0lM6+3TlMJlgKDFzT4I9YSRARzisAIETgn2n4/dR20m6I6K937I1bFYPsyx0HgSFGztF
         unn20eCHMcOSorfMl8KhqVkdPHlwaF4iUgqlvuvgT4syiCC11dHKjyNXtwT89hvTbgX9
         Sexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022687; x=1794627487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zG0hBCn6ebz5GpxP8CjC9xSqQbF3yJW+y99aAlmGmo=;
        b=jpNAVAgWmX0a0nf8CnCbvUpvKPlfZbEMSf7eJIZHO8G7WJBqq6Mc8R0eBxqA7Qd4Va
         JQc5gEYZmaIVxC/IkfOJr1cJsmcwSzJdy3mQ9yHZx+sUfZEnPag9x9OxcV1uynj/2G3T
         OnC4Bop47DTWIyeCAIkYT1S6ZB2BmT2mNqkKSrJn3ZsrtrPRD9CWPe0p9WXjQKD9I+OG
         leF1IFKm2i4D0+wcQYVy9m1OP/SXUYUP6CKxdrja1nywpo/qrHHIDe9nS7gBvVlObim4
         pJ5TQ29a/Fhrp8F+7JCiqjXekS/zQCYUX27MaU4bfFOFEwlwTFT2Q/tyJcVWQO8XMJ3e
         MFhA==
X-Gm-Message-State: APuU4Z8/j6szNdYYu2O1XS32HigSDXFKBdcgXhSYT/zckmgzMEVa83is
	/F0hV4MkvRZ147ApatzE0+8o48rwgQSSzPXP16foW8/hj7BwkkRvn3d0GldmMQ==
X-Gm-Gg: AYBFou00pbJdDwxtwpzD2ZJdhqVxMh76/wqHWhSHs7X4hLHTzvlmJR7X0JCn94wYQrh
	pIfj7hQ5BY9jlAItU0X1dbtyORsWUUnWVxXAo0bRV88v5OsgG29/EEAu2fGKI69YG2qIbOWRuN3
	8w3CQzF1dPcxhHaS6kLa0+gRW5aWXiLxney3ydP4I6j+bRGKq0IGAy6BkMqpaGEECb3BijkSx0h
	Kl8zZq1aKKmaSn5DYWVHSJ7BJ6qfM+N0DCjB0ZmWPncw5i8mx8ONnFTkjEwqjEl7r8QdksYN0tD
	eWqrNSbWULBTv6mFJEOQbqRecJB/JrpilNyyvv2Mi3Jyos7j2HBC6HvmJVdBtc6ureaaNmDE8a+
	BFBDTaJR55vk1deNGY5+DiRv8t4YCe1GU4jIMUD2G+uY454TmbMgZLm58DNg1QXhVIvCaWVqLpJ
	YQ5IpZcCLanojDptVLbNBWP9Nsl3z5qPCKMJBenjqgK5f3lb2+qF8WkzNZndDirb+AcNQeJF9Zb
	ZskrJoUjGCz1szLQAtKRuH7/KwInzXmoDJnoI6Z2ACSOpuR98ft/KENiZlmBkSiM1lW6pljBw+/
	VoKxhncsKzM/ZVyCEW39R2c2JCUF9uF1ykBGBcpq2cuOU7UlFmH/6CLL1bg9n3JO6BWnRO8kpzj
	I5xBSWXfjna19ymn0eaUcbdxGpdCjewYIuNmwpkuHbW3F1scsurNvRCh1o7rVI/aueZ4p8AAzQ7
	vBuQZUosIeWpNLopKZdPs=
X-Received: by 2002:a17:90b:2e83:b0:3ae:6fda:78b1 with SMTP id 98e67ed59e1d1-3b0db6fe13emr4694953a91.43.1794022687023;
        Fri, 06 Nov 2026 19:38:07 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm1338265a91.0.2026.11.06.19.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 19:38:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v4 01/46] bpf: Add may_goto to the loops that the verifier marks
Date: Sat,  7 Nov 2026 03:37:09 +0000
Message-ID: <20261107033758.1547725-2-alexei.starovoitov@gmail.com>
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

SpinLock::lock() of rust-bpf (scx_common.rs), here in central_enqueue:

  while self.locked.compare_exchange(0, 1, Acquire, Relaxed).is_err() {
      while self.locked.load(Relaxed) != 0 { core::hint::spin_loop(); }
  }

  infinite loop detected at insn 127

111 of the 225 progs of the schedulers of rust-bpf get this message. Memory
decides when the loop ends: no analysis finds a bound. The same holds for
a lookup in a BTreeMap. C has bpf_for(), can_loop, bpf_loop(). Nobody can
put them into core and alloc.

With one state for all iterations the verifier can still show that each of
them is safe. Then the kernel must stop the loop at run time. may_goto does
that: after 250 ms it jumps to its target. That jump is a new edge in the
prog, and must be verified. One target for all loops is not possible:

  lock(), see above                 pick_idle_cpu_in() of scx_p2dq.rs
  Not to the exit of the loop:        let cores = core.then(..::idle_smt);
  the caller goes on as if it         cpus.filter(..).find(..)
  had the lock. Unwind instead:     Not out of the function: the code
                                    after the loop releases the cpumask.
  may_goto L
  insn                              may_goto T
  ...                               if ... goto T
  last insn of the subprog
  L: r0 = 0
  unwind_exit, main prog: exit      T is outside of the loop

Thus the main pass selects the edge for each loop, verifies it, and
records it in insn_aux_data. bpf_insert_loop_guards() adds the insns after
the main pass. No code sets loop_guard in this patch: no prog changes.
 - unwind_exit is for a subprog whose callers have cleanup code for it
   (bail_unwinds): their destructors run, the code after the call does not.
 - The inner loop of lock() goes around without a jump that leaves. Then
   may_goto is at the loop head (guard_at_header): 142 of the 225 progs.
 - may_goto has a 16-bit offset. If L is more than 2048 insns away it gets
   'r0 = 0; exit' of its own, and one more jump in each iteration.

Progs without such a loop get the same code. 174 of the 225 progs have one.
An added may_goto costs what a may_goto of the prog costs. It is 10 insns,
14 if no register is dead: thus it gets the live registers of the insn that
follows it. That, and one L per subprog, not per loop: 6 % less jited code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  33 ++++++
 kernel/bpf/fixups.c          | 219 +++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        |   4 +
 3 files changed, 256 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d6e41444ab14..7e268540dae9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -815,6 +815,10 @@ struct bpf_insn_aux_data {
 	u64 cast_arena:1; /* addr_space_cast of an address in arena */
 	u64 cast_mov:1; /* addr_space_cast of a pointer that is not in arena, it's a move */
 	u64 bb_end:1; /* last instruction of a basic block */
+	u64 loop_guard:1; /* may_goto is added in front of this instruction */
+	u64 guard_place:1; /* it's the place for may_goto if the loop needs one */
+	u64 guard_at_header:1; /* there is no better place than the head of the loop */
+	u64 guard_no_unwind:1; /* it cannot unwind from here, at least sometimes */
 	u64 need_scev:1;
 	u64 alu_state:5; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
@@ -878,6 +882,8 @@ struct bpf_insn_aux_data {
 	 * For a loop header, identifies the parent loop instead.
 	 */
 	s32 loop_header;
+	/* where may_goto in front of this instruction goes */
+	s32 guard_to;
 	/* additional information about the loop if this instruction is a loop header */
 	struct bpf_loop *loop;
 };
@@ -1021,6 +1027,8 @@ struct bpf_subprog_info {
 	 * a hidden pointer to the result, a pair in two registers, no dead arguments.
 	 */
 	bool stack_args_from_code: 1;
+	/* it can leave with unwind_exit: it has one, or unwind_goto follows every call of it */
+	bool bail_unwinds: 1;
 	u8 code_stack_args;
 	u16 stack_arg_cnt; /* incoming + max outgoing */
 	u16 max_out_stack_arg_cnt;
@@ -1521,6 +1529,7 @@ void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
 
 int bpf_is_state_visited(struct bpf_verifier_env *env, int insn_idx);
+int bpf_insert_loop_guards(struct bpf_verifier_env *env);
 bool bpf_edge_leaves_loop(struct bpf_verifier_env *env, int h, int n, int t);
 bool bpf_jump_leaves_loop(struct bpf_verifier_env *env, int h, int n);
 int bpf_split_cur_state(struct bpf_verifier_env *env);
@@ -1845,6 +1854,30 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 const char *bpf_subprog_name(const struct bpf_verifier_env *env, int subprog);
 int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
+
+/*
+ * Where the program goes from may_goto and from the checks that the verifier adds:
+ * - May_goto in front of a jump goes where the jump goes, with the registers and the stack
+ *   as they are in front of the jump. bpf_insn_successors() has that edge.
+ * - A subprog that is out of budget goes to bail_insn, an exit. No such edge.
+ * - May_goto in front of the head of a loop goes to where the loops around it are left: from
+ *   @idx to what is returned here, -1 if there is none. No such edge either. The registers
+ *   and the stack are what they are in front of @idx.
+ *
+ * The main pass looks at the states that go there. What is computed from the graph before
+ * the main pass has to take these edges into account where the main pass believes it:
+ * - Against the direction of the edges, liveness: a register that is live at the target is
+ *   live at @idx. Stack that is dead at @idx stays dead: a read of it at the target is
+ *   rejected.
+ * - In the direction of the edges, bpf_compute_const_regs() and compute_subprog_args(): what
+ *   holds on all edges of the graph to the target doesn't hold on this one.
+ */
+static inline int bpf_head_guard_target(const struct bpf_verifier_env *env, int idx)
+{
+	const struct bpf_insn_aux_data *aux = &env->insn_aux_data[idx];
+
+	return aux->guard_at_header ? aux->guard_to : -1;
+}
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, const unsigned long *stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index f95af2ca3591..6fd79c2fbdc1 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -587,6 +587,225 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
 	return 0;
 }
 
+static bool jumps_to_itself(const struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+
+	return (class == BPF_JMP || class == BPF_JMP32) && op != BPF_CALL && op != BPF_EXIT &&
+	       insn->code != (BPF_JMP32 | BPF_JA) && insn->off == -1;
+}
+
+/* How a subprog leaves when it is out of budget, see push_budget_exit() */
+static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
+{
+	if (!sub->bail_unwinds)
+		return BPF_EXIT_INSN();
+	sub->can_unwind = true;
+	env->prog->jit_required = 1;
+	return BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0);
+}
+
+/*
+ * may_goto has 16 bits for the offset, and what is between it and its target is going
+ * to grow: may_goto itself becomes 10 insns, 14 when it has to save a register.
+ */
+#define BPF_GUARD_NEAR	2048
+
+static bool guard_leaves_subprog(const struct bpf_insn_aux_data *aux)
+{
+	return aux->loop_guard && !aux->guard_no_unwind;
+}
+
+/*
+ * 'r0 = 0; exit' behind the last insn of the subprog, for all its guards that are near.
+ * Returns the number of insns that are going to be added.
+ */
+static int append_budget_exit(struct bpf_verifier_env *env, int s)
+{
+	struct bpf_subprog_info *sub = &env->subprog_info[s];
+	int last = (sub + 1)->start - 1, n = 0, i;
+	struct bpf_insn buf[4], *insn;
+
+	for (i = max_t(int, sub->start, last + 1 - BPF_GUARD_NEAR); i <= last; i++)
+		if (guard_leaves_subprog(&env->insn_aux_data[i]))
+			break;
+	if (i > last)
+		return 0;
+
+	buf[n++] = env->prog->insnsi[last];
+	buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
+	if (bpf_ret_reg_pair(env, s))
+		buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
+	buf[n++] = budget_exit_insn(env, sub);
+	insn = bpf_patch_list_add(env, last, buf, n);
+	return IS_ERR(insn) ? PTR_ERR(insn) : n - 1;
+}
+
+/*
+ * Add may_goto in front of the insns that the main pass marked, see
+ * check_loop_guard(). It verified the edge from the insn to where may_goto goes.
+ */
+int bpf_insert_loop_guards(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *aux = env->insn_aux_data;
+	int len = env->prog->len, i, r, s, to, n, jmp, err = 0;
+	struct bpf_insn *patch, *insn;
+	int *target, *leave, *moved;
+	bool indirect;
+	u16 *zero;
+	s64 off;
+
+	for (i = 0; i < len; i++)
+		if (aux[i].loop_guard)
+			break;
+	if (i == len)
+		return 0;
+
+	/*
+	 * Where the subprog has 'r0 = 0; exit', 0 if it has none. And how far that moved
+	 * the subprog: guard_to is from the time before.
+	 */
+	leave = kvcalloc(2 * env->subprog_cnt, sizeof(int), GFP_KERNEL_ACCOUNT);
+	if (!leave)
+		return -ENOMEM;
+	moved = leave + env->subprog_cnt;
+	for (s = 0; s < env->subprog_cnt && !err; s++) {
+		leave[s] = append_budget_exit(env, s);
+		if (leave[s] < 0)
+			err = leave[s];
+	}
+	/* A guard cannot jump into a patch that is in the list: 'r0 = 0' has no index yet. */
+	err = err ?: bpf_patch_list_commit(env);
+	if (err) {
+		kvfree(leave);
+		return err;
+	}
+	aux = env->insn_aux_data;
+	len = env->prog->len;
+	for (s = 0, n = 0; s < env->subprog_cnt; s++) {
+		moved[s] = n;
+		n += leave[s];
+		if (!leave[s])
+			continue;
+		i = env->subprog_info[s + 1].start;
+		leave[s] = i - leave[s];
+		/*
+		 * The list gives what is known about an insn to the last insn of its patch,
+		 * but for indirect_target. Here the original insn is the first one.
+		 */
+		indirect = aux[leave[s] - 1].indirect_target;
+		swap(aux[leave[s] - 1], aux[i - 1]);
+		aux[leave[s] - 1].indirect_target = indirect;
+		aux[i - 1].indirect_target = false;
+		/* the last insn may be dead code */
+		while (--i >= leave[s])
+			aux[i].seen = 1;
+	}
+
+	/* where the guard of the insn goes */
+	target = kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
+	zero = kvcalloc(len, sizeof(u16), GFP_KERNEL_ACCOUNT);
+	patch = kvcalloc(8, sizeof(*patch), GFP_KERNEL_ACCOUNT);
+	if (!target || !zero || !patch) {
+		err = -ENOMEM;
+		goto out;
+	}
+	for (i = 0; i < len; i++) {
+		s = bpf_find_containing_subprog(env, i) - env->subprog_info;
+		target[i] = aux[i].loop_guard ? aux[i].guard_to + moved[s] : -1;
+		if (guard_leaves_subprog(&aux[i])) {
+			/* see push_budget_exit() */
+			if (leave[s] && leave[s] - i <= BPF_GUARD_NEAR) {
+				target[i] = leave[s];
+			} else {
+				target[i] = -2;
+				zero[i] = BIT(BPF_REG_0);
+				if (bpf_ret_reg_pair(env, s))
+					zero[i] |= BIT(BPF_REG_2);
+			}
+		}
+	}
+
+	for (i = 0; i < len; i++) {
+		to = target[i];
+		if (to == -1)
+			continue;
+		/*
+		 *	may_goto to		or	may_goto +1
+		 *	insn				goto +N
+		 *					r0 = 0, ...
+		 *					exit
+		 *					insn
+		 */
+		n = 0;
+		if (zero[i]) {
+			patch[n++] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0);
+			patch[n++] = BPF_JMP_A(hweight16(zero[i]) + 1);
+			for (r = BPF_REG_0; r < BPF_REG_FP; r++)
+				if (zero[i] & BIT(r))
+					patch[n++] = BPF_MOV64_IMM(r, 0);
+		}
+		jmp = n++;
+		/* What is behind moves with this patch. The other patches are not there yet. */
+		if (to == -2)
+			off = 0;
+		else if (to > i)
+			off = to - i + n - jmp - 1;
+		else
+			off = to - (i + jmp) - 1;
+		if (off > S16_MAX || off < S16_MIN) {
+			verbose(env, "exit of the loop is too far from insn %d for may_goto\n", i);
+			err = -ERANGE;
+			break;
+		}
+		patch[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
+		if (to == -2)
+			patch[jmp] = budget_exit_insn(env, bpf_find_containing_subprog(env, i));
+		patch[n] = env->prog->insnsi[i];
+		/* A jump to itself is a back edge. It goes through may_goto like the others. */
+		if (jumps_to_itself(&patch[n]))
+			patch[n].off -= n;
+		else
+			err = bpf_adj_moved_insn(&patch[n], n);
+		if (err) {
+			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
+			break;
+		}
+		n++;
+		insn = bpf_patch_list_add(env, i, patch, n);
+		if (IS_ERR(insn)) {
+			err = PTR_ERR(insn);
+			break;
+		}
+	}
+	err = err ?: bpf_patch_list_commit(env);
+	if (err)
+		goto out;
+	/*
+	 * bpf_do_misc_fixups() keeps the address of the count of may_goto in a register that is
+	 * dead at the may_goto. A new insn has no live_regs_before: all registers would be dead.
+	 * What is live in front of the insn is live in front of its guard. Nothing else is:
+	 *  - The guard of a jump goes where the jump goes.
+	 *  - What is live where the guard at the head of a loop goes is live at the head,
+	 *    see bpf_head_guard_target().
+	 *  - On the way out of the subprog R0, and R2 of a pair, are set to 0.
+	 */
+	aux = env->insn_aux_data;
+	for (i = 0, n = 0; i < len; i++) {
+		if (target[i] == -1)
+			continue;
+		r = zero[i] ? 3 + hweight16(zero[i]) : 1;
+		aux[i + n].live_regs_before = aux[i + n + r].live_regs_before;
+		n += r;
+	}
+out:
+	kvfree(leave);
+	kvfree(target);
+	kvfree(zero);
+	kvfree(patch);
+	return err;
+}
+
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b58a1796a2e..eb51f7f04153 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24673,9 +24673,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret == 0 && env->callx_edges)
 		ret = sort_subprogs_topo(env);
 
+	/* the driver numbers the insns like the program that it was given */
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
+	if (ret == 0)
+		ret = bpf_insert_loop_guards(env);
+
 skip_full_check:
 	kvfree(env->explored_states);
 
-- 
2.55.0

