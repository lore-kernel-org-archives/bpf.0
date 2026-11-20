Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208022;
	b=rOfHJpwDPDUveTmaBhuZjvcKYY31DpXy5vFF4Sv/D/5sFcOvGQkvixNhv+IwQz5NICDZ
	 Iv60N4dgI2cAkaUt5LmQz1VWdEWYzSI6KwW3W8EJ9fQTSfUkWMpRV7yz6ZbjDId4JCCD2
	 HL5a7eVQtm3k73gPOCiHkNtcTjQgSDCU5xmbVYPSuPbIVyc3WeOiXuU7P6KtZIa1YNH4Z
	 PBm+oapTH6FJ15stC2KOIZ91pRzMwD+gYbPDNMp8y+iso/MDq01b4zz6lMNIlPQTvuQPh
	 5PmTu8ktfulzHe3udVq9gI52DaVWDOMZNZxe8AhdqOeTR0/WR//8gB5kxhh4GjkINGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iyormCLMIPkA+sQ9URQQiihOZPKjssUM2ztBJ2pdRvk=;
	b=wzGAVpV3ztkdeaNArHDFBMlcKipzF8ZUbBzcEKvrE7YO3B0VeGtM02ZCtUt6khzj/pj6
	 DS0FOdpI5YFWMdWeh8WTxUL/TWZSTiH0mBTV73p8NVf88w5Zrm3OPUTCFE5Bkb6TSyjws
	 EHowFZL4oTCphDFjjErv2x1R7ON+oG8ozODquob4pG/eDRkcpk+wjK0s8mfkmsqyW825x
	 YzQifVEk0ID4TBlLnZbV1FngXuCHcu1pq3iXw1E5IzkVZlJ147TRbbTHJcBe1IiJtUWtl
	 acZ/8NVOy5+D8bCXNvj2WTzxrwK4XSJIWn9gu3O8+xwnGh/sgFjfZB73EB+bono9PXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB+nlBe4;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D2606A6A2
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 844D2606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rB+nlBe4
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so762350b3a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795208016; x=1795812816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyormCLMIPkA+sQ9URQQiihOZPKjssUM2ztBJ2pdRvk=;
        b=rB+nlBe4n7uwM4P4JEo0fL9fuGf+xscP/dRYMyYRSJX+z+T/bCqXQbF4XAzfWWHa4V
         yyz8vXRw9mtR0Onj4O8ZaXfcoiPU68t2AhUzE3sYsxf7luqDULxpB+zMuVIKVvwIEbv7
         Hju688PORCP8gWRMAsck5QBoaNqU2qo1RxvDZjzSaW7yq4J1BrU6Q3GbBoFrvxE74fva
         FnTwt/XanogRhLuMO7cVk7ADwYkXWLzv2mYn3pzYUpqhZOglLiaG8VpiofDQJbIUIar7
         cDYH91XDRljGJ34r36+yxhNhtQwu5OeTILBgEjq+jK8UCFDb8ZHx8oKyNbFazKSMQyIw
         fYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795208016; x=1795812816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iyormCLMIPkA+sQ9URQQiihOZPKjssUM2ztBJ2pdRvk=;
        b=kKkTGzq6RRWb048dHe0Qn+HG5rqLhz3zlB9+R3oyCrH4Fu6mXzujutxYGhlYH7pk1k
         l++kRPZR7M0anLzmyGzFnNxmPBBpxLb++HIVDDmhYE9knvodVVQlEtFrTAZcGf9dDtTI
         RiC7eJIQTFDJn3/cDZ/gAisZY7uDr3t0iB7kVeLYuKJnabY2BlUSleV6Tkvqeqj32qZu
         DF9+dW13niCVhYrjL2fxngfA5fjYvkU8z80VkXRw2BCANnAqQLcTRDlvyTxrQrMO987k
         jDq0+Z4m47H6YmQDCre2jM/fXbGJQ5ls2julIDi9cxBhBVyKgyovLvKQPjCY3nFQZOTT
         N2Bg==
X-Gm-Message-State: APuU4Z8vn4lLM2zxyd+2czpeZ2jpcgtcSfMSfwDJ/ewdmffrhwMKWTQ1
	4WiHiXniQezJFD2ZHg6+zo66R2HAKTmLfOsgAw5w573ro+R5S3tOgl6TPEtWQA==
