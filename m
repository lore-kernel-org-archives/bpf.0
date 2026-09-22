Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B463655F3
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039630; cv=none; b=SP6o0UQ2M+Dsak3srGgcAeWsChNlTlKEyINqtSJ0S3ahlIVG1WIs4BzMrQRgFMXrTD7P9esnjlqwjm2aNAtZotcEaANFG+buRHxuL7TJWYPuS72vUPIgN+IgvHoyaDWxT3E4Qe/vhFhqWAWmt1w8oZcQmE44GgEGG97oQeS+t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039630; c=relaxed/simple;
	bh=WCnf97H6rYZ0dtniyjLQ8KAAvujyB7vuV4IJD+G6uUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqnk0mV5M7kfnF+S6PwdXnHpx8i8QusBakYavuON5i6EuagDorYVyr22YTf9Dlc8KJlQABJ5WePCAS/lEYnP7anV5cubLvWQHO+TO4n4Rnf3DFF6FqMbROoNyz0R1g3ydN+33ziflI7YIOYrstWTB6ZpEavqcP0bqCRxMjyCA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkz8bLCl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkz8bLCl"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso3845135a91.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039628; x=1790644428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOBPq90hJWw566YzmLrpbIf9hr8+IJVl6E06na1bO8g=;
        b=gkz8bLClV6b2X5WYbHuGTqU16HXn67yfB7Rfr7Yd/FZ09HFrrQyurdJ2eZWt8Ugwts
         06hY4DKFYdILZxPYoBn1mSy0pAzrxqwvgh4zqI31sGlV9JdMuDtUlGBDnGJW+pyT8yE1
         M4kHy6cPa67lEhbTVAJpNeUQ79Qjdb58h1gisSd6IXp+YXFHxT9XsdQfPBrn0kxjMYwa
         7mtBBk49LnU2q4VISBPf6tydPloW7TsBfX48bnNIdXbRPoNVoAUJh1lF7foNogK1LbPY
         w2PFUzvQW30IBoZXgVGB7izN2qJWhrF4KrUXHbhBTy8IYPoXXyco10+gycjNJm6N2gT3
         So6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039628; x=1790644428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iOBPq90hJWw566YzmLrpbIf9hr8+IJVl6E06na1bO8g=;
        b=KUTS1kela1501dl5hcNyWpONAEsvMWzfrrYOOKR9vmoOKKyr4DEQPM5KKBbWd4xhKa
         Y0k83gCyKBzPJTK+LaZtmpEL4Mq07FOEa0PsFZEqwDBSmwZn8jBiaxOIRU310J9Sce7Q
         kI+11/x4h3/FOLyyFUgxeDm/aCsXepmREiGfCj2VfkX5KAufD7wzfLisNXSQS7oxEH1W
         +jdKZzLuAH9BSHrSJV2xBYFhZyYbGOdQXgB2/yX6K5eEhbDOSXmDx5I8ZGEcccuIwjmp
         EaJCaWYwRXoQb9JrZ4S8P+/yzgJFcC3y1/vS1uu520Q3xzhE1esdA5nuffT7zqdBbNrL
         X6Og==
X-Gm-Message-State: AFuF++m4Qw1wHVcniDUeJxebSTxDd7NW2s1W+lnozgwLMokMxgjxHJVo
	sBmB5jZEDMpA0e0l4pVZrjh2NvZD4H15CFg0IY/io5pN+Q3ZexZnZas9Sr+i2Q==
