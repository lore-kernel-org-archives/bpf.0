Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C0C1DE8AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219465; cv=none; b=Ikvf8p9usA4S3NqjBNP8l1tqvcFH6s6gNSrreUJiG6XFRT/N1oYwSoFe+6I+jxg3tMNZRIAveZbbcblv/uBy3jaZHOnCDuuiMpMAk40SOp3oDidOU/XBzeyZdK7RHVvlDwbdf7aa6Yj5LZ94VUcAFCghZBGqKP2pWYHoMcKu3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219465; c=relaxed/simple;
	bh=e4g7SaaNCzzlzid7ROxLhM20XTDixpPX2EEpM2RCKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIDLV+jZqFD2Krj54lH6qI7F7tsUb+EXEGktvjnjA80IRKmiuejt8qOujtnXwODwp5SYIA7ENqcSD5b5hOxMsjQ8xczDRcUoxDxCkvE4j96LwWTi0nDtiIadLTV8S4QCSuakDqDdxwGDTOmffwII15Ivhryorx5AqWqHhtYo/y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2enBJhc; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2enBJhc"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso1005016a12.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219463; x=1790824263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zJsmK3bDsOQCvkHx1jrFNHlf92Izh794UGVSxB2GJnw=;
        b=D2enBJhc+PaXN2XCQx9CnWoPJ3izLDCjgnoafUyIOwRrtiCNlaB8eOiBzaTG6QDrhK
         CdMs711Z9VFdHBry297XhKbFcbJ1RviwQpbBtl4SKhWHk+/kr23I/r44k+chvKoV5eYj
         nq9aMfzTiIvGqgDE7s7XBQgJVVzlduQ90WG+QLHft/oNBtMNMRD6pU5kLmKm0HHm20TM
         ZR6Fn9Fz/gCJfygYzmrjF0m6cV1VUd5kwN3l9MwDJ7pbGlQmYKWr/GSxRv23Nq/rjPUy
         tpWGhQgBkgM9OlLxEHpcaGZAwjvOJWJF0y7GhseJA8FaCUZAS1rYoG4glwIaHFabX6e3
         4zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219463; x=1790824263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zJsmK3bDsOQCvkHx1jrFNHlf92Izh794UGVSxB2GJnw=;
        b=iPwA2SCzuP2DGEwDJ+aPUr32rx36Y9DhzqxXGkRN7aP1oHp1XbsZsZ44lScjU6KQCr
         RzqSwvGav1SxFI5EXWEWiVffYYCP38ZJBGPUyyxS2KJPGw0NIllJEGjMcT33+2EXC916
         4aMs3zyRXtpOthrKA/9PqkF/LAVmAWGIVFW/oSTmBkdREirSt6f4NoKoUQd/co5H4V2C
         ltIxFxQp+YFnKTi01aBGeBgHbhY8Qt3aSeJ4/bZNUah3FRli2hZnZ3u+xy3vZZ2AEDgC
         p39HsLBuK7AHH3F3jpwm0femysFzBVJAjI1xmYWNIDddiMD8Xgo81bmf+loeYXnSFpU9
         kuLw==
X-Gm-Message-State: AFuF++nBtyzAkJVNpeLcVfKd1DifUU32Nn9YTTuNg3bdatJL9Et31zAa
	lSSoHozTJAyA7FKltRpPfyvopHNj/0GsIB40sfgEkOq89zZEhu+rDAJcpfT6qg==
X-Gm-Gg: AYBFou1mgPa4E+qEXZn0TLGV8yS14qccFpKvATn2Et228LxuEBLY/LLprjRpy2UovGP
	90iS6uvyGmM+LanyGE5DlniDPLtKXU82QLEY6pSZl+ML9rMAsXrzz5D0kobMUSjUckNNbiA05/h
	xsVM1jOpjeilkolj1aa/9IagQBni2nrJqK3FIxBM8CnA158HwX3iwM1QnsObNtwAi2UbDzTlq2b
	IcCrF/l+uDEo2kEE9BGijBsweEY5tsoAZcUeGLJxVmkqyk7KMOxYorsgxC317WS6OZ/pb79eZL4
	RXs9xhBrT0TN91WH4quYKStodhyd+Bgl6Xa/2wmx4KhbxK/BMWWk0DZPFcyHRHGmCAd+4PlobE9
	gUHt/NkfD69kmKH6lohp10eO+IdNXO1Jqs3hfuY27h3bQ5+5kUTH+xxcVFvWkOTeO8v9V+luK28
	KwljZG195bmsdXIAaN5GWSoi+bMucCk+uqOlIFtK8zHx0g080h0IH+SGWkFJgl50f+/6jN3Wodc
	WsPu9O20/EXGdJeHlRP5JAjNGjYEkBoJToFULXZvTRtNQDY1X5/8XccIPFvkpab/3GDkdJKYKXP
	W8IkF3CYn/iQD5aLU9p530zU7KgbHE3Z894SqknYRq0=