X-Gm-Gg: AZFdTZfOYwhCubP5e9KqfG1IY7a79knSInc8SnSe6i2BBsw5CcJ6uQyXLQH52qA6jou
	eYVWL6zS/3ph08dCzyLyDBiwEY6kTwdTGLa0cVhVbM6z87GFD5Jw1eElvHopRwmFMuh3UWucFFF
	KLlvE9IoE/Uf7+0VN9g8XAd/RWwr3POnEyULjOkZmAXCmFuHI28eYDwoW3ze+k3pE5F7Tch9Ey+
	jiK4c8Nkf3C7+e2KEQZVaTs6MW9MUrxNvCkRtm33kuddTEM43kI+Z4HhRZZXWC1qKOPjKYTh32y
	wxfvMHN7PvgjlopG8Q3lcJRUxgjixObTGgYa8/QUwxPyJUAVls2BYBjpFh/9batnPYnXtGcSEIU
	f/RM4KiErXafeBlbvNNvOmvRpBfIvF2RMDHniBNq0P9d3bWgtO4JYdqZtIs+xKo2aMlQu65ECwn
	aLllVq3b6/wnE3myp929fcH//01SQnIzflPk07vhXB/Gku23ffVtMLYJzomSoQBVmxJGD4UuFx9
	t7Vbs1Ui0apU62stgWIdffGOiBIs/24WLnV50ezShDjMCkttOLgMNhXPDgCLothNMuOj6voY3Ra
	wQQAHIRP8HXY84TY2k5vWnUZMoYQnzWJshU6dwJWa93CSbjyZA44DJB1i2wNWMRASxBbtyarYQ2
	fiHHcYJNgUBT8NMPWtJlZl8/gSWKnXTT0nPNbUbV3aUAPFB5ciB+GUWCxYbROjKyahMeXAM0iXQ
	==
X-Received: by 2002:a17:90b:442c:b0:3b4:a90:7f30 with SMTP id 98e67ed59e1d1-3b41c9802e1mr3986976a91.55.1795208015598;
        Fri, 20 Nov 2026 12:53:35 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b52dsm5925389a91.5.2026.11.20.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:53:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 36/49] bpf: Do not let a join raise what a program requires
Date: Fri, 20 Nov 2026 20:49:44 +0000
Message-ID: <20261120204959.614908-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-1-alexei.starovoitov@gmail.com>
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

A pass can have no error and still ask for too much:

  (off, len) = (0, 64) or (56, 8)     each path needs 64 bytes
  join: off = 0..56, len = 8..64      the pass asks for 120 bytes

Such bounds are checked at attach time or at run time. The program
loads, and then it cannot attach or run.

Mark the insn as pessimized if it raises such a bound after an
imprecise join, and an operand has a range. See struct
prog_requirements. A barrier and a lost fastcall pattern count too. The
verifier then keeps a snapshot of the pass and partitions more as for
an unproven insn, in a small budget. If a later pass has an error, the
snapshot is the result.

  r0 = *(u64 *)(ctx + 8)        no range, a join cannot change it
  read(ctx + off, len)          a join can add values to off and len

One case is not covered: a join makes a dead path reachable, and an
insn on that path has constant operands. The bound stays larger.

kprobe_override and the bounds on buffers that a tail call sets move to
the main pass, so they are compared too.

The driver of an offloaded program cannot forget what it saw. So it
sees only a pass without errors: that pass runs once more for the
driver (env->replay). Before that, each insn after an imprecise join is
pessimized. An insn that the driver refuses is unproven. prepare() now
runs before each pass for the driver, and destroy() between two such
passes. An offloaded program gets no fastcall rewrite.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  4 ++
 kernel/bpf/fixups.c          |  6 ---
 kernel/bpf/offload.c         |  3 ++
 kernel/bpf/precision.c       | 44 ++++++++++++++++
 kernel/bpf/precision.h       |  1 +
 kernel/bpf/verifier.c        | 97 ++++++++++++++++++++++++++++++++----
 6 files changed, 139 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 74cc3e2fbc7..8c5eecf7501 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -884,6 +884,7 @@ struct bpf_loop {
 	);
 	struct bpf_loop_precision undo;	/* before the last partition */
 	struct bpf_loop_precision kept;	/* see keep_precision() */
+	struct bpf_loop_precision good;	/* see bpf_restore_precision() */
 	struct bpf_loop_per_pass last_pass;	/* the last pass whose partition was kept */
 	/* to peel all trips, estimated from a partition that was over its budget */
 	u64 full_peel_cost;
