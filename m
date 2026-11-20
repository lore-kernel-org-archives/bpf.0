Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160885;
	b=M1DBkcDfevevHYpTP24ENIewMnO7eJ60YUZ6gvyd/9MGox8hTnvFzufXt694PljrkFX9
	 JcAPJJSEPeO4HnyHGKmsaAhANZ+0e0XaEwKUxioEYKsfLe71IX6r51Chi2jHJ8qDzqLIp
	 o4sU8rhVPWEOd855f78yzpO5BTSnncExK9zkPCTfbf2hOlZ+nWc/uv2MSO+JJidqe8uQR
	 /pRei5PvqbYrrYXmmUW3Qy3+JQyFC7Jcym878MvjR8mng1ee3KvCoaDNsldPQyKm2xumT
	 WUWI8hM7pqd02aRZjsQsuky/XPHpTW7EXNLulydMc0CEIZye7QO0U96fOz5FCbGgn3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GSXjuuKceBva7ah/0UXDmOurr2SMpuTanj4I7w/MP00=;
	b=z7HehWr3+i9F5jV13c0EgaAG+CyCxNvrvOmklpTAbQ3xKuBbxykneJOW4+M9bk5zlLJ+
	 8FkiSUFZy81/3WTsDJkNzNfOj3Ln3ynaXNvX24E2UE0Bj/AQ927vSbZ4pi+nf9HPgTB30
	 78aBTwhq/Zv83WWrZxtW0Bg1UXaXz0uT9O0a3crCHVCazb8maddj93kYWjcKUdbc+kHGM
	 Wk821ZfRG8l0Bv/meRT/2YoZcyB7Gymyif9TBfj4c+v9hPIiFnw7mR3cbDyf+OCtlFnhx
	 THeUFMD956hgiF+xM8gqLXbzWTLZn6LBpZuzta3wtFN+zqylR57gNcsf9e8JJZajjAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxDIMkES;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FCD606A333
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0FCD606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RxDIMkES
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde1479f76fso430958a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160884; x=1795765684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSXjuuKceBva7ah/0UXDmOurr2SMpuTanj4I7w/MP00=;
        b=RxDIMkEShDf4dRme+hfNJUYUMmaiDkbAcQnUmAUdxNT87M9I2KlaBVHXcGQBqpalAD
         t47+ZZqo0543MyZJJ2xDdTVeENmSDmNnLMUZJvz9l28UaARLbdbVStel0jwNPlQD6N0d
         HTBGC078l2hmpecobZ0w0D9TWmWcCy7JwpSGs6I0uRBPJTY77EsUUCnMcei/o1BmqhKX
         CgksqqD1mwqVUYR7HQ++vbwG+bd8ycS16u1Gyfjeehufq7T4r8m0BiHW3yihX2Pb+k+F
         nMZnElj6obWtOwoEKKBeCHf8N/q8KGw1sBh+Oc/RKPnqAeEB24nW4tjyi8QUBHwch6Wf
         jT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160884; x=1795765684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSXjuuKceBva7ah/0UXDmOurr2SMpuTanj4I7w/MP00=;
        b=BpnfBvOpScoWBp9gs6sWFoy1ICV+cRUVSL8JWIYMOftw+T+cK9LQIVb1wNdogBvBhI
         XulHUKC07+fFc3yni9wNHsy1Sg1Tuef0/chB+BlH9BPHF5L3IK55lPx3jbDqyngNm4Xw
         P/rrhTLfVkTofZLMsIkS95yuz/HZXon7jd99TQwra39vyGkB4/9iOzz8emUjRyAjQZLP
         2OEHt+GCIcggAfSZaCTl37K9dgMOdGB61wIh5qP7kelrHI/vM84NbOOvPbdbDEYVsMVj
         couBUkdM3vobnvq2y8MCQjT2xe9yKvHpLyXzPsMFBUj4BOhBv13RlNzeluMNHXXNnF0/
         /N6w==
X-Gm-Message-State: APuU4Z9u5sp9WXrksne97JiGTGtqy3y9WNubzeuuYb8Q+xBpYKwJRJY3
	c8JIl2f2FyBcxZQZsmOFw9wLwqrBpRWlqsIzyMWBYAYbx4d894+abmeuhbucqg==