X-Received: by 2002:a05:6a20:e68e:b0:3dd:a196:53a8 with SMTP id adf61e73a8af0-3de0e99383fmr1010520637.74.1790219463197;
        Wed, 23 Sep 2026 20:11:03 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1331sm2094010b3a.24.2026.09.23.20.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:02 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 05/17] bpf: Add callx instruction to call bpf subprogs indirectly
Date: Thu, 24 Sep 2026 03:10:30 +0000
Message-ID: <20260924031042.1690890-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce BPF_JMP | BPF_CALL | BPF_X (opcode 0x8d) 'callx dst_reg'
instruction: indirect call of bpf subprog with address in dst_reg.
That's the encoding LLVM emits for calls via function pointer.
src_reg, off, imm are reserved and must be zero.

dst_reg must be PTR_TO_FUNC produced by ld_imm64 BPF_PSEUDO_FUNC.
check_ld_imm() allows it for static subprogs only, so callx cannot call
global subprogs or the main prog. Since every callee has its address
taken by ld_imm64, add_subprogs() and check_cfg() see all of them before
the main pass, and might_sleep, changes_pkt_data, might_throw of
the callee are already merged into the subprog that takes the address.

reg->subprogno is the callee. Verify callx as a direct call of that
static subprog: split check_func_call() into check_static_func_call()
that is shared with new check_func_callx(). Different paths through
the same callx may call different subprogs.

Arithmetic on PTR_TO_FUNC is allowed, so check that the pointer wasn't
modified. Allow callx while holding a lock like direct calls of static
subprogs.

The interpreter doesn't support callx. Set jit_required and add
bpf_jit_supports_callx() for JITs to opt in. No JIT does yet, so callx
is still rejected.

Print it as "callx rN" in the verifier log and xlated dump.

Adjust "invalid call insn1" test_verifier test that used opcode 0x8d as
unknown opcode. It fails with "R0 !read_ok" now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |   7 +
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/verifier.c                         | 163 ++++++++++++++----
 .../selftests/bpf/verifier/basic_call.c       |   2 +-
 5 files changed, 145 insertions(+), 33 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 422284b4fa96..4f0662e42897 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1237,6 +1237,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 227211166dcc..868350977f0c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1831,6 +1831,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
 		[BPF_JMP | BPF_JA | BPF_X] = true,
+		[BPF_JMP | BPF_CALL | BPF_X] = true,
 		[BPF_JMP | BPF_JCOND] = true,
 	};
 #undef BPF_INSN_3_TBL
@@ -3287,6 +3288,12 @@ bool __weak bpf_jit_supports_kfunc_call(void)
 	return false;
 }
 