@@ -1389,6 +1390,7 @@ struct bpf_verifier_env {
 	struct_group_tagged(bpf_env_per_pass, per_pass,
 	int err;			/* the first error */
 	u32 err_insn;
+	bool pessimized;		/* see bpf_partition_for_pessimized() */
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool too_deep;			/* see failing_path_trip() */
@@ -1735,6 +1737,8 @@ void bpf_note_unproven_insn(struct bpf_verifier_env *env,
 bool bpf_insn_is_unproven(struct bpf_verifier_env *env);
 void bpf_note_fixups_differ(struct bpf_verifier_env *env);
 void bpf_find_unproven_after_pass(struct bpf_verifier_env *env);
+int bpf_partition_for_pessimized(struct bpf_verifier_env *env);
+void bpf_restore_precision(struct bpf_verifier_env *env);
 bool bpf_same_insns_unproven(struct bpf_verifier_env *env);
 int bpf_partition_more(struct bpf_verifier_env *env);
 bool bpf_undo_precision(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 4c9f63e096d..3bec52051a9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2629,8 +2629,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			prog->dst_needed = 1;
 		if (insn->imm == BPF_FUNC_get_prandom_u32)
 			bpf_user_rnd_init_once();
-		if (insn->imm == BPF_FUNC_override_return)
-			prog->kprobe_override = 1;
 		if (insn->imm == BPF_FUNC_tail_call) {
 			/* If we tail call into other programs, we
 			 * cannot make any assumptions since they can
@@ -2641,10 +2639,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			if (!bpf_allow_tail_call_in_subprogs(env))
 				prog->aux->stack_depth = MAX_BPF_STACK;
 			prog->aux->max_pkt_offset = MAX_PACKET_OFF;
-			prog->aux->max_rdonly_access = U32_MAX;
-			prog->aux->max_rdwr_access = U32_MAX;
-			if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
-				prog->aux->max_tp_access = U32_MAX;
 
 			/* mark bpf_tail_call as different opcode to avoid
 			 * conditional branch in the interpreter for every normal
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index f7bfff1760c..572d828a478 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -315,6 +315,9 @@ int bpf_prog_offload_verifier_prep(struct bpf_prog *prog)
 	down_read(&bpf_devs_lock);
 	offload = prog->aux->offload;
 	if (offload) {
+		/* the driver starts again, see do_check_all() */
+		if (offload->dev_state)
+			offload->offdev->ops->destroy(prog);
 		ret = offload->offdev->ops->prepare(prog);
 		offload->dev_state = !ret;
 	}
diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
index bcbc89655ed..ae9559a6e30 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1503,6 +1503,50 @@ int bpf_partition_more(struct bpf_verifier_env *env)
 	return find_calls_to_unproven(env) ?: partition_next(env);
 }
 
+/*
+ * The pass has no error. But an imprecise state can raise a bound that is checked at attach
+ * time or at run time. It can also ask for a barrier. Partition as if such an insn is
+ * unproven. Returns 1 if more is kept apart.
+ */
+int bpf_partition_for_pessimized(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	int ret;
+	u32 i;
+
+	if (!env->pessimized)
+		return 0;
+	prec->good_budget = prec->budget;
+	for (i = 0; i < prec->loop_cnt; i++)
+		prec->loops[i]->good = prec->loops[i]->precision;
+	for (i = 0; i < env->prog->len; i++)
+		if (env->insn_aux_data[i].pessimized)
+			note_unproven_after_pass(env, i);
+	ret = bpf_partition_more(env);
+	if (ret <= 0 && prec->data_deps)
+		bpf_restore_precision(env);
+	return ret;
+}
+
+/* Go back to the precision of the last pass without errors */
+void bpf_restore_precision(struct bpf_verifier_env *env)
+{
+	struct bpf_precision *prec = env->precision;
+	struct bpf_loop *loop;
+	u32 i;
+
+	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));
+	for (i = 0; i < 5 * prec->words; i++)
+		prec->kept[i] &= prec->data_deps[i];
+	prec->budget = prec->good_budget;
+	for (i = 0; i < prec->loop_cnt; i++) {
+		loop = prec->loops[i];
+		loop->precision = loop->good;
+		loop->partitioned = false;
+		loop->changed = true;
+	}
+}
+
 void bpf_precision_new_pass(struct bpf_verifier_env *env)
 {
 	struct bpf_precision *prec = env->precision;
diff --git a/kernel/bpf/precision.h b/kernel/bpf/precision.h
index 39284d1df97..f833b4642bc 100644
--- a/kernel/bpf/precision.h
+++ b/kernel/bpf/precision.h
@@ -62,6 +62,7 @@ struct bpf_precision {
 	u64 start_cost, pass_cost;	/* env->cost before the pass, the cost of a pass */
 	/* the cost that a partition can add to it, and that this one can add */
 	u64 budget, budget_left;
+	u64 good_budget;		/* see bpf_restore_precision() */
 	u8 partitioned_by, too_costly;	/* bits of PARTITION_* */
 	bool failing_path_due;		/* see bpf_failing_path_is_due() */
 	bool budget_grew;		/* see partition_next() */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2c5f967c37..f34c0101384 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3602,9 +3602,21 @@ static bool is_bpf_st_mem(struct bpf_insn *insn)
 	return BPF_CLASS(insn->code) == BPF_ST && BPF_MODE(insn->code) == BPF_MEM;
 }
 
+/* See bpf_partition_for_pessimized() */
+static void note_pessimized_insn(struct bpf_verifier_env *env, u32 idx)
+{
+	if (!env->imprecise)
+		return;
+	env->insn_aux_data[idx].pessimized = true;
+	env->pessimized = true;
+	if (!env->err)
+		env->err_insn = idx;
+}
+
 /* See comment for mark_fastcall_pattern_for_call() */
 static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
-					  struct bpf_func_state *state, int insn_idx, int off)
+					  struct bpf_func_state *state, int insn_idx, int off,
+					  bool var_off)
 {
 	struct bpf_subprog_info *subprog = &env->subprog_info[state->subprogno];
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
@@ -3622,6 +3634,10 @@ static void check_fastcall_stack_contract(struct bpf_verifier_env *env,
 	 * happens at most once per subprogram
 	 */
 	for (i = subprog->start; i < (subprog + 1)->start; ++i) {
+		/* the spills can be too much for the stack, see bpf_find_unproven_after_pass() */
+		aux[insn_idx].pessimized |= aux[i].fastcall_spills_num && env->imprecise;
+		if (aux[i].fastcall_spills_num && var_off)
+			note_pessimized_insn(env, insn_idx);
 		aux[i].fastcall_spills_num = 0;
 		aux[i].fastcall_pattern = 0;
 	}
@@ -7057,7 +7073,9 @@ static int check_stack_access_within_bounds(
 	 * them. An empty range touches no stack and keeps the rewrite enabled.
 	 */
 	if (min_off < max_off)
-		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
+		check_fastcall_stack_contract(env, state, env->insn_idx, min_off,
+					      !tnum_is_const(reg->var_off) ||
+					      env->prev_insn_idx == env->insn_idx);
 
 	/* Note that there is no stack access with offset zero, so the needed stack
 	 * size is -min_off, not -min_off+1.
@@ -13402,6 +13420,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip = true;
 	}
 
+	/* a call that only a speculative state reaches is dead code */
+	if (func_id == BPF_FUNC_override_return && !env->cur_state->speculative)
+		env->prog->kprobe_override = 1;
+
+	if (func_id == BPF_FUNC_tail_call && !env->cur_state->speculative) {
+		/* the other program can access all of it */
+		if (env->prog->expected_attach_type == BPF_TRACE_ITER)
+			env->prog->aux->max_rdonly_access =
+				env->prog->aux->max_rdwr_access = U32_MAX;
+		if (env->prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
+			env->prog->aux->max_tp_access = U32_MAX;
+	}
+
 	if (func_id == BPF_FUNC_tail_call) {
 		/*
 		 * The program which a tail call jumps to returns for this one,
@@ -16515,6 +16546,7 @@ static void need_nospec(struct bpf_verifier_env *env, u32 idx)
 		need_nospec(env, idx + 1);
 		return need_nospec(env, idx + insn->off + 1);
 	}
+	note_pessimized_insn(env, idx);
 	aux->nospec = true;
 	aux->alu_state = 0;
 }
@@ -20749,6 +20781,21 @@ static bool reads_from_unproven(struct bpf_verifier_env *env)
 	return false;
 }
 
+/* The operands of @insn that have more than one value, without the number that is stored */
+static unsigned long operands_with_range(struct bpf_verifier_env *env, const struct bpf_insn *insn)
+{
+	unsigned long use = cur_aux(env)->use_regs & GENMASK(BPF_REG_9, BPF_REG_0), ranges = 0;
+	struct bpf_reg_state *regs = cur_regs(env);
+	int i;
+
+	if (BPF_CLASS(insn->code) == BPF_STX && !bpf_atomic_is_load_acq(insn))
+		use &= BIT(insn->dst_reg);
+	for_each_set_bit(i, &use, BPF_REG_FP)
+		if (regs[i].r64.size)
+			ranges |= BIT(i);
+	return ranges;
+}
+
 static void mark_from_unproven(struct bpf_verifier_env *env, int idx, bool from_unproven)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
@@ -21520,6 +21567,26 @@ static int skip_unproven_insn(struct bpf_verifier_env *env, const struct bpf_ins
 	return 0;
 }
 
+/* These decide where the program can be attached, or what it reads */
+struct prog_requirements {
+	u32 val[12];
+};
+
+static struct prog_requirements get_prog_requirements(struct bpf_verifier_env *env)
+{
+	const struct bpf_prog *prog = env->prog;
+	const struct bpf_prog_aux *aux = prog->aux;
+
+	return (struct prog_requirements){{
+		env->ops->convert_ctx_access ? 0 : aux->max_ctx_offset,
+		aux->max_tp_access, aux->max_rdonly_access, aux->max_rdwr_access,
+		aux->min_rdwr_write, aux->max_rdwr_write, aux->kprobe_write_ctx,
+		prog->type == BPF_PROG_TYPE_EXT && env->seen_direct_write,
+		prog->type == BPF_PROG_TYPE_PERF_EVENT && prog->call_get_stack,
+		prog->tstamp_type_access, prog->kprobe_override, prog->enforce_expected_attach_type,
+	}};
+}
+
 static void free_pushed_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_stack_elem *elem;
@@ -21539,7 +21606,10 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = true, from_unproven;
+	struct prog_requirements prog_requirements, new_requirements;
 	bool again = prev_insn_idx == env->insn_idx;
+	unsigned long ranges;
+	bool stack_args;
 	u32 held;
 
 	mark_verifier_state_scratched(env);
@@ -21610,11 +21680,14 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			env->prev_log_pos = env->log.end_pos;
 		}
 
-		if (bpf_prog_is_offloaded(env->prog->aux)) {
+		if (env->replay) {
 			err = bpf_prog_offload_verify_insn(env, env->insn_idx,
 							   env->prev_insn_idx);
 			if (err)
 				return err;
+		} else if (bpf_prog_is_offloaded(env->prog->aux)) {
+			/* the driver cannot forget what an imprecise state shows */
+			note_pessimized_insn(env, env->insn_idx);
 		}
 
 		sanitize_mark_insn_seen(env);
@@ -21652,6 +21725,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			goto process_bpf_exit;
 		insn_aux->speculative_first |= !insn_aux->seen;
 
+		ranges = operands_with_range(env, insn);
+		stack_args = cur_func(env)->out_stack_arg_cnt;
+
 		err = check_loop_guard(env) ?: check_recursion_guard(env);
 		if (err)
 			return err;
@@ -21660,9 +21736,15 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 		held = held_cnt(state);
 		from_unproven = reads_from_unproven(env);
 		fixups = insn_aux->fixups;
+		prog_requirements = get_prog_requirements(env);
 		env->no_report = state->speculative;
 		err = do_check_insn(env, &do_print_state) ?: bpf_equations_after_insn(env);
 		env->no_report = false;
+		new_requirements = get_prog_requirements(env);
+		/* a join adds values only to a range */
+		if ((ranges || stack_args || again) &&
+		    memcmp(&prog_requirements, &new_requirements, sizeof(new_requirements)))
+			note_pessimized_insn(env, prev_insn_idx);
 		/* a call or an exit gave the state to the flow, the error is from there */
 		if (err < 0 && !state->frame[0])
 			return err;
@@ -25378,12 +25460,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	if (bpf_prog_is_offloaded(env->prog->aux)) {
-		ret = bpf_prog_offload_verifier_prep(env->prog);
-		if (ret)
-			goto skip_full_check;
-	}
-
 	ret = bpf_check_cfg(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -25462,7 +25538,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = mark_fastcall_patterns(env);
+	/* the device runs the insns that the driver was given */
+	ret = bpf_prog_is_offloaded(env->prog->aux) ? 0 : mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.55.0