X-Gm-Gg: AYBFou0WEWYOJ6UV4+yDjl2trzm5rG5flBvquWfTlOjbEigbmZYuzOzJqJkVhiD96Qq
	tRRg9is2JrMenRdaT3ifWqymvraAa2C9EMes8AcXq+OfKUjD1n1AdYuQW8yK3mW612WXhXiizu/
	8zlcJYZ1A9N9cY21P0mt16aitgrw/JNBDKqgRFm2qPKjEqiaTwkGDSVaTx5tZW2YG99MIPGcry8
	xW1ADwYhAZUXmOtreKhUK/v6A6GlsiCrrh1gkEb97NKvl9RjXi6RQPs9Mo4+48W62HwLiU4gOjS
	D/GGZZ9FeeoM+fXoPfk4sAuJHmP7UbfOZSfe2OsuLsioM4i7reNb62ZhClMKIr9QyPAU3BKEdIR
	YdnDAqbhZ1tSPV44Hqy67FcMrfChY0jx7ttBYXYXA3cIxob4z4LuKzzuadVQiBC9OY/Y0H+OoFB
	IwfT5lf5EYiJX0v4g6HgmGI4DN01fA2evGjh3EG/kVNzXgkqperCH2qvGbw3nZqD5Gj2iL0CazN
	2DZ5JvphL8uwK2e0hYa6wcDXkUH8SqfYc7JRMZGsdOKO8eYmNDhP54sGAYA8NFhjt3tcw/mGkVO
	/mDOKtp4ZuGgjzoBWT6L6gmNhezjbvyHPIcuU/G3sik=
X-Received: by 2002:a17:90a:10d7:b0:3a0:4146:2959 with SMTP id 98e67ed59e1d1-3a041462d5amr4299971a91.65.1790039628224;
        Mon, 21 Sep 2026 18:13:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm1668373a91.12.2026.09.21.18.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 05/17] bpf: Add callx instruction to call bpf subprogs indirectly
Date: Tue, 22 Sep 2026 01:13:11 +0000
Message-ID: <20260922011323.1298619-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
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
---
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |   7 +
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/verifier.c                         | 144 ++++++++++++++----
 .../selftests/bpf/verifier/basic_call.c       |   2 +-
 5 files changed, 131 insertions(+), 28 deletions(-)

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
index 72ea662baea5..0d32d3921210 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10600,13 +10600,61 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
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
 
@@ -10695,37 +10743,70 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
+	err = check_reg_arg(env, insn->dst_reg, SRC_OP);
 	if (err)
 		return err;
 
-	bpf_diag_record_scrub(env, &caller->regs[BPF_REG_0], BPF_DIAG_MOD_CALLER_SAVED);
-	clear_caller_saved_regs(env, caller->regs);
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
+	}
 
-	/* and go analyze first insn of the callee */
-	*insn_idx = env->subprog_info[subprog].start - 1;
+	/*
+	 * Arithmetic on PTR_TO_FUNC is allowed, but only unmodified address
+	 * of a subprog can be called.
+	 */
+	err = check_ptr_off_reg(env, reg, insn->dst_reg);
+	if (err)
+		return err;
 
-	if (env->log.level & BPF_LOG_LEVEL) {
-		verbose(env, "caller:\n");
-		print_verifier_state(env, state, caller->frameno, true);
-		verbose(env, "callee:\n");
-		print_verifier_state(env, state, state->curframe, true);
+	/* there is no support for callx in the interpreter */
+	if (!env->prog->jit_requested) {
+		verbose(env, "JIT is required to use callx\n");
+		return -EOPNOTSUPP;
 	}
+	if (!bpf_jit_supports_callx()) {
+		verbose(env, "JIT doesn't support callx\n");
+		return -EOPNOTSUPP;
+	}
+	env->prog->jit_required = true;
 
-	return 0;
+	/* check_ld_imm() allows to take the address of static subprogs only */
+	subprog = reg->subprogno;
+	err = btf_check_subprog_call(env, subprog, caller->regs);
+	if (err == -EFAULT)
+		return err;
+
+	return check_static_func_call(env, subprog, insn_idx);
 }
 
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
@@ -18725,7 +18806,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 		env->jmps_processed++;
 		if (opcode == BPF_CALL) {
-			if (env->cur_state->active_locks) {
+			/* similar to static subprog calls callx is allowed under a lock */
+			if (env->cur_state->active_locks && !bpf_is_callx(insn)) {
 				if ((insn->src_reg == BPF_REG_0 &&
 				     insn->imm != BPF_FUNC_spin_unlock &&
 				     insn->imm != BPF_FUNC_kptr_xchg) ||
@@ -18743,6 +18825,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			mark_reg_scratched(env, BPF_REG_0);
 			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
 				cur_func(env)->no_stack_arg_load = true;
+			if (bpf_is_callx(insn))
+				return check_func_callx(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return check_func_call(env, insn, &env->insn_idx);
 			if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL)
@@ -19509,6 +19593,14 @@ static int check_jmp_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 
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