+/* Return TRUE if the JIT backend supports callx (indirect call) instruction. */
+bool __weak bpf_jit_supports_callx(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
 {
 	return false;
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3ce8d74b0e40..36d3228d7745 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -350,7 +350,10 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 		if (opcode == BPF_CALL) {
 			char tmp[64];
 
-			if (insn->src_reg == BPF_PSEUDO_CALL) {
+			if (BPF_SRC(insn->code) == BPF_X) {
+				verbose(cbs->private_data, "(%02x) callx r%d",
+					insn->code, insn->dst_reg);
+			} else if (insn->src_reg == BPF_PSEUDO_CALL) {
 				verbose(cbs->private_data, "(%02x) call pc%s",
 					insn->code,
 					__func_get_name(cbs, insn,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 74cf24ce3007..eb014bf6a2e8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6443,6 +6443,21 @@ static void add_scalar_to_reg(struct bpf_reg_state *dst_reg, s64 val)
 	reg_bounds_sync(dst_reg);
 }
 
+/* there is no support for callx in the interpreter */
+static int require_callx_jit(struct bpf_verifier_env *env)
+{
+	if (!env->prog->jit_requested) {
+		verbose(env, "JIT is required to use callx\n");
+		return -EOPNOTSUPP;
+	}
+	if (!bpf_jit_supports_callx()) {
+		verbose(env, "JIT doesn't support callx\n");
+		return -EOPNOTSUPP;
+	}
+	env->prog->jit_required = true;
+	return 0;
+}
+
 static int check_map_mem_read(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int off,
 			      int bpf_size, int value_regno, bool is_ldsx)
 {
@@ -10621,13 +10636,61 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 static int process_bpf_exit_full(struct bpf_verifier_env *env,
 				 bool *do_print_state, bool exception_exit);
 
-static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
-			   int *insn_idx)
+/*
+ * Call of a static subprog. The callee is verified in the context of
+ * the caller, hence set up a new frame and continue from the first
+ * instruction of the callee.
+ */
+static int check_static_func_call(struct bpf_verifier_env *env, int subprog,
+				  int *insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
 	struct bpf_subprog_info *caller_info;
 	u16 callee_incoming, stack_arg_cnt;
 	struct bpf_func_state *caller;
+	int err;
+
+	caller = state->frame[state->curframe];
+
+	/*
+	 * Track caller's total stack arg count (incoming + max outgoing).
+	 * This is needed so the JIT knows how much stack arg space to allocate.
+	 */
+	caller_info = &env->subprog_info[caller->subprogno];
+	callee_incoming = bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
+	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
+	if (stack_arg_cnt > caller_info->stack_arg_cnt)
+		caller_info->stack_arg_cnt = stack_arg_cnt;
+
+	/*
+	 * For regular function entry setup new frame and continue
+	 * from that frame.
+	 */
+	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state, state);
+	if (err)
+		return err;
+
+	bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
+	clear_caller_saved_regs(env, caller->regs);
+
+	/* and go analyze first insn of the callee */
+	*insn_idx = env->subprog_info[subprog].start - 1;
+
+	if (env->log.level & BPF_LOG_LEVEL) {
+		verbose(env, "caller:\n");
+		print_verifier_state(env, state, caller->frameno, true);
+		verbose(env, "callee:\n");
+		print_verifier_state(env, state, state->curframe, true);
+	}
+
+	return 0;
+}
+
+static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			   int *insn_idx)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	struct bpf_func_state *caller;
 	int err, subprog, target_insn;
 	u32 i, nregs;
 
@@ -10716,37 +10779,63 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return 0;
 	}
 
-	/*
-	 * Track caller's total stack arg count (incoming + max outgoing).
-	 * This is needed so the JIT knows how much stack arg space to allocate.
-	 */
-	caller_info = &env->subprog_info[caller->subprogno];
-	callee_incoming = bpf_in_stack_arg_cnt(&env->subprog_info[subprog]);
-	stack_arg_cnt = bpf_in_stack_arg_cnt(caller_info) + callee_incoming;
-	if (stack_arg_cnt > caller_info->stack_arg_cnt)
-		caller_info->stack_arg_cnt = stack_arg_cnt;
+	return check_static_func_call(env, subprog, insn_idx);
+}
 
-	/* for regular function entry setup new frame and continue
-	 * from that frame.
-	 */
-	err = setup_func_entry(env, subprog, *insn_idx, set_callee_state, state);
+/*
+ * callx dst_reg: call a bpf subprog whose address is in dst_reg.
+ *
+ * The address of a subprog is loaded into a register by ld_imm64 with
+ * src_reg == BPF_PSEUDO_FUNC, which is allowed for static subprogs only.
+ * Hence all possible callees of callx are discovered by add_subprogs() and
+ * are reachable in the control flow graph before the main verification pass
+ * begins. PTR_TO_FUNC register identifies the callee, so from here on callx
+ * is verified as a direct call of that static subprog.
+ */
+static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
+			    int *insn_idx)
+{
+	struct bpf_func_state *caller = cur_func(env);
+	struct bpf_reg_state *reg;
+	const char *reason;
+	int err, subprog;
+
+	err = require_callx_jit(env);
 	if (err)
 		return err;
 
-	bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
-	clear_caller_saved_regs(env, caller->regs);
-
-	/* and go analyze first insn of the callee */
-	*insn_idx = env->subprog_info[subprog].start - 1;
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
+	if (err)
+		return err;
 
-	if (env->log.level & BPF_LOG_LEVEL) {
-		verbose(env, "caller:\n");
-		print_verifier_state(env, state, caller->frameno, true);
-		verbose(env, "callee:\n");
-		print_verifier_state(env, state, state->curframe, true);
+	reg = reg_state(env, insn->dst_reg);
+	if (reg->type != PTR_TO_FUNC) {
+		verbose(env, "R%d has type %s, expected func\n", insn->dst_reg,
+			reg_type_str(env, reg->type));
+		reason = bpf_diag_fmt(
+			env, "R%d holds %s, but callx can only call through the address of a static BPF function.",
+			insn->dst_reg, bpf_diag_reg_type_plain(env, reg->type));
+		bpf_diag_register_type(
+			env, *insn_idx, insn->dst_reg, "indirect call through a non-function pointer", reason,
+			"Load the address of a static BPF function into the register before callx.");
+		return -EACCES;
 	}
 
-	return 0;
+	/*
+	 * Arithmetic on PTR_TO_FUNC is allowed, but only unmodified address
+	 * of a subprog can be called.
+	 */
+	err = check_ptr_off_reg(env, reg, insn->dst_reg);
+	if (err)
+		return err;
+
+	/* check_ld_imm() allows to take the address of static subprogs only */
+	subprog = reg->subprogno;
+	err = btf_check_subprog_call(env, subprog, caller->regs);
+	if (err == -EFAULT)
+		return err;
+
+	return check_static_func_call(env, subprog, insn_idx);
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
@@ -18811,11 +18900,13 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 		env->jmps_processed++;
 		if (opcode == BPF_CALL) {
 			if (env->cur_state->active_locks) {
-				if ((insn->src_reg == BPF_REG_0 &&
-				     insn->imm != BPF_FUNC_spin_unlock &&
-				     insn->imm != BPF_FUNC_kptr_xchg) ||
-				    (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
-				     !kfunc_spin_allowed(env, insn->imm, insn->off))) {
+				/* similar to static subprog calls callx is allowed under a lock */
+				if (!bpf_is_callx(insn) &&
+				    ((insn->src_reg == BPF_REG_0 &&
+				      insn->imm != BPF_FUNC_spin_unlock &&
+				      insn->imm != BPF_FUNC_kptr_xchg) ||
+				     (insn->src_reg == BPF_PSEUDO_KFUNC_CALL &&
+				      !kfunc_spin_allowed(env, insn->imm, insn->off)))) {
 					verbose(env,
 						"function calls are not allowed while holding a lock\n");
 					bpf_diag_ctx_active(
@@ -18828,6 +18919,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
 				cur_func(env)->no_stack_arg_load = true;
+			if (bpf_is_callx(insn))
+				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return check_func_call(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
@@ -19594,6 +19687,14 @@ static int check_jmp_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
 	switch (opcode) {
 	case BPF_CALL:
+		if (bpf_is_callx(insn)) {
+			/* callx dst_reg */
+			if (insn->src_reg != BPF_REG_0 || insn->imm != 0 || insn->off != 0) {
+				verbose(env, "BPF_CALL|BPF_X uses reserved fields\n");
+				return -EINVAL;
+			}
+			return 0;
+		}
 		if (BPF_SRC(insn->code) != BPF_K ||
 		    (insn->src_reg != BPF_PSEUDO_KFUNC_CALL && insn->off != 0) ||
 		    (insn->src_reg != BPF_REG_0 && insn->src_reg != BPF_PSEUDO_CALL &&
diff --git a/tools/testing/selftests/bpf/verifier/basic_call.c b/tools/testing/selftests/bpf/verifier/basic_call.c
index a8c6ab4c1622..0f93c4551f23 100644
--- a/tools/testing/selftests/bpf/verifier/basic_call.c
+++ b/tools/testing/selftests/bpf/verifier/basic_call.c
@@ -4,7 +4,7 @@
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, 0, 0, 0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "unknown opcode 8d",
+	.errstr = "R0 !read_ok",
 	.result = REJECT,
 },
 {
-- 
2.55.0