X-Gm-Gg: AZFdTZfrZeKMrin6SOEnsE4GJEKZ0s5fvrsn4RWGT4rKe7WiARmeGLNy6EBAaJW3EAn
	tNFvn2A5OAATXMR1qD0ovcj9BeTlOYBr6zgGVmYR48aLIOW0HcZpVjcesvDYMAhUtDHu/wUS6Ai
	MsRF81vGjTHtHHkKPeJ7ncv/uKGAuGf7sONdkzAgSFItT/kgVr+g6CxLKvqkGNJY05bJ3XBYovL
	Tt/9w1YwDVyg104i606uXCNFHmowqRTW7OpyKFlhnNyTQFFaKm/HcIRHr7MMKVuRL9OOeTINcbd
	xPgYQASinxLrMtBpFPUBX1zqum2h6hLlRk0F67kZZNa5iBb4nhZaBHg4BlDXzMQNCmNwpWQDl6F
	vWpo4V8S7kjWSn/MFqCqLR20mnD8CoWvSuFFqn/QK9q5CcOf/N0WYJdQN8yRpVpmzQUSuI2bYbk
	EH5s+Dv/CfxqtOjVbLIPCr21hYYPaOLRQ7mXbGJWfHzyrLRvtB4Dhix0Z/tYzzR4gwd/8N0A82A
	gCBLxdHluVa26sOqyBsbbcEf9OKGiKzCjqjGH+9V3qvKPs8GSkG+8H+Dxkj7wxsUy/H/+22GKKg
	QCqVKNNHrWAQJI3VUa1q8Xl1y7PJF7BmnS7nkD2ehO/1FAmvywnv6NQPEk0pt1TPZ8iCP9RLfg9
	5vyEMTPOyXQKvs8DBlU6GBHgr9oyut4PubIWo3v/35QQsQMVpMz9foiHsccqCW4ULZmWocmY5La
	kR
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b41c95ce7fmr1918450a91.56.1795160883968;
        Thu, 19 Nov 2026 23:48:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d63728sm6740489a91.8.2026.11.19.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:03 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 36/49] bpf: Do not let a join raise what a program requires
Date: Fri, 20 Nov 2026 07:42:08 +0000
Message-ID: <20261120074430.2704488-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/precision.c       | 44 +++++++++++++++++
 kernel/bpf/precision.h       |  1 +
 kernel/bpf/verifier.c        | 96 ++++++++++++++++++++++++++++++++----
 6 files changed, 138 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 03edbd63664..b60662593ef 100644
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
@@ -1388,6 +1389,7 @@ struct bpf_verifier_env {
 	struct_group_tagged(bpf_env_per_pass, per_pass,
 	int err;			/* the first error */
 	u32 err_insn;
+	bool pessimized;		/* see bpf_partition_for_pessimized() */
 	bool imprecise;			/* a state before the first error is imprecise */
 	bool over_limit;		/* see bpf_check_limits() */
 	bool too_deep;			/* see failing_path_trip() */
@@ -1734,6 +1736,8 @@ void bpf_note_unproven_insn(struct bpf_verifier_env *env,
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
index 59e425431c6..c46f18f04f1 100644
--- a/kernel/bpf/precision.c
+++ b/kernel/bpf/precision.c
@@ -1498,6 +1498,50 @@ int bpf_partition_more(struct bpf_verifier_env *env)
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
index c4a953cf643..cde5c14e730 100644
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
@@ -7058,7 +7074,9 @@ static int check_stack_access_within_bounds(
 	 * them. An empty range touches no stack and keeps the rewrite enabled.
 	 */
 	if (min_off < max_off)
-		check_fastcall_stack_contract(env, state, env->insn_idx, min_off);
+		check_fastcall_stack_contract(env, state, env->insn_idx, min_off,
+					      !tnum_is_const(reg->var_off) ||
+					      env->prev_insn_idx == env->insn_idx);
 
 	/* Note that there is no stack access with offset zero, so the needed stack
 	 * size is -min_off, not -min_off+1.
@@ -13387,6 +13405,19 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
@@ -20725,6 +20756,21 @@ static bool reads_from_unproven(struct bpf_verifier_env *env)
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
@@ -21494,6 +21540,26 @@ static int skip_unproven_insn(struct bpf_verifier_env *env, const struct bpf_ins
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
@@ -21513,7 +21579,10 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 	struct bpf_insn *insns = env->prog->insnsi;
 	int insn_cnt = env->prog->len;
 	bool do_print_state = true, from_unproven;
+	struct prog_requirements prog_requirements, new_requirements;
 	bool again = prev_insn_idx == env->insn_idx;
+	unsigned long ranges;
+	bool stack_args;
 	u32 held;
 
 	mark_verifier_state_scratched(env);
@@ -21584,11 +21653,14 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
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
@@ -21626,6 +21698,9 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
 			goto process_bpf_exit;
 		insn_aux->speculative_first |= !insn_aux->seen;
 
+		ranges = operands_with_range(env, insn);
+		stack_args = cur_func(env)->out_stack_arg_cnt;
+
 		if (err)
 			return err;
 
@@ -21637,9 +21712,15 @@ static int do_check_block(struct bpf_verifier_env *env, int prev_insn_idx)
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
@@ -25296,12 +25377,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
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
@@ -25380,7 +25455,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	ret = mark_fastcall_patterns(env);
+	/* the device runs the insns that the driver was given */
+	ret = bpf_prog_is_offloaded(env->prog->aux) ? 0 : mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
 
-- 
2.55.0

